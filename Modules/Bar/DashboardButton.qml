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

        text:      Settings.bar_dashboard_icon
        color:     isOpen ? Colors.col_main : Colors.col_background2
        textColor: isOpen ? Colors.col_background2 : Colors.col_main

        onClicked: Panels.toggle("dashboard", root.monitor?.name ?? "", root.mapToItem(null, 0, root.height / 2).y)
    }
}