# My Dotfiles

## Screenshot
[![HIDV5CP.th.png](https://iili.io/HIDV5CP.th.png)](https://freeimage.host/i/HIDV5CP)

## Philosophy 
- Modern Wayland TM that brings build-in sick animation handling
- SystemD-less hardcoded config.
- [Hardened-Kernel](https://www.linux.com/news/hardening-kernel-protect-against-attackers/) is highly encouraged to increase computer security.
- I've configured Wayland Screen Share and Audio to work outside of the box in this config
- HyprLand is configured to be battery friendly with laptops


### Installation before dotfiles

```shell
yay -S neovim kitty wayland xwayland hyprland-git nsxiv

pacman -S your_browser # I use Vivaldi BTW
```

### Instructions 
- `stow app_name/`  
- `stow */` stow everything
- / removes the README if it exists inside it

### TUI File Manager 
- TODO, Need to learn one first (probably nnn)

### Notes
- 1.  You know what is RTFM and Google 
- 2.  I won't write any automation scripts for dependency gathering

- 3. Screen Sharing
  - `yay -S xdg-desktop-portal-hyprland-git`
  - Configured in ./hypr/.config/hypr/execs.conf

- 4. Audio
  - `yay -S wireplumber pipewire`
  - Configured in ./hypr/.config/hypr/execs.conf

- 5. Wallpapers
  - You should have either `~/Pictures/Wallpapers` or `~/MEGA/Wallpapers/` (requires MegaSync Installed)

- 6. MegaSync
  - if you don't use it remove it from `~/dotfiles/hypr/.config/hypr/execs.conf`

- 7. Keyboard
  - TMs won't make you any productive if you don't know how to use the keyboard correctly
  - Source to [study](https://www.edclub.com/typingclub) the keyboard
  - My key maps are set in a way that look similar to other configs

- 8. Competition
  - This configuration does not try to compete other peoples dotfiles in anyway

#### Login Manager
Many Login Managers may work with Wayland but they are not required. <br />
Simply do `stow start_hypr/` and  `.~/StartGUI`! <br />
*(Note: GTK_THEME is exported in `~/StartGUI` if you won't use this script, don't forget this)`

