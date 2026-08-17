import QtQuick
import QtQuick.Layouts
import qs.Config
import qs.Services
import qs.Strings
import qs.Common

// Current weather
Card {
    id: root
    Layout.preferredWidth: 170
    Layout.fillHeight: true
    border.color: Colors.col_weather
    z: 1
    
    // Reload button
    BarWidgetButton {
        id: reloadBtn
        anchors.top: parent.top
        anchors.right: parent.right
        z: 2
        text: Settings.weather_reload_icon
        accent: Colors.col_weather
        opacity: Weather.loading ? 0.4 : 1
        onClicked: Weather.refresh()

        Behavior on opacity { NumberAnimation { duration: 120}}
    }

    // Reload button hover tooltip
    Rectangle {
        anchors.top: reloadBtn.bottom
        anchors.right: reloadBtn.right
        anchors.topMargin: Settings.weather_spacing
        z: 3

        visible: reloadBtn.hovered
        implicitWidth: tip.implicitWidth + Settings.bar_popup_padding * 2
        implicitHeight: tip.implicitHeight + Settings.bar_popup_padding
        radius: Settings.bar_popup_radius
        color: Colors.col_background3
        border.width: Settings.bar_popup_border_width
        border.color: Colors.col_accent

        StyledText {
            id: tip

            anchors.centerIn: parent
            font.pixelSize: Settings.weather_small_font_size
            color: Colors.col_secondary

            text: !Weather.ok           ? Strings.weather_error
                : !Weather.lastUpdated  ? Strings.weather_never
                : Strings.weather_updated_prefix + " "
                  + Qt.formatDateTime(Weather.lastUpdated, Strings.weather_time_format)
        }
    }

    // Weather
    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: reloadBtn.height
        spacing: Settings.weather_spacing

        Item { Layout.fillHeight: true }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: Settings.weather_icon_spacing
        
            Row {
                spacing: 0

                // Temperature
                StyledText {
                    id: temp
                    text: Weather.valid ? Math.round(Weather.temp) : "--"
                    font.pixelSize: Settings.weather_temp_font_size
                    color: Colors.col_weather
                }
                // Unit symbol
                StyledText {
                    anchors.baseline: temp.baseline
                    text: Weather.unitSymbol
                    font.pixelSize: Settings.weather_unit_font_size
                    color: Colors.col_weather
                }
            }

            // Weather icon
            IconText {
                text: Weather.valid ? WeatherIcons.forCode(Weather.code, Weather.isDay)
                                    : WeatherIcons.fallback
                font.pixelSize: Settings.weather_icon_font_size
                color: Colors.col_weather
            }
        }

        // Rain %
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            visible: Weather.valid && Weather.rain >= 0
            spacing: Settings.dashboard_info_spacing
            IconText {
                text: Settings.weather_rain_icon
                color: Colors.col_secondary
                font.pixelSize: Settings.weather_small_font_size
            }
            StyledText {
                text: Weather.rain + "%"
                color: Colors.col_secondary
                font.pixelSize: Settings.weather_small_font_size
            }
        }

        // City name
        StyledText {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: Weather.city
            color: Colors.col_secondary
            font.pixelSize: Settings.weather_small_font_size
            elide: Text.ElideRight
        }

        Item { Layout.fillHeight: true}
    }
}