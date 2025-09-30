# Alonso Herreros's dotfiles

Dotfiles just the way I like 'em.

---

## System

These dotfiles were designed for the following setup:

* 🍀 **Base**: [Arch][archlinux]
* 🤖 **Session Manager**: [UWSM][uwsm]
* 🌼 **Window Manager / compositor**: [Hyprland][hyprland]
* 🕹️ **App runner**: [runapp][runapp]
* ✨ **Status bar**: [Waybar][waybar]
* 🚀 **Launcher/dmenu**: [Fuzzel][fuzzel]
* 🪵 **Notification daemon**: [Dunst][dunst]
* 🤏 **Gestures daemon**: [Fusuma][fusuma]
* ⌛ **Idle daemon**: [Hypridle][hypridle]
* 🪫 **Battery daemon**: [Batsignal][batsignal]
* 📷 **Screen capture utility**: [hyprcap][hyprcap]

* 🗄️ **File Manager**: [Yazi][yazi] plus [XDP termfilechooser][xdpt]
* 📁 **GUI File Manager**: [Nautilus][nautilus]
* 🌷 **Terminal**: [Kitty][kitty]
* 🍄 **Shell**: [Zsh][zsh] with [oh-my-zsh][omz] and [p10k][p10k]
    ([bash][bash] is configured too)
* 📝 **Editor**: [vim][vim]
* 🌐 **Browser**: [Brave][brave]

* ❄️  **Screen locker**: [Hyprlock][hyprlock]
* 🍁 **Wallpaper**: [Hyprpaper][hyprpaper]

## Installation

These dotfiles are configured using [dotbot][dotbot]!

1. Clone this repository **recursively** to your dotfiles directory of choice
   (mine is `~/.dotfiles`)
2. `cd` into the repo
3. Run the `./strap` utility to set up symlinks!

```sh
git clone --recursive https://github.com/alonso-herreros/dotfiles .dotfiles
cd .dotfiles
./strap
```

## Terms of use

Feel free to use all of or part of these dotfiles for yourself, fork this repo,
and create issues/PRs (suggestions are welcome!). If it's useful to you, I'd
be happy to know.

[archlinux]: https://archlinux.org/
[uwsm]: https://github.com/Vladimir-csp/uwsm
[hyprland]: https://hyprland.org/
[runapp]: https://github.com/c4rlo/runapp
[waybar]: https://github.com/Alexays/Waybar
[fuzzel]: https://codeberg.org/dnkl/fuzzel
[dunst]: https://github.com/dunst-project/dunst
[fusuma]: https://github.com/iberianpig/fusuma
[batsignal]: https://github.com/electrickite/batsignal
[hyprshot]: https://github.com/alonso-herreros/hyprshot
[hyprcap]: https://github.com/alonso-herreros/hyprcap

[yazi]: https://yazi-rs.github.io/
[xdpt]: https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser
[nautilus]: https://apps.gnome.org/Nautilus/
[kitty]: https://sw.kovidgoyal.net/kitty/
[bash]: https://www.gnu.org/software/bash/
[zsh]: https://zsh.org
[omz]: https://github.com/ohmyzsh/ohmyzsh
[p10k]: https://github.com/romkatv/powerlevel10k
[vim]: https://www.vim.org/
[brave]: https://brave.com/linux

[hyprlock]: https://github.com/hyprwm/hyprlock
[hyprpaper]: https://github.com/hyprwm/hyprpaper
[hypridle]: https://github.com/hyprwm/hypridle

[dotbot]: https://github.com/anishathalye/dotbot
