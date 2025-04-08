#!/bin/bash

PID_FILE="/tmp/livewallpaper_loop.pid"
SOCKET="/tmp/mpv_music_socket"

if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    # === SWITCH OFF ===

    # Kill loop
    kill "$(cat "$PID_FILE")" && rm "$PID_FILE"

    # Kill everything
    pkill -x mpv
    pkill -x mpvpaper

    [ -e "$SOCKET" ] && rm "$SOCKET"

    # Restore static wallpaper
    swww init &
    sleep 0.5
    swww img ~/Pictures/wallpapers/tony.jpg &

    notify-send "🧠 Master Control ON" "Returned to regular desktop. Ready for work.🧘"

else
    # === SWITCH ON ===

    # Kill swww and clean stuff
    pkill -x swww-daemon
    pkill -x mpv
    pkill -x mpvpaper
    [ -e "$SOCKET" ] && rm "$SOCKET"

    # Pick a random track
    MUSIC_DIR="/playlist"
    RANDOM_TRACK=$(find "$MUSIC_DIR" -type f -iname '*.mp3' | shuf -n 1)
    SONG_NAME=$(basename "$RANDOM_TRACK" .mp3 | sed 's/_/ /g')

    notify-send "🌌 Master Control OFF" "Wallpaper re-enabled. Back to style mode.🚀

🎵 Enjoy yourself sir — Now playing: $SONG_NAME"

    # Start loop for video wallpaper
    (while true; do
        mpvpaper eDP-1 ~/Videos/iron_man.mp4 -- --no-audio --really-quiet
        sleep 1
    done) &

    echo $! > "$PID_FILE"

    # Voice + music
    mpv jarvis_vocal.mpeg --no-video --volume=100 --quiet &
    mpv "$RANDOM_TRACK" --no-video --volume=70 --input-ipc-server="$SOCKET" --quiet &

    # Volume fade
    sleep 12
    for vol in {71..100}; do
        echo '{ "command": ["set_property", "volume", '"$vol"'] }' | socat - "$SOCKET" > /dev/null
        sleep 0.1
    done
fi

