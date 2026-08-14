import QtQuick
import qs.Config
import qs.Common

// Dashboard tabs, current tab is underlined
Item {
    id: root

    property int current: 0
    readonly property var sections: ["Home", "Calendar", "Weather", "System"]

    implicitHeight: row.height + 6

    Row {
        id: row
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 28

        Repeater {
            id: repeater
            model: root.sections

            StyledText {
                required property int index
                required property string modelData

                text: modelData
                color: index === root.current ? Colors.col_main : Colors.col_secondary

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.current = parent.index
                }
            }
        }
    }

    Rectangle {
        id: indicator
        readonly property Item target: repeater.count > 0 ? repeater.itemAt(root.current) : null

        x: target ? row.x + target.x : 0
        width: target ? target.width : 0
        y: row.height +2
        height: 2
        radius: 1
        color: Colors.col_highlight

        property bool ready: false
        Timer {
            running: true
            interval: 50
            onTriggered: indicator.ready = true
        }

        Behavior on x { enabled: indicator.ready; NumberAnimation { duration: 160; easing.type: Easing.OutCubic}}
        Behavior on width { enabled: indicator.ready; NumberAnimation { duration: 160; easing.type: Easing.OutCubic}}
    }
}