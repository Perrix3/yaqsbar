import QtQuick
import Quickshell.Hyprland
import qs.Config
import qs.Common
import qs.Services

Item {
    id: root

    property HyprlandMonitor monitor    // Bar.qml assigns this to every widget

    implicitWidth:  Settings.bar_widget_width
    implicitHeight: col.implicitHeight

    Column {
        id: col

        anchors.horizontalCenter: parent.horizontalCenter
        spacing: Settings.bar_clock_spacing

        StyledText {
            text: Time.hours
            font.pixelSize: Settings.bar_clock_font_size
        }

        StyledText {
            text: Time.minutes
            font.pixelSize: Settings.bar_clock_font_size
        }

        StyledText {
            text: Time.suffix
            font.pixelSize: Settings.bar_clock_suffix_font_size
            visible: text !== ""          // collapses entirely in 24h mode
        }
    }

     MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
    }

    BarPopup {
        id: tooltip
        anchorItem: col
        visible: mouse.containsMouse

        StyledText {
            text:   Time.long_date
        }
    }
}