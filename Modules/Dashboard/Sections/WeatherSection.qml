import QtQuick
import QtQuick.Layouts
import qs.Config
import qs.Common
import qs.Services
import qs.Strings

// Weather section for the dashboard, shows todays weather and forecast
ColumnLayout {
    id: root

    spacing: Settings.dashboard_spacing

    readonly property int hourStart: {
        const h = Weather.hourly;
        const t = Weather.data?.current?.time;
        if (!h?.time || !t) return -1;
        return h.time.indexOf(t.slice(0, 13) + ":00");
    }

    readonly property var hours: {
        const h = Weather.hourly;
        if (!h?.time || hourStart < 0) return [];

        const end = Math.min(h.time.length, hourStart + Settings.weather_hourly_count);
        const out = [];
        for (let i = hourStart; i < end; i++)
            out.push({
                time: new Date(h.time[i]),
                temp: Math.round(h.temperature_2m[i]),
                code: h.weather_code[i],
                rain: h.precipitation_probability?.[i] ?? -1,
            });
            return out;
    }

    readonly property var days: {
        const d = Weather.daily;
        if (!d?.time) return [];

        const out = [];
        for (let i = 0; i < d.time.length; i++)
            out.push({
                date: new Date(d.time[i] + "T00:00"),
                min: Math.round(d.temperature_2m_min[i]),
                max: Math.round(d.temperature_2m_max[i]),
                code: d.weather_code[i],
                rain: d.precipitation_probability_max?.[1] ?? -1,
            });
            return out;
    }

    readonly property int weekMin: days.length ? Math.min(...days.map(d => d.min)) : 0
    readonly property int weekMax: days.length ? Math.max(...days.map(d => d.max)) : 1

    function frac(t: real): real {
        const span = weekMax - weekMin;
        return span <= 0 ? 0 : (t - weekMin) / span;
    }

    function mix(a: color, b: color, f:real): color {
        return Qt.rgba(a.r + (b.r - a.r) * f,
                       a.g + (b.g - a.g) * f,
                       a.b + (b.b - a.b) * f, 1);
    }

    function tempColor(t: real): color {
        return mix(Colors.col_cold, Colors.col_hot, Math.max(0, Math.min(1, frac(t))));
    }

    function isDayLight(t: date): bool {
        const d = Weather.daily;
        if(!d?.sunrise) return true;
        const i = d.time.indexOf(Qt.formatDateTime(t, "yyyy-MM-dd"));
        if (i < 0) return true;
        return t >= new Date(d.sunrise[i]) && t < new Date(d.sunset[i]);
    }

    function sunTime(day: int, rise: bool): string {
        const a = rise ? Weather.daily?.sunrise : Weather.daily?.sunset;
        return a?.[day] ? Qt.formatDateTime(new Date(a[day]), Strings.weather_sun_format) : "--";
    }

    component Placeholder: StyledText {
        anchors.centerIn: parent
        visible: !Weather.valid
        text: Weather.ok ? Strings.weather_loading : Strings.weather_unavailable
        color: Colors.col_secondary
    }

    component Detail: ColumnLayout {
        id: detail

        property string label
        property string icon
        property string value

        Layout.fillWidth: true
        Layout.preferredWidth: 1
        spacing: 0
        
        StyledText {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: detail.label
            font.pixelSize: Settings.weather_label_font_size
            color: Colors.col_secondary
            elide: Text.ElideRight
        }
        IconText {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: detail.icon
            font.pixelSize: Settings.weather_detail_icon_size
            color: Colors.col_weather
        }
        StyledText {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: detail.value
            font.pixelSize: Settings.weather_detail_icon_size
            color: Colors.col_weather
        }
    }

    // Todays weather/details like humidity, wind speed...
    Card {
        Layout.fillWidth: true
        Layout.preferredHeight: Settings.weather_now_height
        border.color: Colors.col_weather

        Placeholder {}

        RowLayout {
            anchors.fill: parent
            visible: Weather.valid
            spacing: Settings.dashboard_spacing

            Detail {
                label: Strings.weather_feels_label
                icon: Settings.weather_feels_icon
                value: Math.round(Weather.feelsLike) + Weather.unitSymbol
            }
            Detail {
                label: Strings.weather_humidity_label
                icon: Settings.weather_humidity_icon
                value: Weather.humidity + "%"
            }
            Detail {
                label: Strings.weather_wind_label
                icon: Settings.weather_wind_icon
                value: Math.round(Weather.wind) + " " + Strings.weather_wind_suffix
            }
            Detail {
                label: Strings.weather_sunrise_label
                icon: Settings.weather_sunrise_icon
                value: root.sunTime(0, true)
            }
            Detail {
                label: Strings.weather_sunset_label
                icon: Settings.weather_sunset_icon
                value: root.sunTime(0, false)
            }
        }
    }

    // Today's weather by hour
    Card {
        Layout.fillWidth: true
        Layout.preferredHeight: Settings.weather_hourly_height
        border.color: Colors.col_weather

        Placeholder {}

        RowLayout {
            anchors.fill: parent
            visible: Weather.valid
            spacing: Settings.weather_hour_spacing

            Repeater {
                model: root.hours

                ColumnLayout {
                    id: hour

                    required property var modelData
                    required property int index

                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 2

                    StyledText {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        text: hour.index === 0 ? Strings.weather_now
                            : Qt.formatDateTime(hour.modelData.time, Strings.weather_hour_format)
                        font.pixelSize: Settings.weather_hour_font_size
                        color: hour.index === 0 ? Colors.col_weather : Colors.col_secondary
                    }

                    IconText {
                        Layout.alignment: Qt.AlignHCenter
                        text: WeatherIcons.forCode(hour.modelData.code,
                                                    root.isDayLight(hour.modelData.time))
                        font.pixelSize: Settings.weather_hour_icon_size
                        color: Colors.col_weather
                    }

                    StyledText {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        text: hour.modelData.temp + "°"
                        font.pixelSize: Settings.weather_hour_font_size
                        color: Colors.col_main
                    }

                    StyledText {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        opacity: hour.modelData.rain > 0 ? 1 : 0
                        text: hour.modelData.rain + "%"
                        font.pixelSize: Settings.weather_hour_font_size
                        color: Colors.col_secondary
                    }
                }
            }
        }
    }

    // Forecast
    Card {
        Layout.fillWidth: true
        Layout.fillHeight: true
        border.color: Colors.col_weather

        Placeholder {}

        ColumnLayout {
            anchors.fill: parent
            visible: Weather.valid
            spacing: 0

            Repeater {
                model: root.days
                
                RowLayout {
                    id: day

                    required property var modelData
                    required property int index

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: Settings.dashboard_info_spacing

                    StyledText {
                        Layout.preferredWidth: Settings.weather_day_name_width
                        text: day.index === 0 ? Strings.weather_today
                            : Qt.formatDateTime(day.modelData.date, Strings.weather_day_format)
                        font.pixelSize: Settings.weather_day_font_size
                        color: day.index === 0 ? Colors.col_main : Colors.col_secondary
                    }

                    IconText {
                        text: WeatherIcons.forCode(day.modelData.code, true)
                        font.pixelSize: Settings.weather_day_icon_size
                        color: Colors.col_weather
                    }

                    StyledText {
                        Layout.preferredWidth: Settings.weather_day_rain_width
                        text: day.modelData.rain > 0 ? day.modelData.rain + "%" : ""
                        font.pixelSize: Settings.weather_day_font_size
                        color: Colors.col_secondary
                    }

                    StyledText {
                        Layout.preferredWidth: Settings.weather_day_temp_width
                        horizontalAlignment: Text.AlignRight
                        text: day.modelData.min + "°"
                        font.pixelSize: Settings.weather_day_font_size
                        color: Colors.col_secondary
                    }

                    // Temperature bar
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: Settings.weather_range_height
                        radius: height / 2
                        color: Colors.col_background3

                        Rectangle {
                            x: parent.width * root.frac(day.modelData.min)
                            width: Math.max(height, parent.width *
                                    (root.frac(day.modelData.max) - root.frac(day.modelData.min)))
                            height: parent.height
                            radius: parent.radius
                            
                            gradient: Gradient {
                                orientation: Gradient.Horizontal
                                GradientStop {position: 0; color: root.tempColor(day.modelData.min)}
                                GradientStop {position: 1; color: root.tempColor(day.modelData.max)}
                            }
                        }

                        Rectangle {
                            visible: day.index === 0 && Weather.valid
                            x: parent.width * Math.max(0, Math.min(1, root.frac(Weather.temp))) - width / 2
                            anchors.verticalCenter: parent.verticalCenter
                            width: Settings.weather_now_dot_size
                            height: width
                            radius: width / 2
                            color: Colors.col_main
                            border.width: 1
                            border.color: Colors.col_background2
                        }
                    }

                    StyledText {
                        Layout.preferredWidth: Settings.weather_day_temp_width
                        text: day.modelData.max + "°"
                        font.pixelSize: Settings.weather_day_font_size
                        color: Colors.col_main
                    }
                }
            }
        }
    }
}