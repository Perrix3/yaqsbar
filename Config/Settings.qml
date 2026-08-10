pragma Singleton

import Quickshell
import QtQuick

Singleton {
    // General settings
    readonly property string    font_main:          "Fira Code"                 // Normal font
    readonly property int       font_size_normal:   12                          // Normal font size
    readonly property string    font_icon:          "Symbols Nerd Font Mono"    // Font used by icons / IconText
    readonly property int       font_size_icon:     12                          // Icon font size
    
    // Bar widgets and order, divided in 3 sections
    readonly property var   bar_widgets_start:  ["workspaces"]
    readonly property var   bar_widgets_center: [""]
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
    readonly property string    power_menu_lock_icon:       "\uf023"    // Power menu's lock icon
    readonly property string    power_menu_suspend_icon:    "\uf186"    // Power menu's suspend icon
    readonly property string    power_menu_logout_icon:     "\uf2f5"    // Power menu's log out icon
    readonly property string    power_menu_reboot_icon:     "\uf021"    // Power menu's reboot icon
    readonly property string    power_menu_shutdown_icon:   "\uf011"    // Power menu's shut down icon
}