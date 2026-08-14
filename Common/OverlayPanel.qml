import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.Config
import qs.Services

// Reusable popup panel, used for power menu, dashboard... etc.
// if modal = true, clicking away closes it
// if modal && Settings.panel_dim = true, background is dimmed by Settings.overlay_dim_opacity
Variants {
    id: root
    model: Quickshell.screens

    property string panelName: ""
    property bool modal: true
    property bool dim: true
    default property Component contentComponent

    LazyLoader {
        id: loader
        required property var modelData

        active: Panels.open === root.panelName

        PanelWindow{
            id: window
            readonly property bool isTarget: Panels.screen === loader.modelData.name
            screen: loader.modelData

            anchors {top: true; bottom: true; left: true; right: true}
            exclusiveZone: 0
            exclusionMode: ExclusionMode.Ignore
            color: "transparent"
            
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

            HyprlandFocusGrab {
                active: root.modal && window.isTarget && window.visible
                windows: [window]
                onCleared: Panels.close()
            }

            mask: root.modal ? null : contentMask

            Region {
                id: contentMask
                item: contentLoader.item?.children[0] ?? null
            }

            Rectangle {
                anchors.fill: parent
                visible: root.modal
                color: root.dim && Settings.panel_dim 
                        ? Qt.rgba(0, 0, 0, Settings.overlay_dim_opacity)
                        : "transparent"

                MouseArea {
                    anchors.fill: parent
                    onClicked: Panels.close()   
                }
            }

            FocusScope {
                anchors.fill: parent
                focus: true
                Keys.onEscapePressed: Panels.close()

                Loader{
                    id: contentLoader
                    active: window.isTarget
                    anchors.fill: parent
                    sourceComponent: root.contentComponent
                }
            }
        }
    }
}