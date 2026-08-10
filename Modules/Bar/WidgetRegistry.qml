pragma Singleton

import Quickshell
import QtQuick

// For future widget reordering
// Just a diferent way to call on widgets for now
Singleton {
    readonly property var widgets: ({
        "workspaces":   workspacesComp,
        "clock":        clockComp,
        "power":        powerComp,
    })

    property Component workspacesComp:  Component { Workspaces {} }
    property Component powerComp:       Component { Power {} }
    property Component clockComp:       Component { Clock {} }

}