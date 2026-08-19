-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({decoration = {
	rounding = 10,
	rounding_power = 2, -- circle

	active_opacity = 1.0,
	inactive_opacity = 0.9,
	--fullscreen_opacity = 1.0,

	dim_modal = true,
	--dim_inactive = false,
	--dim_strength = 0.5,
	--dim_special = 0.2,
	--dim_around = 0.4,

	border_part_of_window = true,

	--screen_shader = ,

	-- https://wiki.hyprland.org/Configuring/Variables/#blur
	blur = {
		enabled = true,
		size   = 8,
		passes = 2,

		ignore_opacity    = true,
		xray              = false,
		--new_optimizations = true,

		--noise           = ,
		contrast          = 1,
		brightness        = 0.8172,
		vibrancy          = 0.25,
		vibrancy_darkness = 0.25,

		special = false,

		popups  = true,
		--popups_ignorealpha = ,

		input_methods = true,
		--input_methods_ignorealpha = ,
	},

	-- https://wiki.hyprland.org/Configuring/Variables/#shadow
	shadow = {
		enabled = true,
		sharp = false,

		range        = 4,
		--offset       = ,
		render_power = 3,
		--scale        = ,

		color = "#1a1a1aee",
		--color_inactive = "#1a1a1aee",
	},

	glow = {
		--enabled = false,
		--range = ,
		--render_power = ,
		--color = ,
		--color_inactive = ,
	},

	motion_blur = {
		--enabled = false,
		--samples = ,
	}
}})
