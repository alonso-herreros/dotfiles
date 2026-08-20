local A = {}

-- Prefix for all commands, e.g. to integrate with systemd
local launch = "uwsm-app -t service -- "
-- Prefix for terminal apps (oneshot)
local term = "uwsm-app -t service -T "

-- Terminal as its own app is better with close confirmation
A.terminal               = launch .. "kitty.desktop:Confirm"
A.terminal_float         = launch .. "kitty.desktop:Confirm --class=kitty-float"
A.terminal_oneshot       = term
A.terminal_oneshot_float = term .. "--app-id=kitty-float"
A.terminal_mgmt          = term .. "--app-id=kitty-mgmt"

A.lock              = "loginctl lock-session"
A.toggle_bar        = "systemctl --user kill --signal=USR1 waybar.service"

-- Screen captures (screenshots and recordings)
A.screenshot        = launch .. "hyprcap shot -z -c -n"
A.screenshot_region = launch .. "hyprcap shot region -z -c -n"
A.screenshot_active = launch .. "hyprcap shot window:active -z -c -n"
A.screenrec         = launch .. "hyprcap rec -c -n"
A.screenrec_region  = launch .. "hyprcap rec region -c -n"
A.screenrec_active  = launch .. "hyprcap rec window:active -c -n"

-- Clipboard functions
A.paste       = "hyprctl dispatch sendshortcut CTRL, v, active"
A.clipboard   = launch .. "clipse.desktop"
A.emoji       = launch .. "hypremoji"

-- Base apps
A.open              = launch .. "xdg-open"
A.browser           = launch .. "brave-browser.desktop"
A.fileManager       = launch .. "yazi.desktop"
A.fileManager_float = launch .. "yazi.desktop:Float"
A.editor            = launch .. "vim.desktop"
A.notepad           = launch .. "vim.desktop"

-- Menus and system tools
A.menu        = launch .. "fuzzel --launch-prefix 'p'"
A.config      = A.fileManager .. " ~/.config"
A.bluetooth   = launch .. "bluetoothctl.desktop"
A.network     = launch .. "nmtui.desktop"
A.systemctl   = launch .. "systemctl-tui.desktop"
A.audio       = launch .. "pulsemixer.desktop"
A.audio_alt   = launch .. "org.pulseaudio.pavucontrol.desktop"
A.monitor     = launch .. "htop.desktop"

-- Other apps
A.calc        = launch .. "qalc.desktop"
A.calc_float  = launch .. "qalc.desktop:Float"
A.music       = launch .. "spotify.desktop; ~/.scripts/media_raise.sh"
--A.chat        = launch .. "whatsdesk --ozone-platform=wayland --enable-features=Vulkan %U"
A.chat        = launch .. "brave-hnpfjngllnobngcgfapefoaidbinmjnm-Default.desktop"
A.xmpp        = launch .. "org.gajim.Gajim.desktop"
A.code        = launch .. "code.desktop"
A.anki        = launch .. "anki.desktop"
A.okular      = launch .. "org.kde.okular.desktop"

return A
