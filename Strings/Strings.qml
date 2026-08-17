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

    // Weather
    readonly property string weather_error:             "Unavailable"       // Unavailable
    readonly property string weather_never:             "Never updated"     // Never updated
    readonly property string weather_updated_prefix:    "Updated"           // Updated
    readonly property string weather_time_format:       "hh:mm"             // Weather time format
    readonly property string weather_now:               "Now"               // Now
    readonly property string weather_today:             "Today"             // Today
    readonly property string weather_loading:           "Loading..."        // Loading
    readonly property string weather_unavailable:       "No forecast data"  // No forecast data
    readonly property string weather_wind_suffix:       "km/h"              // Wind speed suffix
    readonly property string weather_hour_format:       "hh"                // Hour format
    readonly property string weather_day_format:        "ddd"               // Day format
    readonly property string weather_sun_format:        "hh:mm"             // Sun time format
    readonly property string weather_feels_label:       "Feels like"        // Feelslike
    readonly property string weather_humidity_label:    "Humidity"          // Humidity
    readonly property string weather_wind_label:        "Wind"              // Wind
    readonly property string weather_sunrise_label:     "Sunrise"           // Sunrise
    readonly property string weather_sunset_label:      "Sunset"            // Sunset
}