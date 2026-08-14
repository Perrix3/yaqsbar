pragma Singleton

import Quickshell
import QtQuick

// For future widget reordering
// Just a diferent way to call on widgets for now
Singleton {
    readonly property var widgets: ({
        "archupdates":  updaterComp,
        "workspaces":   workspacesComp,
        "dashboard":    dashboardComp,
        "clock":        clockComp,
        "power":        powerComp,
    })

    property Component updaterComp:     Component { ArchUpdates {} }
    property Component workspacesComp:  Component { Workspaces {} }

    property Component dashboardComp:   Component { DashboardButton {} }

    property Component powerComp:       Component { PowerButton {} }
    property Component clockComp:       Component { Clock {} }

}