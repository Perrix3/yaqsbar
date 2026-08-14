import QtQuick
import Quickshell.Hyprland
import qs.Config
import qs.Common
import qs.Services

Item {
    id: root

    property HyprlandMonitor monitor    // Bar.qml assigns this to every widget

    implicitWidth:  button.implicitWidth
    implicitHeight: button.implicitHeight

    BarWidgetButton {
        id: button

        readonly property bool isOpen: Panels.isOpen("power", root.monitor?.name ?? "")

        text:      Settings.bar_power_icon
        color:     isOpen ? Colors.col_main : Colors.col_background2
        textColor: isOpen ? Colors.col_background2 : Colors.col_main

        onClicked: Panels.toggle("power", root.monitor?.name ?? "")
    }
}