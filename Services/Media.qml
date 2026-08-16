pragma Singleton

import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import qs.Config

// Mpris service
Singleton {
    id: root

    property MprisPlayer current: null
    readonly property bool active: current !== null
    readonly property bool canFocus: current?.canRaise ?? false

    property real position: 0

    onCurrentChanged: position = current?.position ?? 0
    Component.onCompleted: root.pick()

    Timer {
        interval: Settings.media_position_interval
        running: root.current?.isPlaying ?? false
        repeat: true
        triggeredOnStart: true
        onTriggered: root.position = root.current?.position ?? 0
    }

    function matches(player, pattern: string): bool {
        if(!pattern || !player) return false;
        const p = pattern.toLowerCase();
        return (player.desktopEntry ?? "").toLowerCase().includes(p)
            || (player.dbusName     ?? "").toLowerCase().includes(p)
            || (player.identity     ?? "").toLowerCase().includes(p)
    }

    function allowed(player): bool {
        return !Settings.media_exclude_apps.some(x => root.matches(player, x));
    }

    function pick(): void {
        const ps = Mpris.players.values.filter(p => root.allowed(p));
        if(ps.length === 0) { root.current = null; return;}

        const followed = ps.find(p => root.matches(p, Settings.media_follow_app));
        if (followed) { root.current = followed; return;}

        if (root.current && ps.includes(root.current) && root.current.isPlaying) return;
        root.current = ps.find(p => p.isPlaying)
                    ?? (ps.includes(root.current) ? root.current : ps[0]);
    }

    Connections {
        target: Mpris.players
        function onValuesChanged() { root.pick()}
    }

    Instantiator {
        model: Mpris.players
        delegate: QtObject {
            required property MprisPlayer modelData
            property Connections conn: Connections {
                target: modelData
                function onIsPlayingChanged() {root.pick()}
                function onTrackChanged() {
                    if(modelData === root.current) root.position = modelData.position;
                }
            }
        }
    }
}