pragma Singleton

import Quickshell
import QtQuick

Singleton {
    // General settings
    readonly property string    font_main:              "Fira Code"                 // Normal font
    readonly property int       font_size_normal:       12                          // Normal font size
    readonly property string    font_icon:              "Symbols Nerd Font Mono"    // Font used by icons / IconText
    readonly property int       font_size_icon:         12                          // Icon font size
    readonly property string    locale:                 "en_GB"                     // Locale used by time and later on, language
    readonly property int       bar_popup_border_width: 1                           // Popup's border width
    readonly property bool      panel_dim:              true                        // Dim background when panel is open
    readonly property real      overlay_dim_opacity:    0.5                         // Overlay panel background dim
    readonly property string    color_theme:            "latte"                     // Colour themes (currently cattpuccin 'frappe' 'latte' 'mocha' 'macchiato')
    readonly property string    user_avatar:            ""                          // User avatar
    readonly property int       general_border_width:   3                           // General border width

    // Bar widgets and order, divided in 3 sections
    readonly property var   bar_widgets_start:  ["archupdates", "workspaces"]
    readonly property var   bar_widgets_center: ["dashboard"]
    readonly property var   bar_widgets_end:    ["clock", "power"]

    // Bar settings
    readonly property bool  bar_anchor_top:     true            // Bar's top anchor
    readonly property bool  bar_anchor_bottom:  true            // Bar's bottom anchor
    readonly property bool  bar_anchor_left:    true            // Bar's left anchor
    readonly property bool  bar_anchor_right:   false           // Bar's right anchor
    readonly property int   bar_width:          42              // Bar width (change with bar position)
    readonly property int   bar_height:         1080            // Bar height (change with bar position)
    readonly property int   bar_padding_start:  8               // gap before the first widget
    readonly property int   bar_padding_end:    8               // gap after the last widget
    readonly property int   bar_widget_spacing: 4               // gap between widgets in a section

    // General bar widget settings
    readonly property string    bar_widget_font:        "Fira Code" // Bar widget's font
    readonly property int       bar_widget_font_size:   14          // Bar widget's font size
    readonly property int       bar_widget_width:       20          // Bar widget's width
    readonly property int       bar_widget_height:      20          // Bar widget's height
    readonly property int       bar_widget_radius:      20          // Bar widget's radius
    readonly property int       bar_ws_divider_height:  7           // Bar widget's divider height
    readonly property int       bar_popup_padding:      8           // Bar widget's popup padding
    readonly property int       bar_popup_radius:       8           // Bar widget's popup radius
    readonly property int       bar_popup_gap:          6           // space between the bar edge and the popup

    // Workspaces bar widget settings
    readonly property int       bar_ws_widget_radius:       10          // Workspace's widget icon radius
    readonly property int       bar_ws_widget_spacing:      2           // Workspace's widget spacing between workspaces
    readonly property int       bar_ws_widget_wheel_step:   1           // Workspace's widget scroll step
    readonly property string    bar_ws_widget_normal_icon:  "\uf111"    // Workspace's widget normal workspace icon
    readonly property string    bar_ws_widget_active_icon:  "\uf192"    // Workspace's widget active workspace icon
    readonly property string    bar_ws_widget_urgent_icon:  "\uf06a"    // Workspace's widget urgent workspace icon
    readonly property string    bar_ws_widget_special_icon: "\uf0d0"    // Workspace's widget special workspace icon

    // Clock/Time settings
    readonly property bool clock_24h:                   true    // false → 12h with AM/PM line
    readonly property int  bar_clock_font_size:         16      // hours/minutes
    readonly property int  bar_clock_suffix_font_size:  9       // AM/PM line
    readonly property int  bar_clock_spacing:           0       // Clock spacing

    // Power menu widget settings
    readonly property string    bar_power_icon:             "\uf011"    // Bar's power button icon
    readonly property int       power_menu_padding:         15          // Power menu's padding
    readonly property int       power_menu_spacing:         15          // Power menu's spacing
    readonly property int       power_action_size:          90          // Power menu action's size
    readonly property int       power_action_icon_size:     28          // Power menu action icon size

    // Updater
    readonly property int       update_poll_interval:  1800000              // 30 min
    readonly property bool      update_pacman:          true                // Update pacman with script
    readonly property bool      update_aur:             false                // Update aur with script
    readonly property bool      update_flatpak:         true                // Update flatpak with script
    readonly property bool      update_no_confirm:      true                // Use no-confirm on update script
    readonly property var       update_terminal:        ["kitty", "--"]     // Terminal that runs the script
    readonly property string    update_script:          Quickshell.shellPath("Scripts/Updater.sh")

    // Icons
    readonly property string    bar_updater_icon:           "\uf303"    // Updater's arch icon
    readonly property string    power_menu_lock_icon:       "\uf023"    // Power menu's lock icon
    readonly property string    power_menu_suspend_icon:    "\uf186"    // Power menu's suspend icon
    readonly property string    power_menu_logout_icon:     "\uf2f5"    // Power menu's log out icon
    readonly property string    power_menu_reboot_icon:     "\uf021"    // Power menu's reboot icon
    readonly property string    power_menu_shutdown_icon:   "\uf011"    // Power menu's shut down icon
    readonly property string    bar_dashboard_icon:         "\uf0c9"    // Dashboard's bar icon

    // Dashboard
    readonly property int       dashboard_height:                   750         // Dashboard panel height
    readonly property int       dashboard_width:                    600         // Dashboard panel width
    readonly property int       dashboard_radius:                   15          // Dashboard panel radius (rounder edges)
    readonly property bool      dashboard_close_on_click_away:      false       // Close dashboard when clicking away from it
    readonly property bool      dashboard_dim_background:           false       // Dim screens when dashboard is open (needs close on click away to be true)
    readonly property int       dashboard_padding:                  5           // Dashboard's padding
    readonly property int       dashboard_card_radius:              15          // Dashboard card's radius
    readonly property int       dashboard_spacing:                  5           // Dashboard's spacing
    readonly property int       dashboard_home_section1_height:     100         // Dashboard home section 1 (buttons) height (height fights with section 3)
    readonly property int       dashboard_home_section2_height:     130         // Dashboard home section 2 (media and clock) height (height fights with section 3)
    readonly property int       dashboard_home_clock_width:         190         // Dashboard home clock width (fights for with with media)
    readonly property int       dashboard_home_clock_spacing:       2           // Dashboard home clock's spacing
    readonly property int       dashboard_time_font_size:           50          // Dashboard home clock's size
    readonly property int       dashboard_timezone_font_size:       14          // Dashboard timezone's font size
    readonly property int       dashboard_date_font_size:           20          // Dashboard home date's font size
    readonly property int       dashboard_avatar_size:              130         // Dashboard header avatar size
    readonly property int       dashboard_username_size:            20          // Dashboard header username font size
    readonly property int       dashboard_info_spacing:             4           // Dashboard sysinfo spacing
    readonly property int       dashboard_info_icon_width:          18          // Dashboard sysinfo icon size
    readonly property int       dashboard_panel_border_width:       2           // Dashboard panel border width
    readonly property int       sysinfo_font_size:                  17          // Dashboard sysinfo font size
    readonly property string    sysinfo_kernel_icon:                "\uf17c"    // Dashboard sysinfo kernel icon
    readonly property string    sysinfo_wm_icon:                    "\uf2d0"    // Dashboard sysinfo wm icon
    readonly property string    sysinfo_pkg_icon:                   "\uf487"    // Dashboard sysinfo pkg icon
    readonly property string    sysinfo_uptime_icon:                "\uf017"    // Dashboard sysinfo uptime icon
    readonly property string    sysinfo_fallback_icon:              "\uf007"    // Dashboard sysinfo fallback icon

    // Dashboard Media
    readonly property string    media_follow_app:           "spotify"       // Player to follow (leave as "" for auto)
    readonly property var       media_exclude_apps:         ["kdeconnect"]  // Ignored players (leave empty for none)
    readonly property int       media_position_interval:    500             // Position interval
    readonly property int       media_button_size:          24              // Button size
    readonly property int       media_button_spacing:       6               // Button spacing
    readonly property int       media_progress_height:      4               // Progress bar height
    readonly property int       media_app_font_size:        10              // App name font size
    readonly property int       media_title_font_size:      16              // Title font size
    readonly property int       media_album_font_size:      14              // Album + artist font size
    readonly property int       media_time_font_size:       14              // Media time font size
    readonly property string    media_shuffle_icon:         "\uf074"        // Shuffle icon
    readonly property string    media_prev_icon:            "\uf048"        // Previous icon
    readonly property string    media_play_icon:            "\uf04b"        // Play icon
    readonly property string    media_pause_icon:           "\uf04c"        // Pause icon
    readonly property string    media_next_icon:            "\uf051"        // Next icon
    readonly property string    media_loop_off_icon:        "\u{f0457}"     // Loop off icon
    readonly property string    media_loop_all_icon:        "\u{f0456}"     // Loop all icon
    readonly property string    media_loop_one_icon:        "\u{f0458}"     // Loop one icon
    readonly property string    media_placeholder_icon:     "\uf001"        // Placeholder icon
    readonly property int       media_handle_size:          10              // Progress bar slider handle size
    readonly property int       media_sliding_delay:        1500            // Sliding text animation delay
    readonly property real      media_sliding_speed:        25              // Sliding text animation speed

    // Weather
    readonly property string    weather_city:               "Seville"   // Location for weather
    readonly property string    weather_language:           "en"        // Language for weather
    readonly property real      weather_latitude:           0           // Latitude for weather (leave as 0 for auto check with city)
    readonly property real      weather_longitude:          0           // Longitude for weather (leave as 0 for auto check with city)
    readonly property string    weather_unit:               "celsius"   // Degree unit
    readonly property string    weather_wind_unit:          "kmh"       // Speed unit
    readonly property int       weather_forecast_days:      7           // Forecast days
    readonly property int       weather_poll_interval:      900000      // Weather poll interval
    readonly property int       weather_retry_interval:     60000       // Retry interval
    readonly property int       weather_timeout:            10          // Timeout
    readonly property int       weather_temp_font_size:     44          // Temperatur font size
    readonly property int       weather_unit_font_size:     18          // Degree unit font size
    readonly property int       weather_icon_font_size:     64          // Weather icon font size
    readonly property int       weather_small_font_size:    12          // Small font size
    readonly property int       weather_spacing:            4           // Weather spacing
    readonly property int       weather_icon_spacing:       6           // Weather icon spacing
    readonly property string    weather_reload_icon:        "\uf021"    // Reload icon
    readonly property string    weather_rain_icon:          "\uf043"    // Rain icon
    readonly property int       weather_now_height:         95          // 'Now' section height
    readonly property int       weather_hourly_height:      140         // 'Hourly' section height
    readonly property int       weather_hourly_count:       8           // Next hours forecast to show
    readonly property int       weather_hour_width:         52          // 'Hourly' section width
    readonly property int       weather_hour_spacing:       4           // 'Hourly' section spacing
    readonly property int       weather_detail_font_size:   14          // 'Detail' section font size
    readonly property int       weather_detail_icon_size:   20          // 'Detail' section icon size
    readonly property int       weather_hour_font_size:     15          // Hour font size
    readonly property int       weather_hour_icon_size:     30          // Hour icon size
    readonly property int       weather_day_font_size:      14          // Day font size
    readonly property int       weather_day_icon_size:      20          // Day icon size
    readonly property int       weather_day_name_width:     46          // Day name width
    readonly property int       weather_day_rain_width:     40          // Day rain width
    readonly property int       weather_day_temp_width:     34          // Day temperature width
    readonly property int       weather_range_height:       6           // Range height
    readonly property int       weather_now_dot_size:       8           // Now dot size 
    readonly property int       weather_label_font_size:    11          // Label font size
    readonly property string    weather_feels_icon:         "\ue350"    // Feels like icon
    readonly property string    weather_humidity_icon:      "\ue373"    // Humidity icon
    readonly property string    weather_wind_icon:          "\ue34b"    // Wind icon
    readonly property string    weather_sunrise_icon:       "\ue34c"    // Sunrise icon
    readonly property string    weather_sunset_icon:        "\ue34d"    // Sunset icon
}