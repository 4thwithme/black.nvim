local settings = require "black.util.config".settings

local M = {}

---checks if the user uses lualine and then sets the lualine theme
local set_lualine = function()
    local has_lualine, lualine = pcall(require, "lualine")
    if has_lualine then
        lualine.setup {
            options = {
                theme = "auto"
            }
        }
    end
end

M.change_style = function()
    set_lualine()
    vim.cmd "colorscheme black"
end

---toggle the end-of-buffer lines (~)
M.toggle_eob = function()
    local colors = require("black.colors").editor

    settings.disable.eob_lines = not settings.disable.eob_lines

    if settings.disable.eob_lines then
        vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = colors.bg })
    else
        vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = colors.disabled })
    end
end


return M
