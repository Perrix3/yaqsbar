import QtQuick
import qs.Config

// Reusable dashboard cards
Rectangle {
    default property alias  content: body.data
    property int            padding: Settings.dashboard_padding

    color:  Colors.col_background2
    radius: Settings.dashboard_card_radius

    Item {
        id: body
        anchors.fill:       parent
        anchors.margins:    parent.padding
    }
}