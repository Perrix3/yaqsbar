import QtQuick
import qs.Config

// Reusable dashboard cards
Rectangle {
    default property alias  content: body.data
    property int            padding: Settings.dashboard_padding

    color:  Colors.col_background2
    radius: Settings.dashboard_card_radius
    border.width: Settings.dashboard_panel_border_width
    border.color: Colors.col_border

    Item {
        id: body
        anchors.fill:       parent
        anchors.margins:    parent.padding
    }
}