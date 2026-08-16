import QtQuick
import QtQuick.Layouts
import qs.Config
import qs.Common
import qs.Services
import qs.Modules.Dashboard

// Home section for the dashboard, landing page when opening
ColumnLayout {
    spacing: Settings.dashboard_spacing

    Card {
        Layout.fillWidth: true 
        Layout.preferredHeight: Settings.dashboard_home_section1_height
        StyledText {
            anchors.centerIn: parent
            text: "buttons (wifi, bluetooth...)"
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: Settings.dashboard_home_section2_height
        Layout.fillHeight: false
        spacing: Settings.dashboard_spacing

        MediaPlayer {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        // Clock
        Card {
            Layout.preferredWidth: Settings.dashboard_home_clock_width
            Layout.fillHeight: true
            border.color: Colors.col_clock_card
            ColumnLayout {
                anchors.centerIn: parent
                width: parent.width
                spacing: Settings.dashboard_home_clock_spacing

                // Time
                StyledText {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: Time.time
                    color: Colors.col_clock_card
                    font.pixelSize: Settings.dashboard_time_font_size
                }
                // Timezone UTC
                StyledText {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: Time.timezone
                    color: Colors.col_clock_card
                    font.pixelSize: Settings.dashboard_timezone_font_size
                }
                // Date
                StyledText {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: Time.short_date
                    color: Colors.col_clock_card
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