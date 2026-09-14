# Hyprland + Caelestia

A Hyprland setup for a Lenovo Yoga laptop, using the Caelestia shell for
the bar, launcher, notifications, lock screen and wallpaper.

Hyprland 0.56 reads `hyprland.lua`. There is no `.conf` fallback any more, so
everything here is Lua.

## Layout

| Path | What is in it |
| --- | --- |
| `variables.lua` | Every tunable value. Start here. |
| `hyprland.lua` | Entry point, loads the modules in order |
| `hyprland/env.lua` | Environment variables |
| `hyprland/monitors.lua` | Output configuration |
| `hyprland/general.lua` | Layout, decoration, blur, shadows, misc |
| `hyprland/animations.lua` | Curves and animation config |
| `hyprland/input.lua` | Keyboard, touchpad, touchscreen, pen |
| `hyprland/gestures.lua` | Touchpad and touchscreen gestures |
| `hyprland/workspaces.lua` | The static 1 to 9 workspaces |
| `hyprland/rules.lua` | Window and layer rules |
| `hyprland/gaming.lua` | Steam, game rules, game mode |
| `hyprland/lid.lua` | Lid switch handling |
| `hyprland/keybinds.lua` | Every key and mouse bind |
| `hyprland/execs.lua` | Autostart |
| `utils/functions.lua` | Shared helpers |
| `scripts/` | Anything that has to outlive a dispatcher call |

## Install

Repo packages come from the ansible playbook:

```shell
ansible-playbook -K playbook.yaml
```

Then Quickshell and Caelestia, which the playbook does not cover:

```shell
sudo pacman -S --needed quickshell
yay -S --needed caelestia-shell caelestia-cli
```

Quickshell lives in `[extra]`. If a fork is already installed, pacman will
offer to replace it: forks declare `Conflicts: quickshell-git`, so only one
can be present at a time.

Then log out and pick Hyprland at the SDDM session menu.

First run:

```shell
caelestia wallpaper -f /path/to/image   # sets the wallpaper and the colours
```

Caelestia generates its whole colour scheme from the wallpaper, so this is
what actually makes it look like anything.

## Workspaces

Nine static workspaces. They are `persistent`, so all nine exist at all times
and the bar always shows the full row, whether or not anything is on them.

They are deliberately not pinned to a monitor: pinning them to `eDP-1` would
strand every workspace on the laptop panel as soon as you dock.

Slack and Discord always open on workspace 9, silently, so they cannot steal
focus while they start. `Super + D` jumps there. To make that apply only to
the copies started at login, drop the `comms` tag rules from
`hyprland/rules.lua` and place them from `hyprland/execs.lua` instead.

## Keybinds

Mod is Super. `hyprctl binds` lists these live with their descriptions.

### Shell

| Key | Action |
| --- | --- |
| `Super + Space`, tap `Super` | App launcher |
| `Super + N` | Sidebar |
| `Ctrl + Super + K` | Show every shell panel |
| `Ctrl + Super + L` | Lock |
| `Ctrl + Super + Shift + L` | Suspend |
| `Super + Alt + L` | Restart the shell, then lock |
| `Ctrl + Alt + Delete` | Session menu |
| `Ctrl + Alt + C` | Clear notifications |
| `Ctrl + Super + Shift + R` | Kill the shell |
| `Ctrl + Super + Alt + R` | Restart the shell |

### Programs

| Key | Action |
| --- | --- |
| `Super + Return` | Alacritty |
| `Super + B` | Zen browser |
| `Super + E` | Nautilus |
| `Super + C` | VS Code |
| `Ctrl + Alt + V` | pavucontrol |
| `Ctrl + Shift + Escape` | btop |

### Windows

| Key | Action |
| --- | --- |
| `Super + Q` | Close |
| `Super + F` | Fullscreen |
| `Super + Shift + F` | Maximise |
| `Super + T` | Toggle floating |
| `Super + P` | Pin |
| `Ctrl + Super + C` | Centre |
| `Super + Alt + \` | Shrink to a pinned corner |
| `Super + h/j/k/l`, arrows | Focus |
| `Super + Shift + h/j/k/l`, arrows | Move |
| `Super + -` / `Super + =` | Narrower, wider |
| `Super + Shift + -` / `=` | Shorter, taller |
| `Super + drag` / `Super + right drag` | Move, resize |
| `Alt + Tab` | Cycle windows |
| `Super + ,` | Group or ungroup |
| `Super + U` | Leave group |

Bare `Super + K` and `Super + L` are focus keys, which is why the shell's
panel and lock binds carry Ctrl.

### Workspaces

| Key | Action |
| --- | --- |
| `Super + 1` to `9` | Go to workspace |
| `Super + Shift + 1` to `9` | Move window there |
| `Super + D` | Chat apps, workspace 9 |
| `Super + Tab` | Last workspace |
| `Ctrl + Super + Left/Right`, `Super + scroll` | Previous, next |
| `Super + S` | Scratchpad |
| `Super + Alt + S` | Send window to scratchpad |

### Screen and clipboard

| Key | Action |
| --- | --- |
| `Print` | Screenshot |
| `Super + Shift + S` | Freeze and snip a region |
| `Super + Shift + Alt + S` | Snip a live region |
| `Super + Shift + C` | Colour picker |
| `Ctrl + Alt + R` | Record |
| `Super + Alt + R` | Record with sound |
| `Super + Shift + Alt + R` | Record a region |
| `Super + V` | Clipboard history |
| `Super + .` | Emoji picker |

### Zoom and gaming

| Key | Action |
| --- | --- |
| `Super + 0` | Reset the desktop zoom |
| `Super + G` | Game mode |

## Touch and the lid

Touch input is bound to `eDP-1` in `hyprland/input.lua`, for the finger and
the pen separately, so taps keep landing where you pressed once a second
monitor widens the layout.

Closing the lid runs `scripts/lid.sh close`, which blanks the panel with DPMS
only when it is the sole output: closing the lid on a docked machine leaves
the external monitor alone. Nothing here suspends, that is logind's job, and
duplicating it causes races on resume.

## Gaming

Steam, gamescope, gamemode and MangoHud are installed by the playbook.

Windows whose class matches `steam_app_<id>`, `gamescope` or a Lutris or
Heroic title are tagged `game` and get: no blur, no shadow, no rounding, no
transparency, tearing allowed, the direct scanout content hint, and an idle
inhibitor so a controller-only session never locks mid match.

`xwayland.force_zero_scaling` matters here. Steam and most Proton games are
XWayland clients, and without it they render at 1x and get upscaled into a
blur on any output with a scale other than 1.

Game mode strips blur, shadows, animations, gaps and borders, which are the
things that actually cost frames on integrated graphics. It follows focus by
default, so alt tabbing out of a game gives the desktop its effects back. Set
`autoGameMode = false` in `variables.lua` to drive it only from `Super + G`.

To run a game with the usual wrappers, set its Steam launch options to:

```
gamemoderun mangohud %command%
```

## Idle and locking

Caelestia has its own idle daemon, so there is no hypridle here. Running both
would double up every timer. The timeouts live in
`~/.config/caelestia/shell.json` under `general.idle`: lock at 5 minutes,
screen off at 7, suspend at 30. They respect idle inhibitors, which is what
the game rule above hooks into.

## Changing hardware

Device names in `variables.lua` come from `hyprctl devices`. Hyprland
lowercases device names and turns spaces into hyphens, so they do not look
like the names in `/proc/bus/input/devices`.

Switches are the exception: they are matched on the raw libinput name, spaces
and capitals intact. That is why `lidSwitch` looks different from the rest.
