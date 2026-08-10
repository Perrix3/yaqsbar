import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Config
import qs.Services

Variants {
    model: Quickshell.screens

    LazyLoader {
        id: loader
        required property var modelData

        // Only loads when open and only in target screen
        active: Power.menuOpen && Power.menuScreen == modelData.name

        PanelWindow {
            screen: loader.modelData

            anchors {top: true; bottom: true; left: true; right: true}
            exclusiveZone: 0
            exclusionMode: ExclusionMode.Ignore
            color: "transparent"

            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

            // Dim, if clicking away closes it
            Rectangle {
                anchors.fill: parent
                color: Qt.rgba(0, 0, 0, 0.5)

                MouseArea {
                    anchors.fill: parent
                    onClicked: Power.closeMenu()
                }
            }

            FocusScope {
                anchors.fill: parent
                focus: true

                Keys.onEscapePressed: Power.closeMenu()

                Rectangle {
                    anchors.centerIn: parent
                    implicitWidth:  actions.implicitWidth  + Settings.power_menu_padding * 2
                    implicitHeight: actions.implicitHeight + Settings.power_menu_padding * 2
                    radius: Settings.bar_popup_radius
                    color: Colors.col_background

                    Row {
                        id: actions
                        anchors.centerIn: parent
                        spacing: Settings.power_menu_spacing

                        Repeater {
                            model: Power.actions

                            PowerAction {
                                required property var modelData

                                icon:  modelData.icon
                                label: modelData.label

                                onClicked: {
                                    Power.closeMenu();
                                    Power.run(modelData);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}