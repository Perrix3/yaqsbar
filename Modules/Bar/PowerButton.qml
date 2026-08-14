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

        text:   Settings.bar_power_icon
        accent: Colors.col_power
        active: isOpen

        onClicked: Panels.toggle("power", root.monitor?.name ?? "")
    }
}