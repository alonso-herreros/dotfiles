local A = require("aliases")

-- https://wiki.hypr.land/Configuring/Basics/Variables/#gestures
hl.config({gestures = {
	--workspace_swipe_distance = ,
	--workspace_swipe_touch = ,
	--workspace_swipe_invert = ,
	--workspace_swipe_touch_invert = ,
	--workspace_swipe_min_speed_to_force = ,
	--workspace_swipe_cancel_ratio = ,
	--workspace_swipe_create_new = ,
	--workspace_swipe_direction_lock = ,
	--workspace_swipe_direction_lock_threshold = ,
	--workspace_swipe_forever = ,
	--workspace_swipe_use_r = ,

	--close_max_timeout = ,
	scrolling = {
		--move_snap_to_grid = ,
		--move_snap_cursor = ,
	}
}})


-- https://wiki.hypr.land/0.56.0/Configuring/Advanced-and-Cool/Gestures/

-- hl.gesture({ fingers=3, direction="pinchout", action="float"})
hl.gesture({ fingers=3, direction="pinchin", action="fullscreen", mode="maximize"})

-- Slower than fusuma
--hl.gesture({ fingers=3, direction="down", action="special", workspace_name="tmp"})
--hl.gesture({ fingers=3, direction="up",
--	action=function()
--		hl.dsp.focus({ workspace="1" })
--	end
--})
-- Doesn't work?
--hl.gesture({ fingers=3, direction="left",
--	action=function()
--		hl.dsp.send_shortcut("CTRL", "Tab", "activewindow")
--	end
--})
--hl.gesture({ fingers=3, direction="right",
--	action=function()
--		hl.dsp.send_shortcut("CTRL SHIFT", "Tab", "activewindow")
--	end
--})

hl.gesture({ fingers=4, direction="pinchout", action="close"})
hl.gesture({ fingers=4, direction="pinchin",
	action = function()
		hl.dsp.exec_cmd(A.terminal)
	end
})

-- Slower than fusuma
-- hl.gesture({ fingers=4, direction="left",
-- 	action=function()
-- 		hl.dsp.exec_raw("playerctl next")
-- 	end
-- })
--hl.gesture({ fingers=4, direction="right",
--	action=function()
--		hl.dsp.exec_raw("playerctl previous")
--	end
--})
