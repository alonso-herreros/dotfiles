-- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
hl.config({dwindle = {
	force_split = 2,
	preserve_split = true,
	--smart_split = false,
	--smart_resizing = true,
	--permanent_direction_override = false,
	--special_scale_factor = 1,

	-- This will give priority to vertical splits if W/H ratio isn't *that* high
	split_width_multiplier = 1.6,

	--use_active_for_splits = true,

	-- Wish it worked huh? this breaks shit
	--default_split_ratio = 1.3,
	--split_bias = 1,

	--precise_mouse_move = false,
}})
