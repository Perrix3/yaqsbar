#!/usr/bin/env bash
# System update script. Toggle each part with an env var (1 = on, 0 = off):
#   UPD_PACMAN=1 UPD_AUR=1 UPD_FLATPAK=1 UPD_NOCONFIRM=0 ./update.sh

set -uo pipefail

UPD_PACMAN="${UPD_PACMAN:-1}"
UPD_AUR="${UPD_AUR:-1}"
UPD_FLATPAK="${UPD_FLATPAK:-1}"
UPD_NOCONFIRM="${UPD_NOCONFIRM:-0}"

# Aur helper list, first found is used.
AUR_HELPERS=(yay paru pikaur trizen pacaur aurman)

failed=()

# ---------------------------------------------------------------------------

if [[ "$UPD_PACMAN" == 1 ]]; then
    echo ":: Updating pacman packages"
    args=(-Syu)
    [[ "$UPD_NOCONFIRM" == 1 ]] && args+=(--noconfirm)
    sudo pacman "${args[@]}" || failed+=(pacman)
fi

if [[ "$UPD_AUR" == 1 ]]; then
    helper=""
    for h in "${AUR_HELPERS[@]}"; do
        command -v "$h" >/dev/null 2>&1 && { helper="$h"; break; }
    done

    if [[ -z "$helper" ]]; then
        echo ":: No AUR helper found, skipping AUR" >&2
    else
        echo ":: Updating AUR packages ($helper)"

        # -Sua is AUR-only; if pacman was skipped use -Syu so repo deps resolve.
        [[ "$UPD_PACMAN" == 1 ]] && args=(-Sua) || args=(-Syu)

        if [[ "$UPD_NOCONFIRM" == 1 ]]; then
            args+=(--noconfirm)
            case "$helper" in
                paru) args+=(--skipreview --removemake) ;;
            esac
        fi

        "$helper" "${args[@]}" || failed+=(aur)
    fi
fi

if [[ "$UPD_FLATPAK" == 1 ]]; then
    echo ":: Updating flatpaks"
    args=(update)
    [[ "$UPD_NOCONFIRM" == 1 ]] && args+=(-y)
    flatpak "${args[@]}" || failed+=(flatpak)
fi

# ---------------------------------------------------------------------------

status=0
echo
if (( ${#failed[@]} )); then
    echo ":: Failed: ${failed[*]}" >&2
    status=1
else
    echo ":: All updates complete."
fi

# Hold the terminal open so the output is readable before the window closes.
if [[ -t 0 ]]; then
    echo ":: Press any key to exit..."
    read -rsn1
fi

exit "$status"