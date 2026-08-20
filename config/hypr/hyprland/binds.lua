-- https://wiki.hypr.land/Configuring/Basics/Variables/#binds
-- https://wiki.hypr.land/0.56.0/Configuring/Basics/Binds/

-- See xkbcommon-keysyms.h for all the keysyms:
-- https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h


--###################
--## CONFIGURATION ##
--###################

hl.config({binds = {
	pass_mouse_when_bound = false,
	scroll_event_delay = 10,
	workspace_back_and_forth = true,
	hide_special_on_workspace_change = true,
	--allow_workspace_cycles = false,
	--workspace_center_on = 1,
	--focus_preferred_method = 0,
	--ignore_group_lock = false,
	--movefocus_cycles_fullscreen = false,
	--movefocus_cycles_groupfirst = false,
	window_direction_monitor_fallback = true,
	disable_keybind_grabbing = true,
	--allow_pin_fullscreen = false,
	drag_threshold = 30,
}})


--###############
--## SHORTHAND ##
--###############

local bind = hl.bind
local dsp = hl.dsp
local win = hl.dsp.window
local group = hl.dsp.group
local ws = hl.dsp.workspace
local focus = hl.dsp.focus
local exec = hl.dsp.exec_raw
local cmd = hl.dsp.exec_cmd
local shortcut = hl.dsp.send_shortcut

local FLAG_MAP = {
	["l"] = "locked",
	["r"] = "release",
	["c"] = "click",
	["g"] = "drag",
	["o"] = "long_press",
	["e"] = "repeating",
	["n"] = "non_consuming",
	["N"] = "auto_consuming",
	["m"] = "mouse",
	["t"] = "transparent",
	["i"] = "ignore_mod",
	["d"] = "description",
	["p"] = "dont_inhibit",
	["u"] = "submap_universal",
	["D"] = "device",
	["C"] = "allow_input_capture",
}
local function F(str)
	local result = {}
	for char in str:gmatch(".") do
		local key = FLAG_MAP[char]
		if key then
			result[key] = true
		end
	end
	return result
end

--##########
--## VARS ##
--##########

local A = require("aliases")

local scripts = "~/.scripts"
local hypr_scripts = "~/.config/hypr/scripts"

A.specialworkspace_tmp = "hyprctl eval 'hl.dsp.focus({workspace=\"special:tmp\"})'; "
A.volumectl     = scripts .. "/system/volume_ctl.sh"
A.brightnessctl = scripts .. "/system/brightness_ctl.sh"
A.rename_current_workspace = hypr_scripts .. "/rename-workspace.sh -i"

local function alt(str)
	return hl.dsp.exec_cmd(hypr_scripts .. "/dispatch-alt.sh '" .. str .. "'")
end



--###############################
--## SESSION/SCREEN MANAGEMENT ##
--###############################

-- Lock screen
bind("SUPER + ESCAPE", exec(A.lock), F("ul"))
-- Lock screen and turn off display
bind("SUPER+ALT + ESCAPE", cmd(A.lock .. " & sleep 1; hyprctl dispatch dpms off"), F("ul"))
-- Hibernate and sleep (locking included via hypridle)
bind("SUPER + F12",       exec("systemctl hibernate -i"), F("ul"))
bind("SUPER+SHIFT + F12", exec("systemctl sleep -i"),     F("ul"))
-- Quit Hyprland
bind("SUPER+SHIFT + ESCAPE", exec("uwsm stop"), F("u"))
-- Hyprctl reload
bind("SUPER+CTRL + R", exec("hyprctl reload"), F("u"))

-- Toggle bar
bind("SUPER+SHIFT + b", exec(A.toggle_bar), F("u"))

-- Switching keyboard layouts
bind("SUPER+MOD5 + comma",  exec("hyprctl switchxkblayout all previous"), F("u"))
bind("SUPER+MOD5 + period", exec("hyprctl switchxkblayout all next"),     F("u"))
bind("SUPER+MOD5 + 0", exec("hyprctl switchxkblayout all 0"), F("u"))
bind("SUPER+MOD5 + 1", exec("hyprctl switchxkblayout all 1"), F("u"))
bind("SUPER+MOD5 + 2", exec("hyprctl switchxkblayout all 2"), F("u"))
bind("SUPER+MOD5 + 3", exec("hyprctl switchxkblayout all 3"), F("u"))
bind("SUPER+MOD5 + 4", exec("hyprctl switchxkblayout all 4"), F("u"))
bind("SUPER+MOD5 + 5", exec("hyprctl switchxkblayout all 5"), F("u"))

-- Handle lid switch. Loads the monitor configuration from monitors.conf on open.
-- bindu  = , switch:on:Lid Switch, exec, hyprctl keyword monitor eDP-1, disable
-- bindul = , switch:off:Lid Switch, exec, hyprctl keyword $(sed -n 's/= eDP-1/eDP-1/p' $XDG_CONFIG_HOME/hypr/hyprland/monitors.conf)


--#################
--# MOVING FOCUS ##
--#################

-- Move focus with MOD + hjkl
bind("SUPER + h", focus({ direction="left" }),  F("u"))
bind("SUPER + l", focus({ direction="right" }), F("u"))
bind("SUPER + j", focus({ direction="down" }),  F("u"))
bind("SUPER + k", focus({ direction="up" }),    F("u"))
-- Cycle focus with Alt+tab (Windows parallels)
bind("ALT + Tab",       win.cycle_next({}),             F("u"))
bind("ALT + Tab",       win.alter_zorder({mode="top"}), F("u"))
bind("ALT+SHIFT + Tab", win.cycle_next({next=false}),   F("u"))
bind("ALT+SHIFT + Tab", win.alter_zorder({mode="top"}), F("u"))
-- Swap focus with Alt+<
bind("ALT + Less",      focus({ urgent_or_last = true }), F("u"))
bind("ALT + Less",      win.alter_zorder({mode="top"}),       F("u"))


--#########################
--# MANIPULATING WINDOWS ##
--#########################

-- Move windows with MOD + Shift + hjkl
bind("SUPER+SHIFT + h", win.move({direction="left"}),  F("u"))
bind("SUPER+SHIFT + l", win.move({direction="right"}), F("u"))
bind("SUPER+SHIFT + j", win.move({direction="down"}),  F("u"))
bind("SUPER+SHIFT + k", win.move({direction="up"}),    F("u"))

-- Resize windows with MOD + Ctrl (+ Alt) + hjkl / MOD + Arrow keys
local resizeStep = 90
local resizeStepVert = 60
local resizeStepMed = 45
local resizeStepSmall = 30
bind("SUPER+CTRL + h",     win.resize({ x=-resizeStep,      y=0 }), F("ul"))
bind("SUPER+CTRL + l",     win.resize({ x=resizeStep,       y=0 }), F("ul"))
bind("SUPER+CTRL + j",     win.resize({ x=0, y=resizeStepVert   }), F("ul"))
bind("SUPER+CTRL + k",     win.resize({ x=0, y=-resizeStepVert  }), F("ul"))
bind("SUPER+CTRL+ALT + h", win.resize({ x=-resizeStepSmall, y=0 }), F("ul"))
bind("SUPER+CTRL+ALT + l", win.resize({ x=resizeStepSmall,  y=0 }), F("ul"))
bind("SUPER+CTRL+ALT + j", win.resize({ x=0, y=resizeStepSmall  }), F("ul"))
bind("SUPER+CTRL+ALT + k", win.resize({ x=0, y=-resizeStepSmall }), F("ul"))
bind("SUPER + Left",       win.resize({ x=-resizeStepMed,   y=0 }), F("ul"))
bind("SUPER + Right",      win.resize({ x=resizeStepMed,    y=0 }), F("ul"))
bind("SUPER + Down",       win.resize({ x=0, y=resizeStepMed    }), F("ul"))
bind("SUPER + Up",         win.resize({ x=0, y=-resizeStepMed   }), F("ul"))

-- Toggle windowed fullscreen
bind("SUPER + Space", win.fullscreen({mode="maximized"}), F("u"))
-- Toggle fake fullscreen
bind("SUPER+SHIFT + Space", win.fullscreen_state({internal=-1, client=2}), F("u"))
bind("SUPER+SHIFT + F11",   win.fullscreen_state({internal=-1, client=2}), F("u"))
-- Toggle true fullscreen
bind("SUPER+SHIFT+CTRL + Space", win.fullscreen({mode="fullscreen"}), F("u"))
bind("SUPER + F11",              win.fullscreen({mode="fullscreen"}), F("u"))
-- Floating, pinning (if floating) and pseudo (if tiled)
bind("SUPER + f", win.float({action="toggle"}), F("u"))
bind("SUPER + P", win.pin({action="toggle"}), F("u"))
bind("SUPER + P", win.pseudo({action="toggle"}), F("u"))
-- Toggle split direction
bind("SUPER + MINUS", dsp.layout("togglesplit"), F("u"))

--Close windows
bind("SUPER + Backspace", win.close(), F("u"))
bind("SUPER + mouse:274", win.close(), F("u"))
bind("ALT + F4",          win.close(), F("u")) -- Windows parallel

-- Move/resize windows with MOD + LMB/RMB and dragging
bind("SUPER + mouse:272", win.drag(),   F("um"))
bind("SUPER + mouse:273", win.resize(), F("um"))


--########################
--# MANIPULATING GROUPS ##
--########################

-- Toggle a group with MOD + g
bind("SUPER + g", group.toggle(), F("u"))
-- Ungroup a window with MOD + Shift + g
bind("SUPER+SHIFT + g", win.move({out_of_group=true}), F("u"))
-- Toggle the group's lock with MOD + Ctrl + g
bind("SUPER+CTRL + g", group.lock_active(), F("u"))

-- Group tabbing with MOD+ALT + hl
bind("SUPER+CTRL + Tab", group.next(), F("u"))
bind("SUPER+CTRL+SHIFT + Tab", group.prev(), F("u"))
bind("SUPER+ALT + h", group.next(), F("u"))
bind("SUPER+ALT + l", group.prev(), F("u"))

-- Group tab moving with MOD+ALT+SHIFT+hl
bind("SUPER+ALT+SHIFT + h", group.move_window({forward=false}), F("u"))
bind("SUPER+ALT+SHIFT + l", group.move_window({forward=true}),  F("u"))


-- Moving into and out of group with MOD+CTRL+SHIFT + hjkl
bind("SUPER+CTRL+SHIFT + h", win.move({direction="l", group_aware=true}), F("u"))
bind("SUPER+CTRL+SHIFT + l", win.move({direction="r", group_aware=true}), F("u"))
bind("SUPER+CTRL+SHIFT + j", win.move({direction="d", group_aware=true}), F("u"))
bind("SUPER+CTRL+SHIFT + k", win.move({direction="u", group_aware=true}), F("u"))


--############################
--# MANIPULATING WORKSPACES ##
--############################

-- When switching workspaces, I most often want them wherever I'm currently
-- looking at, so I'll make `focusworkspaceoncurrentmonitor` the default.
-- Switch workspaces with MOD + [0-9]
bind("SUPER + 1", focus({workspace=1, on_current_monitor=true}), F("u"))
bind("SUPER + 2", focus({workspace=2, on_current_monitor=true}), F("u"))
bind("SUPER + 3", focus({workspace=3, on_current_monitor=true}), F("u"))
bind("SUPER + 4", focus({workspace=4, on_current_monitor=true}), F("u"))
bind("SUPER + 5", focus({workspace=5, on_current_monitor=true}), F("u"))
bind("SUPER + 6", focus({workspace=6, on_current_monitor=true}), F("u"))
bind("SUPER + 7", focus({workspace=7, on_current_monitor=true}), F("u"))
bind("SUPER + 8", focus({workspace=8, on_current_monitor=true}), F("u"))
bind("SUPER + 9", focus({workspace=9, on_current_monitor=true}), F("u"))
bind("SUPER + 0", focus({workspace=99,on_current_monitor=true}), F("u"))

-- 10 scratchpads with ALT. They always appear on the active monitor.
-- The name would be simply 1-10, but waybar doesn't handle it well and 'thinks'
-- they are the same workspace and doesn't display them right.  I also
-- considered 's1-s10', but I wanted them to be displayed next to the regular
-- workspace with the same number, and the leading 's' made them appear at the
-- end.
bind("SUPER+ALT + 1", focus({workspace=11, on_current_monitor=true}), F("u"))
bind("SUPER+ALT + 2", focus({workspace=21, on_current_monitor=true}), F("u"))
bind("SUPER+ALT + 3", focus({workspace=31, on_current_monitor=true}), F("u"))
bind("SUPER+ALT + 4", focus({workspace=41, on_current_monitor=true}), F("u"))
bind("SUPER+ALT + 5", focus({workspace=51, on_current_monitor=true}), F("u"))
bind("SUPER+ALT + 6", focus({workspace=61, on_current_monitor=true}), F("u"))
bind("SUPER+ALT + 7", focus({workspace=71, on_current_monitor=true}), F("u"))
bind("SUPER+ALT + 8", focus({workspace=81, on_current_monitor=true}), F("u"))
bind("SUPER+ALT + 9", focus({workspace=91, on_current_monitor=true}), F("u"))
bind("SUPER+ALT + 0", focus({workspace=991,on_current_monitor=true}), F("u"))

-- Focus workspace on whatever monitor it happens to be with MOD + CTRL + [0-9]
bind("SUPER+CTRL + 1", focus({workspace=1}), F("u"))
bind("SUPER+CTRL + 2", focus({workspace=2}), F("u"))
bind("SUPER+CTRL + 3", focus({workspace=3}), F("u"))
bind("SUPER+CTRL + 4", focus({workspace=4}), F("u"))
bind("SUPER+CTRL + 5", focus({workspace=5}), F("u"))
bind("SUPER+CTRL + 6", focus({workspace=6}), F("u"))
bind("SUPER+CTRL + 7", focus({workspace=7}), F("u"))
bind("SUPER+CTRL + 8", focus({workspace=8}), F("u"))
bind("SUPER+CTRL + 9", focus({workspace=9}), F("u"))
bind("SUPER+CTRL + 0", focus({workspace=99}), F("u"))

-- Move active window to a workspace with MOD + SHIFT + [0-9]
bind("SUPER+SHIFT + 1", win.move({workspace=1}), F("u"))
bind("SUPER+SHIFT + 2", win.move({workspace=2}), F("u"))
bind("SUPER+SHIFT + 3", win.move({workspace=3}), F("u"))
bind("SUPER+SHIFT + 4", win.move({workspace=4}), F("u"))
bind("SUPER+SHIFT + 5", win.move({workspace=5}), F("u"))
bind("SUPER+SHIFT + 6", win.move({workspace=6}), F("u"))
bind("SUPER+SHIFT + 7", win.move({workspace=7}), F("u"))
bind("SUPER+SHIFT + 8", win.move({workspace=8}), F("u"))
bind("SUPER+SHIFT + 9", win.move({workspace=9}), F("u"))
bind("SUPER+SHIFT + 0", win.move({workspace=99}), F("u"))
-- And 10 scratchpads using ALT
bind("SUPER+ALT+SHIFT + 1", win.move({workspace=11}), F("u"))
bind("SUPER+ALT+SHIFT + 2", win.move({workspace=21}), F("u"))
bind("SUPER+ALT+SHIFT + 3", win.move({workspace=31}), F("u"))
bind("SUPER+ALT+SHIFT + 4", win.move({workspace=41}), F("u"))
bind("SUPER+ALT+SHIFT + 5", win.move({workspace=51}), F("u"))
bind("SUPER+ALT+SHIFT + 6", win.move({workspace=61}), F("u"))
bind("SUPER+ALT+SHIFT + 7", win.move({workspace=71}), F("u"))
bind("SUPER+ALT+SHIFT + 8", win.move({workspace=81}), F("u"))
bind("SUPER+ALT+SHIFT + 9", win.move({workspace=91}), F("u"))
bind("SUPER+ALT+SHIFT + 0", win.move({workspace=991}), F("u"))

-- Silent moving with MOD + SHIFT + CTRL + [0-9]
bind("SUPER+SHIFT+CTRL + 1", win.move({workspace=1,follow=false}), F("u"))
bind("SUPER+SHIFT+CTRL + 2", win.move({workspace=2,follow=false}), F("u"))
bind("SUPER+SHIFT+CTRL + 3", win.move({workspace=3,follow=false}), F("u"))
bind("SUPER+SHIFT+CTRL + 4", win.move({workspace=4,follow=false}), F("u"))
bind("SUPER+SHIFT+CTRL + 5", win.move({workspace=5,follow=false}), F("u"))
bind("SUPER+SHIFT+CTRL + 6", win.move({workspace=6,follow=false}), F("u"))
bind("SUPER+SHIFT+CTRL + 7", win.move({workspace=7,follow=false}), F("u"))
bind("SUPER+SHIFT+CTRL + 8", win.move({workspace=8,follow=false}), F("u"))
bind("SUPER+SHIFT+CTRL + 9", win.move({workspace=9,follow=false}), F("u"))
bind("SUPER+SHIFT+CTRL + 0", win.move({workspace=99,follow=false}), F("u"))
-- And 10 scratchpads using ALT. Hope you don't get ghosting!
bind("SUPER+ALT+SHIFT+CTRL + 1", win.move({workspace=11,follow=false}), F("u"))
bind("SUPER+ALT+SHIFT+CTRL + 2", win.move({workspace=21,follow=false}), F("u"))
bind("SUPER+ALT+SHIFT+CTRL + 3", win.move({workspace=31,follow=false}), F("u"))
bind("SUPER+ALT+SHIFT+CTRL + 4", win.move({workspace=41,follow=false}), F("u"))
bind("SUPER+ALT+SHIFT+CTRL + 5", win.move({workspace=51,follow=false}), F("u"))
bind("SUPER+ALT+SHIFT+CTRL + 6", win.move({workspace=61,follow=false}), F("u"))
bind("SUPER+ALT+SHIFT+CTRL + 7", win.move({workspace=71,follow=false}), F("u"))
bind("SUPER+ALT+SHIFT+CTRL + 8", win.move({workspace=81,follow=false}), F("u"))
bind("SUPER+ALT+SHIFT+CTRL + 9", win.move({workspace=91,follow=false}), F("u"))
bind("SUPER+ALT+SHIFT+CTRL + 0", win.move({workspace=991,follow=false}), F("u"))

-- 'tmp' scratchpad with the < key
bind("SUPER + LESS", ws.toggle_special("tmp"), F("u"))
bind("SUPER+SHIFT + LESS",      win.move({workspace="special:tmp"}), F("u"))
bind("SUPER+SHIFT+CTRL + LESS", win.move({workspace="special:tmp",follow=false}), F("u"))

-- Quick switching between two workspaces
bind("SUPER + Tab",       focus({workspace="previous_per_monitor"}), F("u"))
bind("SUPER+SHIFT + Tab", win.move({workspace="previous"}), F("u"))

-- Auto-determined secondary workspace using MOD+ALT+TAB or MOD+ALT+<
bind("SUPER+ALT + Tab",        alt("focus({%s})"),       F("u"))
bind("SUPER+ALT+SHIFT + Tab",  alt("window.move({%s})"), F("u"))
bind("SUPER+ALT + LESS",       alt("focus({%s})"),       F("u"))
bind("SUPER+ALT+SHIFT + LESS", alt("window.move({%s})"), F("u"))
bind("SUPER+ALT+SHIFT+CTRL + LESS", alt("window.move({%s, follow=false})"), F("u"))

-- Scroll to toggle previous or 'tmp' scratchpad
bind("SUPER + mouse_up", focus({workspace="previous"}), F("u"))
bind("SUPER + mouse_down", ws.toggle_special("tmp"), F("u"))

-- Rename a workspace
bind("SUPER + F2", exec(A.rename_current_workspace), F("u"))


--#############
--# MONITORS ##
--#############

bind("SUPER+CTRL + PLUS",  exec(hypr_scripts .. "/hyprland-scale.sh -i"), F("u"))
bind("SUPER+CTRL + MINUS", exec(hypr_scripts .. "/hyprland-scale.sh -d"), F("u"))


--##########
--# DUNST ##
--##########

bind("SUPER + d",       exec("dunstctl close"),       F("u"))
bind("SUPER+SHIFT + d", exec("dunstctl history-pop"), F("u"))
bind("SUPER+CTRL + d",  exec("dunstctl action"),      F("u"))
bind("SUPER+ALT + d",   exec("dunstctl context"),     F("u"))


--####################
--# MEDIA FUNCTIONS ##
--####################

-- ==== Volume ====
bind("XF86AudioRaiseVolume", exec(A.volumectl .. "-ui 5"), F("ule"))
bind("XF86AudioLowerVolume", exec(A.volumectl .. "-d 5"), F("ule"))
bind("XF86AudioMute",        exec(A.volumectl .. "-t"), F("ule"))

bind("SUPER+CTRL + mouse_up",   exec(A.volumectl .. "-i 5"), F("ul"))
bind("SUPER+CTRL + mouse_down", exec(A.volumectl .. "-d 5"), F("ul"))

bind("SUPER+CTRL + Up",         exec(A.volumectl .. "-i 5"),         F("ul"))
bind("SUPER+CTRL + Down",       exec(A.volumectl .. "-d 5"),         F("ul"))
bind("SUPER+CTRL+SHIFT + Up",   exec(A.volumectl .. "-u -- Unmute"), F("ul"))
bind("SUPER+CTRL+SHIFT + Down", exec(A.volumectl .. "-m -- Mute"),   F("ul"))

-- Volume overdrive
bind("CTRL + XF86AudioRaiseVolume", exec(A.volumectl .. "-ui 5 --allow-boost"), F("ule"))
bind("CTRL + XF86AudioLowerVolume", exec(A.volumectl .. "-d 5 --allow-boost"), F("ule"))

-- ==== Player track / position ====
bind("SUPER+CTRL + mouse:272", exec("playerctl previous"), F("ul"))
bind("SUPER+CTRL + mouse:273", exec("playerctl next"), F("ul"))
bind("SUPER+CTRL + mouse:274", exec("playerctl play-pause"), F("ul"))

bind("SUPER+CTRL + Space",       exec("playerctl play-pause"),   F("ul"))
bind("SUPER+CTRL + Left",        exec("playerctl previous"),     F("ul"))
bind("SUPER+CTRL + Right",       exec("playerctl next"),         F("ul"))
bind("SUPER+CTRL+SHIFT + Left",  exec("playerctl position 10-"), F("ul"))
bind("SUPER+CTRL+SHIFT + Right", exec("playerctl position 10+"), F("ul"))

bind("XF86AudioPlay", exec("playerctl play-pause"), F("ul"))
bind("XF86AudioNext", exec("playerctl next"), F("ul"))
bind("XF86AudioPrev", exec("playerctl previous"), F("ul"))
bind("XF86AudioStop", exec("playerctl stop"), F("ul"))

-- ==== Brightness ====

bind("XF86MonBrightnessUp",   exec(A.brightnessctl .. "s 5%+"),    F("ule"))
bind("XF86MonBrightnessDown", exec(A.brightnessctl .. "s -n 5%-"), F("ule"))

-- ==== Gamma ====
bind("CTRL + XF86MonBrightnessUp",         exec("hyprctl hyprsunset gamma +5"),  F("ule"))
bind("CTRL + XF86MonBrightnessDown",       exec("hyprctl hyprsunset gamma -5"),  F("ule"))
bind("CTRL+SHIFT + XF86MonBrightnessUp",   exec("hyprctl hyprsunset gamma 100"), F("ule"))
bind("CTRL+SHIFT + XF86MonBrightnessDown", exec("hyprctl hyprsunset gamma 100"), F("ule"))

-- ==== Temperature ====
bind("ALT + XF86MonBrightnessUp",         exec("hyprctl hyprsunset temperature -500"), F("ule"))
bind("ALT + XF86MonBrightnessDown",       exec("hyprctl hyprsunset temperature +500"), F("ule"))
bind("ALT+SHIFT + XF86MonBrightnessUp",   exec("hyprctl hyprsunset temperature 6000"), F("ule"))
bind("ALT+SHIFT + XF86MonBrightnessDown", exec("hyprctl hyprsunset temperature 6000"), F("ule"))

--###################
--# SCREEN CAPTURE ##
--###################

bind("SUPER+SHIFT + S",      exec(A.screenshot_region), F("u")) -- Windows parallel
bind("SUPER+SHIFT+ALT + S",  exec(A.screenshot_active), F("u"))
bind("SUPER+SHIFT+CTRL + S", exec(A.screenshot),        F("u"))

bind("SUPER+SHIFT + R",      exec(A.screenrec_region), F("u"))
bind("SUPER+SHIFT+ALT + R",  exec(A.screenrec_active), F("u"))
bind("SUPER+SHIFT+CTRL + R", exec(A.screenrec),        F("u"))

--#############################
--# QUICK VI-LIKE NAVIGATION ##
--#############################

-- ==== Main modifier for vi-like navigation: Ctrl + AltGr ====
local VI_MOD1 = "CTRL+MOD5"
local VI_MOD2 = "ALT+MOD5"

local function bind_vi(keys, shortcut, flags)
	if not keys:find("CTRL") then -- VI_MOD1 has CTRL in it
		bind(VI_MOD1 .. "+" .. keys,  dsp.send_shortcut(shortcut), flags)
	end
	bind(VI_MOD2 .. "+" .. keys, dsp.send_shortcut(shortcut), flags)
end

-- Arrow keys
bind_vi("h",          {mods="",           key="Left"},   F("e"))
bind_vi("j",          {mods="",           key="Down"},   F("e"))
bind_vi("k",          {mods="",           key="Up"},     F("e"))
bind_vi("l",          {mods="",           key="Right"},  F("e"))
bind_vi("SHIFT + h",  {mods="SHIFT",      key="Left"},   F("e"))
bind_vi("SHIFT + j",  {mods="SHIFT",      key="Down"},   F("e"))
bind_vi("SHIFT + k",  {mods="SHIFT",      key="Up"},     F("e"))
bind_vi("SHIFT + l",  {mods="SHIFT",      key="Right"},  F("e"))
-- Word navigation (Ctrl + Arrow keys)
bind_vi("b",          {mods="CTRL",       key="Left"},   {})
bind_vi("w",          {mods="CTRL",       key="Right"},  {})
bind_vi("w",          {mods="",           key="Right"},  {})
bind_vi("e",          {mods="CTRL",       key="Right"},  {})
bind_vi("SHIFT + b",  {mods="SHIFT+CTRL", key="Left"},   {})
bind_vi("SHIFT + w",  {mods="SHIFT+CTRL", key="Right"},  {})
bind_vi("SHIFT + w",  {mods="SHIFT",      key="Right"},  {})
bind_vi("SHIFT + e",  {mods="SHIFT+CTRL", key="Right"},  {})
-- Line and 'buffer' navigation
bind_vi("0",          {mods="",           key="Home"},   F("e"))
bind_vi("SHIFT + 0",  {mods="SHIFT",      key="Home"},   F("e"))
bind_vi("SHIFT + 4",  {mods="",           key="End"},    F("e")) -- '$'
bind_vi("g",          {mods="CTRL",       key="Home"},   F("e"))
bind_vi("SHIFT + G",  {mods="CTRL",       key="End"},    F("e"))
-- Readline-like navigation (Home/End)
bind_vi("CTRL + e",   {mods="",           key="End"},    {})
bind_vi("CTRL+SHIFT + e", {mods="SHIFT",  key="End"},    {})
bind_vi("a",          {mods="",           key="Home"},   {})
bind_vi("SHIFT +  a", {mods="SHIFT",      key="Home"},   {})
-- Whole document navigation (Ctrl + Home/End)
bind_vi("g",          {mods="CTRL",       key="Home"},   {})
bind_vi("SHIFT +  g", {mods="CTRL",       key="End"},    {})
-- Open lines
bind_vi("o",          {mods="",           key="End"},    {})
bind_vi("o",          {mods="",           key="Return"}, {})
bind_vi("SHIFT + o",  {mods="",           key="Home"},   {})
bind_vi("SHIFT + o",  {mods="",           key="Return"}, {})
bind_vi("SHIFT + o",  {mods="",           key="Left"},   {})

--###############
--# QUICK OPEN ##
--###############

bind("SUPER + Q",          exec(A.terminal),       F("u"))
bind("SUPER + Return",     exec(A.terminal),       F("u"))
bind("SUPER+ALT + Return", exec(A.terminal_float), F("u"))

bind("SUPER + R",     exec(A.menu),              F("u")) -- Windows parallel
bind("XF86HomePage",  exec("A.menu"),            F("u"))

bind("SUPER + v",     exec(A.clipboard),         F("u"))
bind("SUPER+ALT + v", exec(A.emoji),             F("u"))

bind("SUPER + i",     exec(A.config),            F("u")) -- Windows parallel

bind("SUPER + E",     exec(A.fileManager),       F("u")) -- Windows parallel
bind("SUPER+ALT + E", exec(A.fileManager_float), F("u"))

bind("SUPER + n",     exec(A.notepad),           F("u"))

bind("SUPER + B",     exec(A.browser),           F("u"))
bind("SUPER + O",     exec(A.okular),            F("u"))

bind("SUPER + S",     exec(A.music),                          F("u"))
bind("SUPER+ALT + S", cmd(A.specialworkspace_tmp .. A.music), F("u"))
bind("XF86Tools",     cmd(A.specialworkspace_tmp .. A.music), F("u"))

bind("SUPER + W",     exec(A.chat),                           F("u"))
bind("SUPER+ALT + W", cmd(A.specialworkspace_tmp .. A.chat),  F("u"))

bind("SUPER + X",     exec(A.xmpp),                           F("u"))
bind("SUPER+ALT + X", cmd(A.specialworkspace_tmp .. A.xmpp),  F("u"))

bind("SUPER + C",     exec(A.code),                           F("u"))

bind("SUPER + A",     exec(A.anki),                           F("u"))
bind("SUPER+ALT + A", cmd(A.specialworkspace_tmp .. A.anki),  F("u"))

bind("XF86Calculator",       exec(A.calc),       F("u"))
bind("SUPER + KP_Enter",     exec(A.calc),       F("u"))
bind("SUPER + KP_Add",       exec(A.calc),       F("u"))
bind("SUPER+ALT + KP_Enter", exec(A.calc_float), F("u"))
bind("SUPER+ALT + KP_Add",   exec(A.calc_float), F("u"))

--###########################
--# QUICK MENUS & CONTROLS ##
--###########################

bind("SUPER+CTRL+SHIFT + b", exec("scripts/system/bt_toggle.sh"), F("u"))
bind("SUPER+CTRL + b",      exec(A.bluetooth), F("u"))
bind("SUPER+CTRL + n",      exec(A.network),   F("u"))
bind("SUPER+CTRL + v",      exec(A.audio),     F("u"))
bind("SUPER+CTRL+ALT + v",  exec(A.audio_alt), F("u"))
bind("SUPER+CTRL + s",      exec(A.systemctl), F("u"))
bind("SUPER+CTRL + Return", exec(A.systemctl), F("u"))
bind("SUPER+CTRL + m",      exec(A.monitor),   F("u"))
bind("CTRL+SHIFT + Escape", exec(A.monitor),   F("u")) -- Windows parallel


--####################
--# KEYPAD MAPPINGS ##
--####################

-- ==== Un-numlock map ====
bind("ALT + KP_0", shortcut({mods="", key="Insert"}),    F("ulep"))
bind("ALT + KP_1", shortcut({mods="", key="End"}),       F("ulep"))
bind("ALT + KP_2", shortcut({mods="", key="Down"}),      F("ulep"))
bind("ALT + KP_3", shortcut({mods="", key="Page_Down"}), F("ulep"))
bind("ALT + KP_4", shortcut({mods="", key="Left"}),      F("ulep"))
bind("ALT + KP_5", shortcut({mods="", key="Begin"}),     F("ulep"))
bind("ALT + KP_6", shortcut({mods="", key="Right"}),     F("ulep"))
bind("ALT + KP_7", shortcut({mods="", key="Home"}),      F("ulep"))
bind("ALT + KP_8", shortcut({mods="", key="Up"}),        F("ulep"))
bind("ALT + KP_9", shortcut({mods="", key="Page_Up"}),   F("ulep"))

bind("SHIFT+ALT + KP_0", shortcut({mods="SHIFT", key="Insert"}),    F("ulep"))
bind("SHIFT+ALT + KP_1", shortcut({mods="SHIFT", key="End"}),       F("ulep"))
bind("SHIFT+ALT + KP_2", shortcut({mods="SHIFT", key="Down"}),      F("ulep"))
bind("SHIFT+ALT + KP_3", shortcut({mods="SHIFT", key="Page_Down"}), F("ulep"))
bind("SHIFT+ALT + KP_4", shortcut({mods="SHIFT", key="Left"}),      F("ulep"))
bind("SHIFT+ALT + KP_5", shortcut({mods="SHIFT", key="Begin"}),     F("ulep"))
bind("SHIFT+ALT + KP_6", shortcut({mods="SHIFT", key="Right"}),     F("ulep"))
bind("SHIFT+ALT + KP_7", shortcut({mods="SHIFT", key="Home"}),      F("ulep"))
bind("SHIFT+ALT + KP_8", shortcut({mods="SHIFT", key="Up"}),        F("ulep"))
bind("SHIFT+ALT + KP_9", shortcut({mods="SHIFT", key="Page_Up"}),   F("ulep"))

bind("CTRL+ALT + KP_0", shortcut({mods="CTRL", key="Insert"}),    F("ulep"))
bind("CTRL+ALT + KP_1", shortcut({mods="CTRL", key="End"}),       F("ulep"))
bind("CTRL+ALT + KP_2", shortcut({mods="CTRL", key="Down"}),      F("ulep"))
bind("CTRL+ALT + KP_3", shortcut({mods="CTRL", key="Page_Down"}), F("ulep"))
bind("CTRL+ALT + KP_4", shortcut({mods="CTRL", key="Left"}),      F("ulep"))
bind("CTRL+ALT + KP_5", shortcut({mods="CTRL", key="Begin"}),     F("ulep"))
bind("CTRL+ALT + KP_6", shortcut({mods="CTRL", key="Right"}),     F("ulep"))
bind("CTRL+ALT + KP_7", shortcut({mods="CTRL", key="Home"}),      F("ulep"))
bind("CTRL+ALT + KP_8", shortcut({mods="CTRL", key="Up"}),        F("ulep"))
bind("CTRL+ALT + KP_9", shortcut({mods="CTRL", key="Page_Up"}),   F("ulep"))

bind("CTRL+SHIFT+ALT + KP_0", shortcut({mods="CTRL+SHIFT", key="Insert"}),    F("ulep"))
bind("CTRL+SHIFT+ALT + KP_1", shortcut({mods="CTRL+SHIFT", key="End"}),       F("ulep"))
bind("CTRL+SHIFT+ALT + KP_2", shortcut({mods="CTRL+SHIFT", key="Down"}),      F("ulep"))
bind("CTRL+SHIFT+ALT + KP_3", shortcut({mods="CTRL+SHIFT", key="Page_Down"}), F("ulep"))
bind("CTRL+SHIFT+ALT + KP_4", shortcut({mods="CTRL+SHIFT", key="Left"}),      F("ulep"))
bind("CTRL+SHIFT+ALT + KP_5", shortcut({mods="CTRL+SHIFT", key="Begin"}),     F("ulep"))
bind("CTRL+SHIFT+ALT + KP_6", shortcut({mods="CTRL+SHIFT", key="Right"}),     F("ulep"))
bind("CTRL+SHIFT+ALT + KP_7", shortcut({mods="CTRL+SHIFT", key="Home"}),      F("ulep"))
bind("CTRL+SHIFT+ALT + KP_8", shortcut({mods="CTRL+SHIFT", key="Up"}),        F("ulep"))
bind("CTRL+SHIFT+ALT + KP_9", shortcut({mods="CTRL+SHIFT", key="Page_Up"}),   F("ulep"))
