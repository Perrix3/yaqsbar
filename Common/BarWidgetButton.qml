import QtQuick
import Quickshell
import qs.Config

// Reusable button for the bar
Rectangle {
    id: root

    property string text: ""
    property bool active: false
    property bool expanded: false
    property color accent: Colors.col_highlight // widget's identity colour
    property color textColor: root.accent
    readonly property bool hovered: mouseArea.containsMouse

    signal clicked()
    signal rightClicked()
    signal scrolled(int delta)

    implicitWidth:  Settings.bar_widget_width
    implicitHeight: Settings.bar_widget_height
    radius:         Settings.bar_widget_radius

    color: root.active  ? Colors.activeBg(root.accent)
         : root.hovered ? Colors.hoverBg(root.accent)
         :                "transparent"

    Behavior on color { ColorAnimation { duration: 120 } }

    IconText {
        id: label

        anchors.centerIn:   parent
        font.pixelSize:     Settings.bar_widget_font_size
        color:              root.textColor

        text: root.text
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => mouse.button === Qt.RightButton
        ? root.rightClicked()
        : root.clicked()

        property int wheelAccum: 0

        onWheel: wheel => {
            root.wheelAccum += wheel.angleDelta.y;
            while (Math.abs(root.wheelAccum) >= 120) {
                const dir = root.wheelAccum > 0 ? 1 : -1;
                root.wheelAccum -= dir * 120;
                root.scrolled(dir);
            }
        }
    }
}