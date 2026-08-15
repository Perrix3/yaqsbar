pragma Singleton

import Quickshell
import QtQuick

// OS icons, and search by id
Singleton {
    readonly property string fallback: "\uf17c"

    readonly property var byId: ({
        "arch":         "\uf303",
        "manjaro":      "\uf312",
        "endeavouros":  "\uf322",
        "artix":        "\uf31f",
        "garuda":       "\uf337",
    })

    function forId(id: string, idLike: string): string {
        return byId[id] ?? (idLike.includes("arch") ? byId["arch"] : fallback);
    }
}