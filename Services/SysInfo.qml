pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import Qt.labs.folderlistmodel

// System info for mini fastfetch on dashboard
Singleton {
    id: root

    readonly property string    os:         field(osFile.text(), "PRETTY_NAME") || "linux"
    readonly property string    osId:       field(osFile.text(), "ID") || "linux"
    readonly property string    osIdLike:   field(osFile.text(), "ID_LIKE")
    readonly property string    kernel:     kernelFile.text().trim()
    readonly property string    wm:         Quickshell.env("XDG_CURRENT_DESKTOP") ?? ""
    readonly property int       packages:   pkgs.count

    // OS
    FileView {
        id: osFile
        path: "/etc/os-release"
        blockLoading: true
    }
    // Kernel
    FileView {
        id: kernelFile
        path: "/proc/sys/kernel/osrelease"
        blockLoading: true
    }

    // Pacman
    FolderListModel {
        id: pkgs
        folder: "file:///var/lib/pacman/local"
        showDirs: true
        showFiles: false
        showDotAndDotDot: false
        sortField: FolderListModel.Unsorted
    }

    function field(text: string, key: string): string {
        const m = text.match(new RegExp("^" + key + '="?([^"\\n]*)"?', "m"));
        return m ? m[1] : "";
    }
}