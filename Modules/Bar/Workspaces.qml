import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.Config
import qs.Common

// Hyprland workspaces
// Show small tooltip with workspace number/name when hovering over
Rectangle {
    id: root

    property HyprlandMonitor monitor

    implicitWidth: Settings.bar_width
    implicitHeight: col.implicitHeight + 5
    color: Colors.col_background2
    radius: Settings.bar_widget_radius

    property var hoveredItem: null
    property var shownItem: null

    readonly property string openSpecial: monitor?.lastIpcObject?.specialWorkspace?.name ?? ""

    function wsLabel(ws) {
        if (!ws)
            return "";
        if (ws.name.startsWith("special:"))
            return ws.name.slice(8);
        return ws.name === String(ws.id) ? `Workspace ${ws.id}` : ws.name;
    }

    function trackHover(item, isHovered) {
        if (isHovered)
            root.hoveredItem = item;
        else if (root.hoveredItem === item)
            root.hoveredItem = null;
    }

    function releaseItem(item) {
        if (root.hoveredItem === item)
            root.hoveredItem = null;
        if (root.shownItem === item)
            root.shownItem = null;
    }

    onHoveredItemChanged: if (hoveredItem)
        shownItem = hoveredItem;

    ScriptModel {
        id: specialModel
        objectProp: "id"
        values: Hyprland.workspaces.values.filter(w => w.name.startsWith("special:"))
    }

    ScriptModel {
        id: normalModel
        objectProp: "id"
        values: Hyprland.workspaces.values
            .filter(w => !w.name.startsWith("special:") && w.monitor?.id === root.monitor?.id)
            .sort((a, b) => a.id - b.id)
    }

    Column {
        id: col

        anchors.centerIn: parent
        spacing: Settings.bar_ws_widget_spacing

        // Special workspaces
        Repeater {
            model: specialModel

            BarWidgetButton {
                id: specialBtn
                required property var modelData

                readonly property var  ws:     modelData
                readonly property bool isOpen: root.openSpecial === ws.name

                radius:    Settings.bar_ws_widget_radius
                color:     isOpen ? Colors.col_main : "transparent"
                textColor: isOpen ? Colors.col_background2 : Colors.col_main
                text:      Settings.bar_ws_widget_special_icon

                onClicked: {
                    const special = ws.name.slice(8);
                    // Already open here? Just toggle it shut. Otherwise focus this monitor
                    if (root.openSpecial !== ws.name)
                        Hyprland.dispatch(`hl.dsp.focus({ monitor = "${root.monitor.name}" })`);
                    Hyprland.dispatch(`hl.dsp.workspace.toggle_special("${special}")`);
                }
                onHoveredChanged: root.trackHover(specialBtn, hovered)
                Component.onDestruction: root.releaseItem(specialBtn)
            }
        }

        // divider: collapses to nothing when there are no specials 
        Item {
            width:   Settings.bar_widget_width
            height:  Settings.bar_ws_divider_height
            visible: specialModel.values.length > 0

            Rectangle {
                anchors.centerIn: parent
                width:   parent.width * 0.6
                height:  1
                color:   Colors.col_main
                opacity: 0.3
            }
        }

        // Normal workspaces
        Repeater {
            model: normalModel

            BarWidgetButton {
                id: wsBtn

                required property var modelData

                readonly property var  ws:       modelData
                readonly property bool isActive: ws.active
                readonly property bool isUrgent: ws.urgent
                
                color:      isActive ? Colors.col_main : "transparent"
                radius:     Settings.bar_ws_widget_radius
                textColor:  isActive ? Colors.col_background2 : Colors.col_main
                text: isUrgent ? Settings.bar_ws_widget_urgent_icon : isActive ? Settings.bar_ws_widget_active_icon : Settings.bar_ws_widget_normal_icon

                onClicked: ws.activate()

                onHoveredChanged: root.trackHover(wsBtn, hovered)
                Component.onDestruction: root.releaseItem(wsBtn)
            }
        }
    }

    BarPopup {
        id: tooltip
        anchorItem: root.shownItem
        visible:    root.hoveredItem !== null

        Text {
            color:          Colors.col_main
            font.family:    Settings.bar_widget_font
            font.pixelSize: Settings.bar_widget_font_size
            text:           root.wsLabel(root.shownItem?.ws)
        }
    }

    // On scroll, cycle through existing workspaces
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton

        property int accum: 0

        onWheel: wheel => {
            accum += wheel.angleDelta.y;
            while (Math.abs(accum) >= 120) {
                const dir = accum > 0 ? 1 : -1;
                accum -= dir * 120;
                Hyprland.dispatch(`hl.dsp.focus({ workspace = "e${dir > 0 ? '+' : '-'}1" })`);
            }
        }
    }
}