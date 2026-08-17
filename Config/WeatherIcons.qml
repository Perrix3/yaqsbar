pragma Singleton

import Quickshell
import QtQuick

// Weather icons for day and night, and search by id
Singleton {
    readonly property string fallback: "\ue374"

    readonly property var byGroup: ({
        "clear":    { day: "\ue30d", night: "\ue32b" },
        "partly":   { day: "\ue302", night: "\ue37e" },
        "cloudy":   { day: "\ue312", night: "\ue312" },
        "fog":      { day: "\ue303", night: "\ue346" },
        "drizzle":  { day: "\ue30b", night: "\ue379" },
        "rain":     { day: "\ue308", night: "\ue376" },
        "showers":  { day: "\ue309", night: "\ue377" },
        "sleet":    { day: "\ue3ad", night: "\ue3ad" },
        "snow":     { day: "\ue30a", night: "\ue378" },
        "storm":    { day: "\ue30f", night: "\ue37b" },
    })

    function groupFor(code: int): string {
        if (code < 0)                   return "";
        if (code === 0)                 return "clear";
        if (code <= 2)                  return "partly";
        if (code === 3)                 return "cloudy";
        if (code === 45 || code === 48) return "fog";
        if (code === 56 || code === 57) return "sleet";
        if (code <= 55)                 return "drizzle";
        if (code === 66 || code === 67) return "sleet";
        if (code <= 65)                 return "rain";
        if (code <= 77)                 return "snow";
        if (code <= 82)                 return "showers";
        if (code <= 86)                 return "snow";
        return "storm";
    }

    function forCode(code: int, isDay: bool): string {
        const e = byGroup[groupFor(code)];
        return e ? (isDay? e.day : e.night) : fallback;
    }
}