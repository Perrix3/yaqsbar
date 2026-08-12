pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.Config

// Pending Arch package updates. Count only.
Singleton {
    id: root

    component UpdateSource: Process {
        property int    count:          0
        property bool   ok:             true  // false = check failed
        property bool   enabled:        true
        property var    okExitCodes:    [0]
    
        stdout: StdioCollector {
            onStreamFinished: {
                const out = text.trim();
                count = out === "" ? 0 : out.split("\n").length;
            }
        }
        onExited: code => ok = okExitCodes.includes(code)

        function refresh(): void {
            if(!enabled) {count = 0; ok = true; return;}
            if(!running) running = true;
        }
    }


    UpdateSource {
        id: pacmanSrc
        enabled: Settings.update_pacman
        command: ["checkupdates"]
        okExitCodes: [0, 2]     // 2 = nothing
    }

    UpdateSource {
        id: aurSrc
        enabled: Settings.update_aur
        okExitCodes: [0, 1]     // 1 = nothing
        command: ["sh", "-c", "for h in yay paru pikaur trizen pacaur aurman; do command -v $h >/dev/null && exec $h -Qua; done"]
    }

    UpdateSource {
        id: flatpakSrc
        enabled: Settings.update_flatpak
        command: ["flatpak", "remote-ls", "--updates", "--columns=application"]
    }

    readonly property alias pacman: pacmanSrc
    readonly property alias aur: aurSrc
    readonly property alias flatpak: flatpakSrc

    readonly property int   count:      pacmanSrc.count + aurSrc.count + flatpakSrc.count
    readonly property bool  ok:         pacmanSrc.ok && aurSrc.ok && flatpakSrc.ok
    readonly property bool  checking:   pacmanSrc.running || aurSrc.running || flatpakSrc.running
    property string updateState: ""
    readonly property bool updating: updateState === "running"

    function refresh(): void {
        pacmanSrc.refresh();
        aurSrc.refresh();
        flatpakSrc.refresh();
    }

    Process {
        id: updater
        command: [...Settings.update_terminal, Settings.update_script]
        environment: ({
            UPD_PACMAN:     Settings.update_pacman     ? "1" : "0",
            UPD_AUR:        Settings.update_aur        ? "1" : "0",
            UPD_FLATPAK:    Settings.update_flatpak    ? "1" : "0",
            UPD_NOCONFIRM:  Settings.update_no_confirm ? "1" : "0",
            QS_SHELL_DIR:   Quickshell.shellDir,
        })

        onExited: {
            if (root.updating) root.updateState = "";
            root.refresh();
        }
    }

    function runUpdate(): void {
        if (updater.running) return;    // don't stack terminals
        updateState = "running";
        updater.running = true;
        recheck.restart();
    }

    Timer {
        id: poll
        interval: Settings.updates_poll_interval
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refresh()
    }

    Timer {
        id: recheck
        interval: 120000
        onTriggered: root.refresh()
    }
}