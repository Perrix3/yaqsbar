pragma Singleton

import Quickshell
import qs.Config
import qs.Strings

// Power actions (Lock, Suspend, Log out, Reboot and Shut down)
Singleton {
    id: root

    readonly property var actions: [
        { label: Strings.power_menu_lock_text,      icon: Settings.power_menu_lock_icon,        command: ["hyprlock"] },
        { label: Strings.power_menu_suspend_text,   icon: Settings.power_menu_suspend_icon,     command: ["systemctl", "suspend"] },
        { label: Strings.power_menu_logout_text,    icon: Settings.power_menu_logout_icon,      command: ["hyprshutdown"] },
        { label: Strings.power_menu_reboot_text,    icon: Settings.power_menu_reboot_icon,      command: ["reboot"] },
        { label: Strings.power_menu_shutdown_text,  icon: Settings.power_menu_shutdown_icon,    command: ["shutdown", "now"] }
    ]

    function run(action) {
        Quickshell.execDetached({ command: action.command });
    }
}