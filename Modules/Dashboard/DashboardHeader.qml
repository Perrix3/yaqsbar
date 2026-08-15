import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.Config
import qs.Services
import qs.Common

// Top part of the dashboard
RowLayout {
    spacing: Settings.dashboard_spacing

    // Avatar + username
    Card {
        Layout.preferredWidth: 175
        Layout.fillHeight: true

        ColumnLayout {
            anchors.centerIn: parent
            width: parent.width
            spacing: Settings.dashboard_spacing
            
            // Avatar
            ClippingRectangle {
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: Settings.dashboard_avatar_size
                implicitHeight: Settings.dashboard_avatar_size
                radius: width / 2
                color: Colors.col_background
                border.width: 2
                border.color: Colors.col_highlight

                // Avatar image
                Image {
                    anchors.fill: parent
                    source: User.avatar
                    visible: User.hasAvatar
                    fillMode: Image.PreserveAspectCrop
                    sourceSize: Qt.size(width, height)
                    asynchronous: true
                }
                // Fallback
                IconText { 
                    anchors.centerIn: parent
                    visible: !User.hasAvatar
                    text: "\uf007"
                }
            }

            // Username
            StyledText {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Settings.dashboard_username_size
                text: User.name
            }
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