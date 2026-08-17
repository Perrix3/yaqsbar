pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.Config

// Weather service (forecast, location, daytime...)
Singleton {
    id: root

    property real latitude: Settings.weather_latitude
    property real longitude: Settings.weather_longitude
    property string city: Settings.weather_city

    readonly property bool located: latitude !== 0 || longitude !== 0

    property var data: null
    property bool ok: true
    property var lastUpdated: null

    readonly property bool loading: geocode.running || fetch.running 
    readonly property bool valid: ok && data !== null

    readonly property real temp:    data?.current?.temperature_2m ?? 0
    readonly property real feelsLike: data?.current?.apparent_temperature ?? 0
    readonly property int humidity: data?.current?.relative_humidity_2m ?? 0
    readonly property real wind: data?.current?.wind_speed_10m ?? 0
    readonly property int code: data?.current?.weather_code ?? -1
    readonly property bool isDay: (data?.current?.is_day ?? 1) === 1
    readonly property string unitSymbol: Settings.weather_unit === "fahrenheit" ? "°F" : "°C"
    
    readonly property var hourly: data?.hourly ?? null
    readonly property var daily: data?.daily ?? null

    // Rain
    readonly property int rain: {
        const h = data?.hourly;
        const t = data?.current?.time;
        if (!h?.time || !t) return -1;
        const i = h.time.indexOf(t.slice(0, 13) + ":00");
        return i < 0 ? -1 : (h.precipitation_probability?.[i] ?? -1);
    }

    // Forecast Url
    readonly property string forecastUrl:
        "https://api.open-meteo.com/v1/forecast"
        + "?latitude="  + latitude
        + "&longitude=" + longitude
        + "&current=temperature_2m,weather_code,is_day,apparent_temperature,"
        +          "relative_humidity_2m,wind_speed_10m"
        + "&hourly=temperature_2m,weather_code,precipitation_probability"
        + "&daily=weather_code,temperature_2m_max,temperature_2m_min,"
        +        "precipitation_probability_max,sunrise,sunset"
        + "&temperature_unit=" + Settings.weather_unit
        + "&wind_speed_unit="  + Settings.weather_wind_unit
        + "&forecast_days="    + Settings.weather_forecast_days
        + "&timezone=auto"

    // Geocode url
    readonly property string geocodeUrl:
        "https://geocoding-api.open-meteo.com/v1/search"
      + "?name=" + encodeURIComponent(Settings.weather_city)
      + "&count=1&format=json&language=" + Settings.weather_language

    // Get long and lat from city
    Process {
        id: geocode
        command: ["curl", "-sf", "--max-time", String(Settings.weather_timeout), root.geocodeUrl]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const r = JSON.parse(text).results?.[0];
                    if (!r) return root.fail();
                    root.latitude = r.latitude;
                    root.longitude = r.longitude;
                    root.city = r.name;
                    fetch.running = true;
                } catch (e) {
                    console.warn("Weather: bad response -", e)
                    root.fail();
                }
            }
        }
        onExited: code => { if(code !== 0) root.fail(); }
    }  

    // Forecast
    Process {
        id: fetch
        command: ["curl", "-sf", "--max-time", String(Settings.weather_timeout), root.forecastUrl]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const d = JSON.parse(text);
                    if (!d.current) return root.fail();
                    root.data = d;
                    root.lastUpdated = new Date();
                    root.ok = true;
                    retry.stop();
                } catch (e) {
                    console.warn("Weather: bad response -", e)
                    root.fail();
                }
            }
        }
        onExited: code => { if(code !== 0) root.fail();}
    }

    // Failed weather query
    function fail(): void {
        ok = false;
        retry.restart();
    }

    // Refresh
    function refresh(): void {
        if (loading) return;
        if(located) fetch.running = true;
        else if (Settings.weather_city) geocode.running = true;
        else fail();
    }

    Timer {
        id: poll
        interval: Settings.weather_poll_interval
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refresh()
    }

    Timer {
        id: retry
        interval: Settings.weather_retry_interval
        onTriggered: root,refresh()
    }
}