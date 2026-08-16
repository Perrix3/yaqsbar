pragma Singleton

import Quickshell
import QtQuick

Singleton {
    // Power menu actions
    readonly property string power_menu_lock_text:"Lock"
    readonly property string power_menu_suspend_text:"Suspend"
    readonly property string power_menu_logout_text:"Log out"
    readonly property string power_menu_reboot_text:"Reboot"
    readonly property string power_menu_shutdown_text:"Shut down"

    // Clock
    readonly property string date_format_long:  "dddd d 'of' MMMM yyyy" // Long date format
    readonly property string date_format_short: "ddd d MMMM"            // Short date format
    readonly property string timezone_prefix:   "UTC"                   // Timezone prefix

    // Updater
    readonly property string updates_error:     "Update check failed"   // Update check failed
    readonly property string updates_none:      "Up to date"            // Up to date
    readonly property string updates_one:       "1 update"              // Singular update
    readonly property string updates_many:      "updates"               // Plural updates
    readonly property string updates_pacman:    "Pacman"                // Pacman 
    readonly property string updates_aur:       "AUR"                   // Aur
    readonly property string updates_flatpak:   "Flatpak"               // Flatpak
    readonly property string updates_failed:    "error"                 // per-source check failure

    // Dashboard
    readonly property string sysinfo_packages:  "packages"          // Packages
    readonly property string media_idle:        "Nothing playing"   // Nothing playing
}