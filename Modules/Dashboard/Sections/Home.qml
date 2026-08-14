import QtQuick
import QtQuick.Layouts
import qs.Config
import qs.Common

// Home section for the dashboard, landing page when opening
ColumnLayout {
    spacing: Settings.dashboard_spacing

    Card {
        Layout.fillWidth: true 
        Layout.preferredHeight: 90
        StyledText {
            anchors.centerIn: parent
            text: "buttons (wifi, bluetooth...)"
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: 125
        Layout.fillHeight: false
        spacing: Settings.dashboard_spacing

        Card {
            Layout.fillWidth: true
            Layout.fillHeight: true
            StyledText {
                anchors.centerIn: parent
                text: "media (MPRIS)"
            }
        }

        Card {
            Layout.preferredWidth: 190
            Layout.fillHeight: true
            StyledText {
                anchors.centerIn: parent
                text: "time and date"
            }
        }
    }

    Card {
        Layout.fillWidth: true
        Layout.fillHeight: true
        StyledText {
            anchors.centerIn: parent
            text: "Extra / small calendar"
        }    
    }
}