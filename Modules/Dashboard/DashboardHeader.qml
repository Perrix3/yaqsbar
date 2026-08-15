import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import qs.Config
import qs.Services
import qs.Strings
import qs.Common

// Top part of the dashboard
RowLayout {
    id: root
    spacing: Settings.dashboard_spacing

    // Sysinfo rows
    component InfoRow: RowLayout {
        id: row

        property string icon
        property string value

        Layout.fillWidth: true
        spacing: Settings.dashboard_info_spacing

        IconText {
            text: row.icon
            font.pixelSize: Settings.sysinfo_font_size
            color: Colors.col_sysinfo
            Layout.preferredWidth: Settings.dashboard_info_icon_width
        }

        StyledText {
            text: row.value
            font.pixelSize: Settings.sysinfo_font_size
            color: Colors.col_sysinfo
            elide: Text.ElideRight
            Layout.fillWidth: true
        }
    }

    // Get uptime on open
    FileView { 
        id: uptimeFile
        path: "/proc/uptime"
        blockLoading: true
    }

    // Format uptime text
    readonly property string uptimeText: {
        const s = parseInt(uptimeFile.text().split(" ")[0]) || 0;
        const d = Math.floor(s / 86400);
        const h = Math.floor(s % 86400 / 3600);
        const m = Math.floor(s % 3600 / 60);
        return d > 0 ? d + "d " + h + "h"
             : h > 0 ? h + "h " + m + "m"
             :         m + "m";
    }

    // Avatar + username
    Card {
        Layout.preferredWidth: 175
        Layout.fillHeight: true
        border.color: Colors.col_avatar

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
                border.color: Colors.col_avatar

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
                    color: Colors.col_avatar
                    visible: !User.hasAvatar
                    text: "\uf007"
                }
            }

            // Username
            StyledText {
                Layout.fillWidth: true
                color: Colors.col_avatar
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Settings.dashboard_username_size
                text: User.name
            }
        }
    }

    // System info (mini fastfetch)
    Card {
        Layout.fillWidth: true
        Layout.fillHeight: true
        border.color: Colors.col_sysinfo
        
        ColumnLayout {
            anchors.centerIn: parent
            width: parent.width
            spacing: Settings.dashboard_info_spacing

            InfoRow { icon: OsIcons.forId(SysInfo.osId, SysInfo.osIdLike);  value: SysInfo.os }
            InfoRow { icon: Settings.sysinfo_kernel_icon;                   value: SysInfo.kernel }
            InfoRow { icon: Settings.sysinfo_wm_icon;                       value: SysInfo.wm }
            InfoRow { icon: Settings.sysinfo_pkg_icon;                      value: SysInfo.packages + " " + Strings.sysinfo_packages }
            InfoRow { icon: Settings.sysinfo_uptime_icon;                   value: root.uptimeText }
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