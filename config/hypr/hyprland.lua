-- hyprland.lua
-- Tuned by Alonso Herreros <alonso.herreros.c@gmail.com>

--------------------
-- INCLUDED FILES --
--------------------

require("hyprland/general")    -- General matters

require("hyprland/decoration") -- Decorations
require("hyprland/group")      -- Groups and groupbars
require("hyprland/animations") -- Animations
require("hyprland/layout")     -- Layout config

require("hyprland/input")      -- Input
require("hyprland/devices")    -- Devices
require("hyprland/gestures")   -- Touchpad / touchscreen gestures
require("hyprland/binds")      -- Keybinds
require("hyprland/cursor")     -- Cursor config

require("hyprland/opengl")     -- OpenGL config
require("hyprland/render")     -- Render config
require("hyprland/monitors")   -- Monitor config

-- env vars at `~/.config/uwsm/{env,env-hyprland}` and `~/.config/environment.d/`
require("hyprland/autostart")  -- Autostart things

require("hyprland/rules")      -- Window and Workspace Rules

require("hyprland/xwayland")   -- XWayland
require("hyprland/debug")      -- Debug config
require("hyprland/ecosystem")  -- Ecosystem
require("hyprland/quirks")     -- Quirks
require("hyprland/misc")       -- Misc
