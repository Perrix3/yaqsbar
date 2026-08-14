import QtQuick
import qs.Config
import qs.Services
import qs.Common

OverlayPanel {
    panelName: "power"
    Item {
        Rectangle {
            anchors.centerIn: parent
            implicitWidth: actions.implicitWidth + Settings.power_menu_padding * 2
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
                            Panels.close();
                            Power.run(modelData);
                        }
                    }
                }
            }
        }
    }
}