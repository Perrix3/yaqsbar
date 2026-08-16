import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.Config
import qs.Services
import qs.Strings
import qs.Common

Card {
    id: root

    border.color: Colors.col_media

    readonly property MprisPlayer player: Media.current
    readonly property real progress: (player?.length ?? 0) > 0
                                    ? Media.position / player.length
                                    : 0

    // Play, pause, prev, next...
    component MediaButton: BarWidgetButton {
        implicitWidth: Settings.media_button_size
        implicitHeight: Settings.media_button_size
        radius: Settings.media_button_size / 2
        accent: Colors.col_media
        opacity: enabled ? 1 : 0.4
    }

    // Sliding text for title and artis + album texts
    component SlidingText: Item {
        id: sliding

        property string text
        property color textColor: Colors.col_main
        property int pixelSize: Settings.font_size_normal
        readonly property bool overflowing: label.implicitWidth > sliding.width

        implicitHeight: label.implicitHeight
        clip: true
        
        StyledText {
            id: label
            text: sliding.text
            color: sliding.textColor
            font.pixelSize: sliding.pixelSize
            onImplicitWidthChanged: sliding.restartScroll()
        }

        SequentialAnimation {
            id: scroll
            loops: Animation.Infinite

            PauseAnimation { duration: Settings.media_sliding_delay}
            NumberAnimation {
                target: label; property: "x"
                from: 0
                to: Math.min(0, sliding.width - label.implicitWidth)
                duration: Math.max(1, (label.implicitWidth - sliding.width)
                                       / Settings.media_sliding_speed * 1000)
            }
            PauseAnimation {duration: Settings.media_sliding_delay}
            NumberAnimation {
                target: label; property: "x"
                to: 0; duration: 400; easing.type: Easing.InOutQuad
            }
        }
        
        function restartScroll(): void {
            scroll.stop();
            label.x = 0;
            if (sliding.overflowing) scroll.start();
        }

        onWidthChanged: restartScroll()
        Component.onCompleted: restartScroll()

    }

    ColumnLayout {
        anchors.fill: parent
        spacing: Settings.dashboard_spacing

        // Art + track text
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: Settings.dashboard_spacing

            // Album / thumbnail
            ClippingRectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: height
                radius: Settings.dashboard_card_radius ///////////////
                color: Colors.col_background3

                Image {
                    anchors.fill: parent
                    source: root.player?.trackArtUrl ?? ""
                    visible: status === Image.Ready
                    fillMode: Image.PreserveAspectCrop
                    sourceSize: Qt.size(width, height)
                    asynchronous: true
                }

                IconText {
                    anchors.centerIn: parent
                    visible: !root.player?.trackArtUrl
                    text: Settings.media_placeholder_icon
                    color: Colors.col_secondary
                }
            }

            // Track text
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 0

                // Player name
                StyledText {
                    id: appName

                    Layout.fillWidth: true
                    text: root.player?.identity ?? ""
                    color: Colors.col_secondary
                    font.pixelSize: Settings.media_app_font_size
                    elide: Text.ElideRight
                }

                // Track title
                SlidingText {
                    Layout.fillWidth: true
                    text: root.player?.trackTitle || Strings.media_idle
                    pixelSize: Settings.media_title_font_size
                }

                // Track artist + album
                SlidingText {
                    Layout.fillWidth: true
                    text: [root.player?.trackArtist, root.player?.trackAlbum]
                                .filter(Boolean).join(" - ")
                    pixelSize: Settings.media_album_font_size
                }

                Item { Layout.fillHeight: true }
            }
        }
        // Elapsed / length
        RowLayout {
            Layout.fillWidth: true

            // Position
            StyledText {
                text: root.fmt(seekBar.dragging
                    ? seekBar.dragFraction * (root.player?.length ?? 0)
                    : Media.position)
                font.pixelSize: Settings.media_time_font_size
                color: Colors.col_secondary
            }

            Item { Layout.fillWidth: true }

            // Length
            StyledText {
                text: root.fmt(root.player?.length ?? 0)
                font.pixelSize: Settings.media_time_font_size
                color: Colors.col_secondary
            }
        }

        // Progress / seek
        Item {
            id: seekBar

            Layout.fillWidth: true
            implicitHeight: Settings.media_handle_size

            readonly property bool seekable: root.player?.canSeek ?? false
            property bool dragging: false
            property real dragFraction: 0

            readonly property real fraction: dragging ? dragFraction : root.progress

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                height: Settings.media_progress_height
                radius: height / 2
                color: Colors.col_background3

                Rectangle {
                    width:  parent.width * seekBar.fraction
                    height: parent.height
                    radius: parent.radius
                    color:  Colors.col_media
                }
            }

            Rectangle {
                x: seekBar.fraction * (seekBar.width - width)
                anchors.verticalCenter: parent.verticalCenter
                width: Settings.media_handle_size
                height: width
                radius: width / 2
                color: Colors.col_media
                visible: seekBar.seekable && (seekBar.dragging || seekMouse.containsMouse)
            }

            MouseArea {
                id: seekMouse

                anchors.fill: parent
                enabled: seekBar.seekable
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                function fractionAt(x: real): real {
                    return Math.max(0, Math.min(1, x / width));
                }

                onPressed: mouse => {
                    seekBar.dragging = true;
                    seekBar.dragFraction = fractionAt(mouse.x);
                }
                onPositionChanged: mouse => {
                    if (seekBar.dragging) seekBar.dragFraction = fractionAt(mouse.x);
                }
                onReleased: {
                    seekBar.dragging = false;
                    if (!root.player) return;
                    const t = seekBar.dragFraction * root.player.length;
                    root.player.position = t;
                    Media.position = t;
                }
            }
        }

        // Controls
        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: Settings.media_button_spacing

            // Shuffle
            MediaButton {
                text: Settings.media_shuffle_icon
            visible: root.player?.shuffleSupported ?? false
                active: root.player?.shuffle ?? false
                onClicked: root.player.shuffle = !root.player.shuffle
            }
            // Previous
            MediaButton {
                text: Settings.media_prev_icon
                enabled: root.player?.canGoPrevious ?? false
                onClicked: root.player.previous()
            }
            // Play / pause
            MediaButton {
                text: (root.player?.isPlaying ?? false) ? Settings.media_pause_icon
                                                        : Settings.media_play_icon
                enabled: root.player?.canTogglePlaying ?? false
                onClicked: root.player.togglePlaying()
            }
            // Next
            MediaButton {
                text: Settings.media_next_icon
                enabled: root.player?.canGoNext ?? false
                onClicked: root.player.next()
            }
            // Loop
            MediaButton {
                text: root.player?.loopState === MprisLoopState.Track       ?   Settings.media_loop_one_icon
                    : root.player?.loopState === MprisLoopState.Playlist    ?   Settings.media_loop_all_icon
                    :                                                           Settings.media_loop_off_icon
                visible: root.player?.loopSupported ?? false
                active: (root.player?.loopState ?? MprisLoopState.None) !== MprisLoopState.None
                onClicked: root.player.loopState = root.cycleLoop(root.player.loopState)
            }
        }
    }

    function cycleLoop(s) {
        return s === MprisLoopState.None        ?   MprisLoopState.Playlist
             : s === MprisLoopState.Playlist    ?   MprisLoopState.Track
             :                                      MprisLoopState.None;
    }

    function fmt(s: real): string {
        const t = Math.max(0, Math.floor(s));
        const sec = t % 60;
        return Math.floor(t / 60) + ":" + (sec <10 ? "0" : "") + sec;
    }
}