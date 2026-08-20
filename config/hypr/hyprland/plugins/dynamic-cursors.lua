-- https://wiki.hypr.land/Plugins/Using-Plugins/
-- https://github.com/VirtCode/hypr-dynamic-cursors

hl.config({plugin = { dynamic_cursors = {
	enabled = true,

	mode = "tilt",

	threshold = 8, -- Angle difference in degrees to update shape

	-- == Modes ==
	rotate = {
		length = 20,  -- Length of the simulated stick (px). Preferrably your cursor size
		offset = 0.0, -- Clockwise offset applied to the angle in degrees
	},
	tilt = {
		limit    = 800,           -- Speed to reach full tilt (px/s)
		activation = "quadratic", -- Relationship between speed and tilt
		--window = ,
		--full = ,
	},
	stretch = {
		limit    = 500,                    -- Speed to reach full stretch (px/s)
		activation = "negative_quadratic", -- Relationship between speed and stretch amount
		--window = ,
	},

	-- == Shake to Find ==
	shake = {
		enabled   = true,

		threshold = 3.0,   -- How soon a shake is detected (lower is sooner)
		base      = 4.0,   -- Magnification level immediately after shake start
		speed     = 2.0,   -- Magnification increase per second when continuing to shake
		influence = 2.0,   -- How much the speed is influenced by the shake intensitiy
		limit     = 8,     -- Max magnification the cursor can reach. 0 to disable.

		effects   = false, -- Show cursor behaviour `tilt`, `rotate`, etc. while shaking

		timeout   = 000,   -- Time in ms the cursor will stay magnified after the shake

		ipc       = false, -- Enable ipc events for shake
	},

	-- == Hyprcursor ==
	hyprcursor = {
		enabled = true,

		-- Use nearest-neighbour scaling when magnifing beyond texture size
		-- This will also have effect without hyprcursor support being enabled
		-- 0 / false - Never use pixelated scaling
		-- 1 / true  - Use pixelated when no highres image
		-- 2         - Always use pixleated scaling
		nearest = true,

		-- Resolution in pixels to load the magnified shapes at
		-- -1 means we use [normal cursor size] * [shake:base option]
		resolution = -1,

		-- Shape to use when clientside cursors are being magnified
		-- See the `shape-name` property of shape rules for possible names
		fallback = "clientside",
	},
}}})


-- == Overrides ==

local shape_rule = hl.plugin.dynamic_cursors.shape_rule

shape_rule({shape="text", mode="tilt", tilt={limit=1500}})
-- shape_rule({shape="grab", mode="rotate", rotate={offset=180}})
shape_rule({shape="grabbing", mode="rotate", rotate={offset=180}})
