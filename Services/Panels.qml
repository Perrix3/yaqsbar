pragma Singleton

import Quickshell

// General panel logic: toggle, close, isOpen
Singleton {
    id: root

    property string open:       ""  // "power", "dashboard" which window is open
    property string screen:     ""  // Which screen
    property real   anchorY:    0   // Y where panel centers on

    function toggle(name, screenName, y) {
        if (root.open == name && root.screen === screenName) {
            root.close(); 
            return
        }
        root.screen     = screenName;
        root.anchorY    = y ?? 0
        root.open       = name;
    }

    function close() {
        root.open = ""
    }

    function isOpen(name, screenName) {
        return root.open === name && root.screen === screenName;
    }
}