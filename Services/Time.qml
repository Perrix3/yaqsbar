pragma Singleton

import Quickshell
import QtQuick
import qs.Config
import qs.Strings

// Wall clock
Singleton {
    id: root

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    readonly property string long_date: clock.date.toLocaleDateString(Qt.locale(Settings.locale), Strings.date_format_long)

    readonly property bool pm: clock.hours >= 12

    readonly property string hours: Settings.clock_24h
        ? pad(clock.hours)
        : String(((clock.hours + 11) % 12) + 1)   // 0 → 12, 13 → 1

    readonly property string minutes: pad(clock.minutes)

    readonly property string suffix: Settings.clock_24h ? "" : (pm ? "PM" : "AM")

    function pad(n) {
        return n < 10 ? "0" + n : "" + n;
    }
}