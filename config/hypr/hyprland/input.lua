-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({input = {

	-- Be sure to check out xkb setup
	kb_model   = "",
	kb_layout  = "es,us",
	kb_variant = "",
	kb_options = "eurosign:5,altgreek,undead:es_only,altmath,caps:escape_shifted_capslock,numpad:hex,numpad:operators_ext",
	kb_rules   = "",
	--kb_file	 = ,

	numlock_by_default = false,
	--resolve_binds_by_sym = false,
	left_handed = false,

	--repeat_rate  = ,
	--repeat_delay = ,

	sensitivity   = -0.2, -- -1.0 to 1.0, 0 means no modification
	accel_profile = "custom",
	scroll_points = "0.2144477506 0.000 0.307 0.615 1.077 1.539 2.002 2.505 3.208 3.910 4.613 5.315 6.018 6.720 7.423 8.125 8.828 9.530 10.233 10.935 12.387",

	--scroll_method = ,
	--scroll_button = ,
	--scroll_button_lock = ,
	--scroll_factor = ,
	--natural_scroll = ,
	--emulate_discrete_scroll = ,

	follow_mouse = 2,
	--follow_mouse_shrink    = ,
	--follow_mouse_threshold = ,
	--focus_on_close = ,
	--mouse_refocus  = ,
	--float_switch_override_focus = ,
	--special_fallthrough = false,

	--off_window_axis_events = ,

	-- https://wiki.hypr.land/Configuring/Basics/Variables/#touchpad
	touchpad = {
		--disable_while_typing = true,

		natural_scroll = true,
		scroll_factor = 0.2,
		--flip_x = false,
		--flip_y = false,

		--tap_to_click = true,
		--tap_button_map = "lrm",
		--tap_and_drag = true,

		--drag_3fg = 0,

		--middle_button_emulation = false,
		--clickfinger_behavior = ,
	},

	-- https://wiki.hypr.land/Configuring/Basics/Variables/#touchdevice
	touchdevice = {
		--enabled = ,
		--transform = ,
		--output = ,
	},

	-- https://wiki.hypr.land/Configuring/Basics/Variables/#virtualkeyboard
	virtualkeyboard = {
		--share_states = ,
		--release_pressed_on_close = ,
	},

	-- https://wiki.hypr.land/Configuring/Basics/Variables/#tablet
	tablet = {
		--transform = ,
		--output = ,
		--region_position = ,
		--absolute_region_position = ,
		--region_size = ,
		--relative_input = ,
		--left_handed = ,
		--active_area_size = ,
		--active_area_position = ,
	},

	-- https://wiki.hypr.land/Configuring/Basics/Variables/#tablettool
	tablettool = {
		--eraser_button_mode = ,
		--eraser_button_override = ,
		--pressure_range_min = ,
		--pressure_range_max = ,
	},
}})
