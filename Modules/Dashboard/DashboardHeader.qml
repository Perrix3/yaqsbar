import QtQuick
import QtQuick.Layouts
import qs.Config
import qs.Common

// Top part of the dashboard
RowLayout {
    spacing: Settings.dashboard_spacing

    Card {
        Layout.preferredWidth: 175
        Layout.fillHeight: true

        StyledText {
            anchors.centerIn: parent
            text: "user"
        }
    }

    Card {
        Layout.fillWidth: true
        Layout.fillHeight: true
        
        StyledText {
            anchors.centerIn: parent
            text: "sys info"
        }
    }

    Card {
        Layout.preferredWidth: 170
        Layout.fillHeight: true
        
        StyledText {
            anchors.centerIn: parent
            text: "weather"
        }
    }

    BarWidgetButton {
        Layout.alignment: Qt.AlignTop
        accent: Colors.col_highlight
        text: "\uf013"
    }
}