import QtQuick
import qs.Config
import qs.Services
import qs.Common

OverlayPanel {
    panelName: "dashboard"
    modal:  Settings.dashboard_close_on_click_away
    dim:    Settings.dashboard_dim_background

    Item {
        Rectangle {
            id: panel

            implicitWidth: Settings.dashboard_width
            implicitHeight: Settings.dashboard_height

            x: Settings.bar_popup_gap
            y: Math.max(Settings.bar_popup_gap, Math.min(parent.height - height - Settings.bar_popup_gap, Panels.anchorY - height / 2))

            radius: Settings.dashboard_radius
            color: Colors.col_background
        }
    }

}