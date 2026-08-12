import QtQuick
import qs.Config

Item {
    width:   Settings.bar_widget_width
    height:  Settings.bar_ws_divider_height

    Rectangle {
    anchors.centerIn: parent
    width:   parent.width * 0.6
    height:  1
    color:   Colors.col_main
    opacity: 0.3
    }
}