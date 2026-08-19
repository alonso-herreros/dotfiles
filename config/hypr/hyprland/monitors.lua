-- https://wiki.hypr.land/0.56.0/Configuring/Basics/Monitors/

local monitor = hl.monitor
local function monitor_(output, mode, position, scale)
	hl.monitor({ output=output, mode=mode, position=position, scale=scale })
end

-- Fallback
monitor_("", "preferred", "auto", 1)

-- Laptop screen
monitor_("eDP-1", "preferred", "0x0", 1.2)

-- Default HDMi: expecting a monitor to the left. Default scaling
monitor_("HDMI-A-1", "preferred", "auto-left", 1)

-- Home monitor
monitor_("desc:Philips Consumer Electronics Company PHL 241V8 0x00008073", "1920x1080@75Hz", "-1920x-218", 1)
monitor_("desc:LG Electronics M197WD 0x000594EA", "1366x768", "auto-left", 1)

monitor_("desc:Samsung Electric Company SAMSUNG 0x00000800","preferred","auto-left",1)
monitor_("desc:Panasonic Industry Company Panasonic-TV","preferred","auto-right",2)

monitor_("desc:Hewlett Packard HP 24es 3CM70304KR","preferred","auto-up",1)
monitor_("desc:ViewSonic Corporation VX2263 Series U0A182161238","preferred","auto-right",1)


-- ==== Some monitors at uni ====
monitor_("desc:HP Inc. HP P22h G4 3CM2021R3F", "preferred", "auto-left", 1)
monitor_("desc:HP Inc. HP P22 G5 3CM31002MF", "preferred", "auto-left", 1)
monitor_("desc:Hewlett Packard HP P221 3CQ41713GV", "preferred", "auto-left", 1)
-- This one is in a room where the monitor is to the right
monitor_("desc:HP Inc. HP P224 CNK9200VQY", "preferred", "auto-right", 1)
-- Large monitor in lab room
monitor_("desc:Iiyama North America PL2797Q 12501447B2265", "preferred", "1600x-1100", 1.25)
monitor_("desc:Iiyama North America PL2797Q 12501447B2271", "preferred", "1600x-1100", 1.25)
-- Monitor at an office
monitor_("desc:Philips Consumer Electronics Company Philips 244E AU51144014102", "preferred", "-1920x-700", 1)
monitor_("desc:Dell Inc. DELL P2423DE 4DC1614", "preferred", "1600x-400", 1.25)

-- TV screen at uni library
monitor_("desc:LG Electronics LG TV 0x01010101", "preferred", "auto-left", 2)

-- Presentation monitor in meeting room
monitor({
	output="desc:Lightware Visual Engineering Univ_HDMI_PCM",
	mode="preferred",
	position="auto-left",
	scale=1,
	mirror="eDP-1",
})

-- A certain HDMI to VGA adapter that doesn't properly advertise resolutions
monitor_("desc:RGB Systems Inc. dba Extron Electronics Extron HDMI", "1680x1050@60Hz", "auto-left", 1)
