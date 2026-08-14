pragma Singleton

import Quickshell

// General panel logic: toggle, close, isOpen
Singleton {
    id: root

    property string open:   ""  // "power", "dashboard" which window is open
    property string screen: ""  // Which screen

    function toggle(name, screenName) {
        if (root.open == name && root.screen === screenName) {
            root.close(); 
            return
        }
        root.screen = screenName;
        root.open = name;
    }

    function close() {
        root.open = ""
    }

    function isOpen(name, screenName) {
        return root.open === name && root.screen === screenName;
    }
}