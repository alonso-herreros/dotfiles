-- Host and user in header bar
-- Header:children_add(function()
-- 	if ya.target_family() ~= "unix" then
-- 		return ""
-- 	end
-- 	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
-- end, 500, Header.LEFT)

-- -- Link target in status bar
-- Status:children_add(function(self)
-- 	local h = self._current.hovered
-- 	if h and h.link_to then
-- 		return " -> " .. tostring(h.link_to)
-- 	else
-- 		return ""
-- 	end
-- end, 3300, Status.LEFT)

-- Owner in status bar
-- Status:children_add(function()
-- 	local h = cx.active.current.hovered
-- 	if h == nil or ya.target_family() ~= "unix" then
-- 		return ""
-- 	end

-- 	return ui.Line {
-- 		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
-- 		":",
-- 		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
-- 		" ",
-- 	}
-- end, 500, Status.RIGHT)

-- ==== Yatline ====
require("yatline"):setup({
	--theme = my_theme,
	section_separator = { open = "", close = "" },
	part_separator = { open = "", close = "" },
	inverse_separator = { open = "", close = "" },

	style_a = {
		fg = "white",
		bg_mode = {
			normal = "blue",
			select = "brightyellow",
			un_set = "brightred"
		}
	},
	style_b = { bg = "brightblack", fg = "brightwhite" },
	style_c = { bg = "black", fg = "brightwhite" },

	permissions_t_fg = "green",
	permissions_r_fg = "yellow",
	permissions_w_fg = "red",
	permissions_x_fg = "cyan",
	permissions_s_fg = "white",

	tab_width = 20,
	tab_use_inverse = false,

	selected = { icon = "󰻭", fg = "yellow" },
	copied = { icon = "", fg = "green" },
	cut = { icon = "", fg = "red" },

	total = { icon = "󰮍", fg = "yellow" },
	succ = { icon = "", fg = "green" },
	fail = { icon = "", fg = "red" },
	found = { icon = "󰮕", fg = "blue" },
	processed = { icon = "󰐍", fg = "green" },

	show_background = true,

	display_header_line = true,
	display_status_line = true,

	component_positions = { "header", "tab", "status" },

	header_line = {
		left = {
			section_a = {
				{type = "line", custom = false, name = "tabs", params = {"left"}},
			},
			section_b = {
			},
			section_c = {
			}
		},
		right = {
			section_a = {
			},
			section_b = {
			},
			section_c = {
				{type = "coloreds", custom = false, name = "count"},
			}
		}
	},

	status_line = {
		left = {
			section_a = {
				{type = "string", custom = false, name = "tab_mode"},
			},
			section_b = {
				{type = "string", custom = false, name = "tab_path", params = { trimed = false, max_length=24, trim_length=10 }},
			},
			section_c = {
				-- {type = "string", custom = false, name = "hovered_name", params = { trimed = false, show_symlink = true, max_length=24, trim_length=10 }},
			}
		},
		right = {
			section_a = {
				{type = "string", custom = false, name = "cursor_position"},
			},
			section_b = {
				-- {type = "string", custom = false, name = "hovered_mime"},
				{type = "string", custom = false, name = "hovered_size"},
			},
			section_c = {
				{type = "coloreds", custom = false, name = "permissions"},
			}
		}
	},
})

-- ==== GIT ====
th = th or {}
th.git = th.git or {}
th.git.added_sign = "A"
th.git.untracked_sign = "?"
th.git.modified_sign = "M"
th.git.deleted_sign = "D"
th.git.updated_sign = "U"
th.git.ignored_sign = "I"
require("git"):setup()

-- ==== Smart enter ====
require("smart-enter"):setup {
	open_multi = true,
}

-- ==== Bookmarks ====
require("whoosh"):setup({
	bookmarks = {
			{ key="~", path="~",           tag="Home (~)" },
			{ key="h", path="~",           tag="Home (~)" },
			{ key="H", path="/home",       tag="Homes (/home)" },
			{ key="/", path="/",           tag="Root (/)" },
			{ key="r", path="/",           tag="Root (/)" },
			{ key="v", path="/virt",       tag="/virt" },
			{ key=".", path="~/.dotfiles", tag=".dotfiles" },
			{ key="c", path="~/.config",   tag=".config" },
			{ key="l", path="~/.local",    tag=".local" },
			{ key="h", path="~/.cache",    tag=".cache" },
			{ key="D", path="~/Documents", tag="Documents" },
			{ key="P", path="~/Pictures",  tag="Pictures" },
			{ key="V", path="~/Videos",    tag="Videos" },
			{ key="M", path="~/Music",     tag="Music" },
			{ key="O", path="~/Downloads", tag="Downloads" },
			{ key="K", path="~/Desktop",   tag="Desktop" },
			{ key="B", path="~/Public",    tag="Public" },
			{ key="p", path="~/Projects",  tag="Projects" },
			{ key="t", path="~/tmp",       tag="tmp" },
			{ key="T", path="~/.local/share/Trash", tag="Trash" },
			{ key={"d", "1"}, path="~/Documents/Global/1. Personal",     tag="Docs: personal" },
			{ key={"d", "2"}, path="~/Documents/Global/2. Professional", tag="Docs: professional" },
			{ key={"d", "3"}, path="~/Documents/Global/3. Education",    tag="Docs: education" },
			{ key={"d", "4"}, path="~/Documents/Global/4. Health",       tag="Docs: health" },
			{ key={"d", "5"}, path="~/Documents/Global/5. Logistics",    tag="Docs: logistics" },
			{ key={"d", "6"}, path="~/Documents/Global/6. Financial",    tag="Docs: financial" },
			{ key={"d", "7"}, path="~/Documents/Global/7. Life",         tag="Docs: life" },
			{ key={"d", "8"}, path="~/Documents/Global/8. Bureaucracy",  tag="Docs: bureaucracy" },
			{ key={"d", "9"}, path="~/Documents/Global/9. Misc",         tag="Docs: misc" },
	},

	special_keys = {
		create_temp = "<Enter>",
		fuzzy_search = "<Space>",
		history = "<Tab>",
		previous_dir = "-",
		project_root = "_"
	},
})

-- ==== Custom Shell ====
require("custom-shell"):setup({
    history_path = "default",
    save_history = true,
})
