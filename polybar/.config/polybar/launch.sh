#!/usr/bin/env bash
set -euo pipefail

# stop existing polybar instances (ignore errors)
polybar-msg cmd quit >/dev/null 2>&1 || true

# wait until all polybar processes exit
while pgrep -x polybar >/dev/null; do sleep 0.1; done

# If xrandr isn't available, just launch primary and exit
if ! command -v xrandr >/dev/null 2>&1; then
    MONITOR="" polybar --reload primary >/dev/null 2>&1 &
    echo "Launched primary (xrandr missing)."
    exit 0
fi

# Collect connected monitors
mapfile -t monitors < <(xrandr --query | awk '/ connected/ {print $1}')

if [ ${#monitors[@]} -eq 0 ]; then
    echo "No connected monitors found; launching primary as fallback"
    MONITOR="" polybar --reload primary >/dev/null 2>&1 &
    exit 0
fi

# Detect the primary monitor (xrandr marks it 'primary'); fallback to first
primary=$(xrandr --query | awk '/ primary/ {print $1}' || true)
if [ -z "$primary" ]; then
    primary="${monitors[0]}"
fi

echo "Primary monitor: $primary"
echo "All monitors: ${monitors[*]}"

# Launch primary (put tray/pulseaudio in your config for primary only)
MONITOR="$primary" polybar --reload primary >/dev/null 2>&1 &

# Launch secondary on remaining monitors
for m in "${monitors[@]}"; do
    if [ "$m" = "$primary" ]; then
        continue
    fi
    MONITOR="$m" polybar --reload secondary >/dev/null 2>&1 &
done

echo "Bars launched."
