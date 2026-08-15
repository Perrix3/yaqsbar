pragma Singleton

import Quickshell
import QtQuick
import qs.Config

// Get username and avatar service
Singleton {
    id: root
    readonly property string name: Quickshell.env("USER") ?? "" // Grab username from quickshell
    readonly property string home: Quickshell.env("HOME") ?? "" // Grab home from quickshell

    // Avatars, settings override avatar
    readonly property var avatarCandidates: [ ...(Settings.user_avatar ? [Settings.user_avatar] : []), home + "/.face", home + "/.face.icon", "/var/lib/AccountsService/icons/" + name]

    property int index: 0
    readonly property bool  hasAvatar:  probe.status === Image.Ready
    readonly property url   avatar:     hasAvatar ? probe.source : ""

    Image {
        id: probe
        asynchronous: true
        sourceSize: Qt.size(1, 1)
        source: root.index < root.avatarCandidates.length
                ? "file://" + root.avatarCandidates[root.index]
                : ""
        onStatusChanged: if (status === Image.Error) root.index++
    }
}