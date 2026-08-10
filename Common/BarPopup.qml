import QtQuick
import Quickshell
import qs.Config

PopupWindow {
    id: root
    
    required property Item anchorItem
    default property alias content: body.data
    readonly property real barEdge: anchorItem?.QsWindow?.window
        ? anchorItem.mapFromItem(null, anchorItem.QsWindow.window.width, 0).x
        : (anchorItem?.width ?? 0)

    anchor.item:    anchorItem
    anchor.rect.x:  barEdge ? anchorItem.width : 0
    anchor.edges:   Edges.Right
    anchor.gravity: Edges.Right
    anchor.adjustment: PopupAdjustment.SlideY   // keep it on screen near edges

    implicitWidth:  body.implicitWidth  + Settings.bar_popup_padding * 2
    implicitHeight: body.implicitHeight + Settings.bar_popup_padding * 2
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color:  Colors.col_background2
        radius: Settings.bar_popup_radius

        Item {
            id: body
            anchors.centerIn: parent
            implicitWidth:  childrenRect.width
            implicitHeight: childrenRect.height
        }
    }
}