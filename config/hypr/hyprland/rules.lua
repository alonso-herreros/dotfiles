local T = require("theme") -- load theme

-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

local win_rule   = hl.window_rule
local layer_rule = hl.layer_rule
--local ws_rule    = hl.workspace_rule

-- ==== Window states ====
win_rule({match = {fullscreen=1}, border_color=T.green})
win_rule({
	match = {fullscreen_state_client=2},
	border_color = { colors={T.teal,T.sapphire}, angle=45 }
})

win_rule({match = {float=1}, rounding=15, rounding_power=4})
win_rule({match = {pin=1}, border_color=T.rosewater})

win_rule({match = {xwayland=1}, border_color=T.subtext1})


-- ==== Custom class includes float? ====
win_rule({match = {class=".*-float.*"}, float=true})


-- ==== Binding custom titles to workspaces ====
win_rule({match = {class=".*browser", title="1\\..*"}, workspace="1 silent"})
win_rule({match = {class=".*browser", title="2\\..*"}, workspace="2 silent"})
win_rule({match = {class=".*browser", title="3\\..*"}, workspace="3 silent"})
win_rule({match = {class=".*browser", title="4\\..*"}, workspace="4 silent"})
win_rule({match = {class=".*browser", title="5\\..*"}, workspace="5 silent"})
win_rule({match = {class=".*browser", title="6\\..*"}, workspace="6 silent"})
win_rule({match = {class=".*browser", title="7\\..*"}, workspace="7 silent"})
win_rule({match = {class=".*browser", title="8\\..*"}, workspace="8 silent"})
win_rule({match = {class=".*browser", title="9\\..*"}, workspace="9 silent"})
win_rule({match = {class=".*browser", title="0\\..*"}, workspace="99 silent"})

win_rule({match = {class=".*browser", title="1s\\..*"}, workspace="11 silent"})
win_rule({match = {class=".*browser", title="2s\\..*"}, workspace="21 silent"})
win_rule({match = {class=".*browser", title="3s\\..*"}, workspace="31 silent"})
win_rule({match = {class=".*browser", title="4s\\..*"}, workspace="41 silent"})
win_rule({match = {class=".*browser", title="5s\\..*"}, workspace="51 silent"})
win_rule({match = {class=".*browser", title="6s\\..*"}, workspace="61 silent"})
win_rule({match = {class=".*browser", title="7s\\..*"}, workspace="71 silent"})
win_rule({match = {class=".*browser", title="8s\\..*"}, workspace="81 silent"})
win_rule({match = {class=".*browser", title="9s\\..*"}, workspace="91 silent"})
win_rule({match = {class=".*browser", title="0s\\..*"}, workspace="991 silent"})


-- ==== Floating dialogs ====

-- Float Brave login popups (hopefully)
win_rule({match = {class="brave-browser", title="Untitled - Brave"}, float=true})
win_rule({match = {class="brave-clngdbkpkpeebahjckkjfobafhncgmne.*"}, float=true})
win_rule({match = {class="brave-nngceckbapebfimnlniiiahkandclblb.*"}, float=true})
-- Float Bitwarden popups
win_rule({match = {class="brave-nngceckbapebfimnlniiiahkandclblb"}, float=true})

-- Hyprland Share Picker
win_rule({match = {class="hyprland-share-picker"}, float=true, group="barred"})

-- Okular
win_rule({match = {class="org.kde.olukar", title="(Edit .* tool — Okular)"}, float=true})
win_rule({match = {title="New Text Note — Okular"}, float=true})

-- KDE Wallet
win_rule({match = {class="org.kde.kwalletd6"}, float=true})

-- GIMP
win_rule({match = {class="script-fu", title="New Guide"}, float=true})

-- CURA
-- Cura opening sequence
win_rule({match = {title="(UltiMaker-Cura)"}, float=true})
-- Save/Load file popups
win_rule({match = {class=".*Cura", title="(Save|Open)( Cura)? [Pp]roject.*"}, float=true})

-- Save/Open File popups
win_rule({match = {class="xdg.*-portal.*", title="(All Files|[Ss]ave|[Oo]pen).*"}, float=true})
win_rule({match = {title="^Export \\w+ as \\w+$ -- GIMP export dialog"}, float=true})
win_rule({match = {title="^Open a.* file$"}, float=true})
win_rule({match = {title="^$"}, float=true})


-- Menus
win_rule({
	name = "term-mgmt",
	match = {
		class = "term-mgmt.*",
	},
	float = true,
	size = {"(monitor_w*0.3)", "(monitor_h*0.5)"},
	move = {"((monitor_w*1)-window_w-5)", 35},
})

-- Clipse
win_rule({
	name = "clipse",
	match = {
		class = "clipse",
	},
	float = true,
	size = {622, 652},
})


-- ==== Apps ====

-- Brave PWAs
win_rule({match = {class="brave-.*", title="WhatsApp Web"}, fullscreen_state="0 2"})
win_rule({match = {class="brave-.*", title="draw.io"}, fullscreen_state="0 2"})
win_rule({match = {class="brave-.*", title="Google Tasks.*"}, fullscreen_state="0 2"})

-- Brave Dev Tools
win_rule({match = {class="brave-browser", title="DevTools"}, group="barred"})

-- Make Meet fake-fullscreen when popped out
win_rule({match = {class="brave-browser", title="Meet - *"}, fullscreen_state="0 2"})

-- Hypremoji
win_rule({match = {title="^(HyprEmoji)$"}, float=true})

-- Virt Manager
-- Open Virt Manager as grouped
win_rule({match = {class="virt-manager", title="Virtual Machine Manager"}, group="set"})
-- Open Windows 11 VM in pseudo. This helps with resizing
win_rule({match = {class="virt-manager", title="Windows 11.*"}, pseudo=true, max_size={1280, 1280}})

-- Anki
win_rule({match = {class="anki"}, pseudo=true})

-- VS CODE
win_rule({match = {class="code-url-handler"}, opacity=0.9})

-- Minecraft
win_rule({match = {title="Minecraft\\* 1\\..*"}, render_unfocused=true, group="barred"})

-- Autofirma
win_rule({match = {class="AutoFirma", title="AutoFirma v.*"}, tile=true})

-- Steam
win_rule({match = {class="steam"}, tile=true})


-- ==== ALL ====
win_rule({match = {class=".*"}, suppress_event="maximize"}) -- You'll probably like this


--################
--# LAYER RULES ##
--################

-- Blur behind notifications
layer_rule({
	name = "notifications",
	match = {namespace="notifications"},
	blur = true,
	ignore_alpha = 0,
	animation = "slide right",
})


-- Blur behind fuzzel
layer_rule({
	name = "launcher",
	blur = true,
	ignore_alpha = 0,
	match = {namespace="launcher"},
})
