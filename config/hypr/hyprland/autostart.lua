-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpm reload")
	hl.exec_cmd("dconf write /org/gnome/desktop/interface/cursor-theme \"'BreezeX-RosePine-Linux'\"")
	hl.exec_cmd("dconf write /org/gnome/desktop/interface/cursor-size 28")
end
)
