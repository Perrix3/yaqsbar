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

    readonly property bool pm: clock.hours >= 12 // Check if pm

    readonly property string hours: Settings.clock_24h // 24h clock
        ? pad(clock.hours)
        : String(((clock.hours + 11) % 12) + 1)   // 0 → 12, 13 → 1

    readonly property string minutes: pad(clock.minutes) // Minutes

    readonly property string suffix: Settings.clock_24h ? "" : (pm ? "PM" : "AM") // AM / PM

    function pad(n) {
        return n < 10 ? "0" + n : "" + n;
    }

    readonly property string time: hours + ":" + minutes + (suffix ? " " + suffix : "") // dashboard home clock
    readonly property string short_date: clock.date.toLocaleDateString(Qt.locale(Settings.locale), Strings.date_format_short) // short date

    readonly property string timezone: { // timezone
        const mins = -clock.date.getTimezoneOffset();
        const sign = mins < 0 ? "-" : "+";
        const abs = Math.abs(mins);
        const h = Math.floor(abs / 60);
        const m = abs % 60;
        return Strings.timezone_prefix + " " + sign + h + (m ? ":" + pad(m) : "");
    }
}