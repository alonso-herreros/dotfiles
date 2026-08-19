local T = require("theme") -- load theme

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({general = {
	border_size = 2,

	gaps_in = 3,
	gaps_out = 3,
	float_gaps = -1, -- -1 means default
	--gaps_workspaces = 0,

	-- see https://wiki.hypr.land/Configuring/Basics/Variables/#variable-types
	col = {
		active_border = {
			colors={T.sapphire .. "dd", T.teal .. "dd"},
			angle= 45
		},
		inactive_border = T.base .. "dd",
		--nogroup_border = ,
		--nogroup_border_active = ,
	},

	layout = "dwindle",
	--no_focus_fallback = false,

	resize_on_border = true,
	extend_border_grab_area = 3,
	hover_icon_on_hover = true,

	-- https://wiki.hyprland.org/Configuring/Tearing/
	allow_tearing = true,

	--resize_corner = 0,

	modal_parent_blocking = false,

	--locale = ,

	-- https://wiki.hypr.land/Configuring/Basics/Variables/#snap
	snap = {
		enabled = true,
		--window_gap = ,
		--monitor_gap = ,
		border_overlap = true,
		respect_gaps = true,
	}
}})
