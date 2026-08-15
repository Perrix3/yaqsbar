import Quickshell        // Variants, PanelWindow, Scope, Quickshell.screens
import QtQuick           // Rectangle, Row, Text, Item — anything you draw
import Quickshell.Hyprland
import qs.Config         // Colors, Settings

Variants {
    model: Quickshell.screens // reactive: monitors plugged/unplugged handled for you

    PanelWindow {
        id: win
        property var modelData 
        screen: modelData

        anchors { 
            top: Settings.bar_anchor_top; 
            bottom: Settings.bar_anchor_bottom; 
            left: Settings.bar_anchor_left; 
            right: Settings.bar_anchor_right
        }
        implicitWidth: Settings.bar_width
        color: Colors.col_background

        // Bar border, only shows on the free edge
        Rectangle {
            anchors {left: parent.left; right: parent.right; top: parent.top}
            height: Settings.general_border_width
            color:   Colors.col_accent
            visible: !Settings.bar_anchor_top
        }
        Rectangle {
            anchors {left: parent.left; right: parent.right; bottom: parent.bottom}
            height: Settings.general_border_width
            color:   Colors.col_accent
            visible: !Settings.bar_anchor_bottom
        }
        Rectangle {
            anchors {left: parent.left; top: parent.top; bottom: parent.bottom}
            width: Settings.general_border_width
            color:   Colors.col_accent
            visible: !Settings.bar_anchor_left
        }
        Rectangle {
            anchors {right: parent.right; top: parent.top; bottom: parent.bottom}
            width: Settings.general_border_width
            color:   Colors.col_accent
            visible: !Settings.bar_anchor_right
        }

        BarSection {
            anchors { top: parent.top; topMargin: Settings.bar_padding_start; horizontalCenter: parent.horizontalCenter }
            widgets: Settings.bar_widgets_start
            barScreen: win.screen
        }

        BarSection {
            anchors { verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter }
            widgets: Settings.bar_widgets_center
            barScreen: win.screen
        }

        BarSection {
            anchors { bottom: parent.bottom; bottomMargin: Settings.bar_padding_end; horizontalCenter: parent.horizontalCenter }
            widgets: Settings.bar_widgets_end
            barScreen: win.screen
        }

    }
    
}