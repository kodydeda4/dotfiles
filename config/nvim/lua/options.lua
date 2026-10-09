require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.o.cmdheight = 0 -- hide the command line row until it is needed

-- OLED look: no background anywhere (transparent), including the statusline (St_*) and the
-- buffer tabs (Tb*). Colored blocks become colored text on black.
-- Re-applied after NvChad lazily loads plugin colors (nvim-tree, tabufline).
local BLACK = "NONE" -- transparent: let the terminal background (and its blur) show through

local function is_dark(c)
  local r, g, b = bit.rshift(c, 16), bit.band(bit.rshift(c, 8), 0xff), bit.band(c, 0xff)
  return (0.299 * r + 0.587 * g + 0.114 * b) < 90
end

local function oled()
  for _, group in ipairs {
    "Normal", "NormalNC", "EndOfBuffer", "SignColumn", "StatusLine", "StatusLineNC",
    "TabLine", "TabLineFill", "TabLineSel",
    "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer",
  } do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    vim.api.nvim_set_hl(0, group, vim.tbl_extend("force", hl, { bg = BLACK }))
  end

  for name in pairs(vim.api.nvim_get_hl(0, {})) do
    if name:match "^St_" or name:match "^Tb" then
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      local new = vim.tbl_extend("force", {}, hl)
      if hl.bg and not is_dark(hl.bg) then
        -- colored block -> colored text
        new.fg = hl.bg
      end
      new.bg = BLACK
      vim.api.nvim_set_hl(0, name, new)
    end
  end
end

oled()
-- NvChad loads the tab bar's colors lazily (when a file opens), so re-apply
-- on those events and once more shortly after startup.
vim.api.nvim_create_autocmd({ "VimEnter", "BufAdd", "BufEnter", "BufWinEnter", "ColorScheme", "FileType" }, {
  callback = function() vim.schedule(oled) end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "FilePost",
  callback = function() vim.defer_fn(oled, 50) end,
})
