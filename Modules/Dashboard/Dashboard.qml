import QtQuick
import QtQuick.Layouts
import qs.Config
import qs.Services
import qs.Common
import qs.Modules.Dashboard.Sections

// Dashboard panel
OverlayPanel {
    panelName: "dashboard"
    modal:  Settings.dashboard_close_on_click_away
    dim:    Settings.dashboard_dim_background

    Item {
        property Item maskItem: panel

        Rectangle {
            id: panel

            implicitWidth:  Settings.dashboard_width
            implicitHeight: Settings.dashboard_height
            border.width:   Settings.general_border_width
            border.color:   Colors.col_accent

            x: Settings.bar_popup_gap
            y: Math.max(Settings.bar_popup_gap, Math.min(parent.height - height - Settings.bar_popup_gap, Panels.anchorY - height / 2))

            radius: Settings.dashboard_radius
            color: Colors.col_background

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: Settings.dashboard_padding
                spacing: Settings.dashboard_spacing

                // Top section
                DashboardHeader {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    Layout.preferredHeight: 175
                }

                // Tabs
                DashboardTabs {
                    id: tabs
                    Layout.fillWidth: true
                }

                StackLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    currentIndex: tabs.current

                    // Tab sections
                    Home {}
                    Item {} //Calendar {}
                    WeatherSection {}
                    Item {} //System {}
                }
            }
        }
    }
}