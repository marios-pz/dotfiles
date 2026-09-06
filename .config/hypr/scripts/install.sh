#!/usr/bin/env bash
# Installs the parts of this setup that the ansible playbook cannot: the AUR
# packages, and the swap from Noctalia's Quickshell fork to upstream.
#
# Repo packages live in ansible/variables/packages.yaml. Run the playbook
# first, then this:
#
#   ansible-playbook -K playbook.yaml
#   ~/.config/hypr/scripts/install.sh

set -euo pipefail

AUR_HELPER=${AUR_HELPER:-yay}

# Caelestia pulls the rest of its AUR tree (qt6-m3shapes-git, ttf-rubik-vf,
# libcava, python-materialyoucolor) in as dependencies.
AUR_PACKAGES=(
    caelestia-shell
    caelestia-cli
    wvkbd
)

# Noctalia ships a Quickshell fork that declares `Conflicts: quickshell-git`,
# so the two cannot be installed side by side. Caelestia needs upstream.
CONFLICTING=(
    noctalia-qs
    noctalia-shell
    noctalia-git
    cachyos-niri-noctalia
)

info() { printf '\n\033[1;34m==>\033[0m %s\n' "$1"; }
warn() { printf '\n\033[1;33m==>\033[0m %s\n' "$1"; }

command -v "$AUR_HELPER" >/dev/null || {
    echo "$AUR_HELPER is not installed. Install it, or set AUR_HELPER." >&2
    exit 1
}

installed=()
for pkg in "${CONFLICTING[@]}"; do
    pacman -Qq "$pkg" &>/dev/null && installed+=("$pkg")
done

if (( ${#installed[@]} )); then
    warn "These conflict with upstream quickshell and will be removed:"
    printf '      %s\n' "${installed[@]}"
    echo
    echo "Your niri config stays on disk. Noctalia itself will stop working"
    echo "until you reinstall it, which would then displace Caelestia again."
    echo
    read -rp "Remove them? [y/N] " reply
    [[ ${reply,,} == y ]] || { echo "Nothing changed."; exit 0; }

    # -Rdd skips dependency checks: cachyos-niri-noctalia is a metapackage
    # whose other members should survive this.
    sudo pacman -Rdd --noconfirm "${installed[@]}"
fi

info "Installing upstream quickshell"
"$AUR_HELPER" -S --needed quickshell-git

info "Installing Caelestia"
"$AUR_HELPER" -S --needed "${AUR_PACKAGES[@]}"

info "Enabling services"
# Drives the accelerometer that scripts/rotation.sh reads.
sudo systemctl enable --now iio-sensor-proxy.service
# gamemoded is socket activated per user, not system wide.
systemctl --user enable --now gamemoded.service 2>/dev/null || true

info "Done"
cat <<'EOF'

Log out and pick Hyprland at the SDDM session menu.

First run:
  caelestia wallpaper -f /path/to/an/image   set the wallpaper and the colours
  hyprctl devices                            check the device names in
                                             variables.lua match your hardware
EOF
