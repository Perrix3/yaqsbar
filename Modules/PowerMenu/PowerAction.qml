import QtQuick
import qs.Config
import qs.Common

Rectangle {
    id: root

    property string icon: ""
    property string label: ""
    property color accent: Colors.col_highlight
    readonly property bool hovered: mouse.containsMouse

    signal clicked()

    implicitWidth:  Settings.power_action_size
    implicitHeight: Settings.power_action_size
    radius: Settings.bar_popup_radius
    color: hovered ? root.accent : Colors.col_background2

    Behavior on color { ColorAnimation { duration: 120 } }

    Column {
        anchors.centerIn: parent
        spacing: 6

        IconText {
            width: root.width
            horizontalAlignment: Text.AlignHCenter
            text: root.icon
            font.pixelSize: Settings.power_action_icon_size
            color: root.hovered ? Colors.col_on_highlight : Colors.col_main
        }

        StyledText {
            width: root.width
            horizontalAlignment: Text.AlignHCenter
            text: root.label
            color: root.hovered ? Colors.col_on_highlight : Colors.col_main
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}