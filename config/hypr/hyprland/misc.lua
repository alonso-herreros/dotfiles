-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
hl.config({misc = {
	--font_family = ,

	disable_autoreload = true,

	disable_hyprland_logo = false, -- Disables the logo/anime girl backgrounds :(
	--background_color = ,
	force_default_wallpaper = 0, -- 0 or 1 to disable the anime mascot wallpapers

	disable_splash_rendering = true,
	--splash_font_family = ,
	col = {
		--splash = ,
	},

	vrr = 2,

	--mouse_move_enables_dpms = false,
	key_press_enables_dpms = true,

	--name_vk_after_proc = true,

	--always_follow_on_dnd = true,
	--layers_hog_keyboard_focus = true,
	--focus_on_activate = false,
	--mouse_move_focuses_monitor = true,

	--animate_manual_resizes = false,
	--animate_manual_windowdragging = false,

	enable_swallow = false,
	swallow_regex = "^kitty$",
	swallow_exception_regex = "^(kitty|wev$)",

	allow_session_lock_restore = true, -- hyprlock has a habit of... dying
	--session_lock_xray = false,
	--session_lock_blur = false,
	--lockdead_screen_delay = 1000

	close_special_on_empty = true,

	on_focus_under_fullscreen = 2,
	--exit_window_retains_fullscreen = 2

	initial_workspace_tracking = 1,
	--initial_workspace_token_timeout = ,

	--middle_click_paste = true,

	--render_unfocused_fps = 15,

	enable_anr_dialog = true, -- Enable the ANR dialog
	anr_missed_pings = 10, -- Number of missed pings before ANR is triggered

	size_limits_tiled = true,

	--screencopy_force_8b = true,

	--disable_xdg_env_checks = false
	--disable_hyprland_guiutils_check = false
	--disable_watchdog_warning = false,
	disable_scale_notification = false,
}})
