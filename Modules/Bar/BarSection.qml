import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.Config

Column {
    id: root

    required property var widgets      // list of widget names
    required property var barScreen    // win.screen

    spacing: Settings.bar_widget_spacing

    Repeater {
        model: root.widgets

        Loader {
            required property string modelData

            sourceComponent: WidgetRegistry.widgets[modelData] ?? null
            onLoaded: item.monitor = Qt.binding(() =>
                Hyprland.monitors.values.find(m => m.name === root.barScreen.name) ?? null)
        }
    }
}