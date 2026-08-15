import QtQuick
import QtQuick.Layouts
import qs.Config
import qs.Common
import qs.Services

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

        // Clock
        Card {
            Layout.preferredWidth: 190
            Layout.fillHeight: true
            ColumnLayout {
                anchors.centerIn: parent
                width: parent.width
                spacing: 2

                // Time
                StyledText {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: Time.time
                    color: Colors.col_clock
                    font.pixelSize: Settings.dashboard_time_font_size
                }
                // Timezone UTC
                StyledText {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: Time.timezone
                    color: Colors.col_clock
                    font.pixelSize: Settings.dashboard_timezone_font_size
                }
                // Date
                StyledText {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: Time.short_date
                    color: Colors.col_clock
                    font.pixelSize: Settings.dashboard_date_font_size
                }
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