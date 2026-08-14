import QtQuick
import Quickshell.Hyprland
import qs.Config
import qs.Common
import qs.Services

Item {
    id: root

    property HyprlandMonitor monitor

    implicitWidth:  button.implicitWidth
    implicitHeight: button.implicitHeight

    BarWidgetButton {
        id: button

        readonly property bool isOpen: Panels.isOpen("dashboard", root.monitor?.name ?? "")

        implicitWidth:  Settings.bar_widget_width + 5
        implicitHeight: Settings.bar_widget_height + 5

        text:   Settings.bar_dashboard_icon
        accent: Colors.col_dashboard
        active: isOpen

        onClicked: Panels.toggle("dashboard", root.monitor?.name ?? "", root.mapToItem(null, 0, root.height / 2).y)
    }
}