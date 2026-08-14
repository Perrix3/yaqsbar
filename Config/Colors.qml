pragma Singleton

import Quickshell
import QtQuick

Singleton {
    // Active theme
    readonly property var pal: Themes.flavors[Settings.color_theme] ?? Themes.mocha

    // Neutrals
    readonly property color col_background:     pal.base        // bar, dashboard, power menu
    readonly property color col_background2:    pal.surface0    // popups and other elevated surfaces
    readonly property color col_border:         pal.surface1    // popup borders
    readonly property color col_border2:        pal.surface2    // dividers

    // Text
    readonly property color col_main:           pal.text        // Texts
    readonly property color col_secondary:      pal.subtext0    // secondary labels

    // Widget identity
    readonly property color col_workspaces:     pal.green
    readonly property color col_clock:          pal.blue
    readonly property color col_updates:        pal.peach
    readonly property color col_dashboard:      pal.lavender
    readonly property color col_power:          pal.red

    // Status
    readonly property color col_error:          pal.red
    readonly property color col_warning:        pal.yellow
    readonly property color col_success:        pal.green

    // Generic accent
    readonly property color col_highlight:      pal.mauve
    readonly property color col_highlight2:     hoverBg(col_highlight)
    readonly property color col_on_highlight:   pal.base

    function tintBg(c: color, amount: real): color {
        return Qt.tint(pal.base, Qt.rgba(c.r, c.g, c.b, amount));
    }
    function hoverBg(c: color): color {
        return tintBg(c, 0.15);
    }
    function activeBg(c: color): color {
        return tintBg(c, 0.30);
    }
}