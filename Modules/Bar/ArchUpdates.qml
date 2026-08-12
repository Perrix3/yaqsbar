import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts
import qs.Config
import qs.Common
import qs.Services
import qs.Strings

Item {
    id: root

    property HyprlandMonitor monitor    // Bar.qml assigns this to every widget
    readonly property bool hasUpdates: ArchUpdates.ok && ArchUpdates.count > 0

    implicitWidth:  Settings.bar_width
    implicitHeight: button.implicitHeight

    BarWidgetButton {
        id: button
        anchors.horizontalCenter: parent.horizontalCenter

        text:      Settings.bar_updater_icon
        color:     hasUpdates ? Colors.col_main : Colors.col_background2
        textColor: hasUpdates ? Colors.col_background2 : Colors.col_main
        opacity:   ArchUpdates.ok ? 1.0 : 0.5

        onClicked: ArchUpdates.runUpdate()
    }

    BarPopup {
        anchorItem: button
        visible: button.hovered

        GridLayout {
            columns: 2

            StyledText {
                visible: ArchUpdates.pacman.enabled
                text: Strings.updates_pacman
                color: ArchUpdates.pacman.ok ? Colors.col_main : Colors.col_red
            }
            StyledText {
                visible: ArchUpdates.pacman.enabled
                text: ArchUpdates.pacman.ok ? ArchUpdates.pacman.count : Strings.updates_failed
                color: ArchUpdates.pacman.ok ? Colors.col_main : Colors.col_red
            }

            StyledText {
                visible: ArchUpdates.aur.enabled
                text: Strings.updates_aur
                color: ArchUpdates.pacman.ok ? Colors.col_main : Colors.col_red
            }
            StyledText {
                visible: ArchUpdates.aur.enabled
                text: ArchUpdates.aur.ok ? ArchUpdates.aur.count : Strings.updates_failed
                color: ArchUpdates.aur.ok ? Colors.col_main : Colors.col_red
            }

            StyledText {
                visible: ArchUpdates.flatpak.enabled
                text: Strings.updates_flatpak
                color: ArchUpdates.flatpak.ok ? Colors.col_main : Colors.col_red
            }
            StyledText {
                visible: ArchUpdates.flatpak.enabled
                text: ArchUpdates.flatpak.ok ? ArchUpdates.flatpak.count : Strings.updates_failed
                color: ArchUpdates.flatpak.ok ? Colors.col_main : Colors.col_red
            }
        }
    }
}