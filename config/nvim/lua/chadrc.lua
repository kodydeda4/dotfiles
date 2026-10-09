-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "tokyonight",

	-- pure black background (editor + side panels like nvim-tree)
	changed_themes = {
		tokyonight = {
			base_30 = {
				black = "#000000",
				darker_black = "#000000",
			},
		},
	},
}

M.ui = {
  statusline = {
    -- no separator glyphs, just a space between sections (OLED: all black)
    separator_style = { left = " ", right = " " },
  },
}

return M
