local T = require("theme") -- load theme

-- https://wiki.hypr.land/Configuring/Basics/Variables/#group
hl.config({group = {
	auto_group = true,
	insert_after_current = true,
	focus_removed_window = true,

	drag_into_group                      = 1,
	merge_groups_on_drag                 = false,
	merge_groups_on_groupbar             = true,
	merge_floated_into_tiled_on_groupbar = true,
	group_on_movetoworkspace             = false,

	col = {
		border_active = {
			colors = { T.sapphire .. "dd", T.teal .. "dd" }, angle = 45,
		},
		border_locked_active = {
			colors = { T.sapphire .. "dd", T.teal .. "dd" }, angle = 45,
		},
		border_inactive        = T.base .. "dd",
		border_locked_inactive = T.base .. "dd",
	},

	-- https://wiki.hypr.land/Configuring/Basics/Variables/#groupbar
	groupbar = {
		enabled           = true,
		disable_when_only = false,

		stacked = false,
		--priority = ,

		height            = 15,
		--rounding_power  = 2.0,
		blur              = true,

		scrolling = false,
		middle_click_close = true,

		-- Window titles
		render_titles = true,
		font_family = "JetBrainsMono Nerd Font",
		font_size   = 14,
		font_weight_active   = "bold",
		font_weight_inactive = "normal",
		text_offset = 0,
		text_padding = 5,
		text_color = "#ffffffff",
		text_color_inactive = T.text,
		--text_color_locked_active = "#ffffffff",
		--text_color_locked_inactive = T.text,

		-- The 'indicator' is a bar below the title
		indicator_height = 0,
		rounding         = 0,
		round_only_edges = true,
		--indicator_gap = ,

		-- The 'gradient' is the shadow under the title
		gradients                 = true,
		gradient_rounding         = 8,
		gradient_round_only_edges = false,
		gaps_in  = 3,
		gaps_out = 1,
		keep_upper_gap = false,

		-- see https://wiki.hypr.land/Configuring/Basics/Variables/#variable-types
		col = {
			active          = T.surface1 .. "dd",
			locked_active   = "#7f3d46dd",
			inactive        = T.crust .. "bb",
			locked_inactive = "#530914cc",
			-- locked_inactive = rgba(45161ebb),
		},
	},
}})
