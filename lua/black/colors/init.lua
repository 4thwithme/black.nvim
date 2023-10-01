local high_visibility = require "lua.black.util.config".settings.high_visibility

---colors table
local colors = {
    ---main colors
    main = {
        white      = "#EEFFFF",
        gray       = "#717CB4",
        black      = "#000000",
        red        = "#a973cd",
        green      = "#a3ce63", --
        yellow     = "#FFCB6B",
        blue       = "#8989ce", --
        paleblue   = "#B0C9FF",
        cyan       = "#16637e", --
        purple     = "#FFCB6B", --
        orange     = "#e68a6f", --
        pink       = "#5da3e5", --

        darkred    = "#DC6068",
        darkgreen  = "#ABCF76",
        darkyellow = "#c3ae64", --
        darkblue   = "#6E98EB",
        darkcyan   = "#71C6E7",
        darkpurple = "#B480D6",
        darkorange = "#E2795B",
        punc       = "#a973cd",
    },

    ---colors applied to the editor
    editor = {
        link   = "#80CBC4",
        cursor = "#FFCC00",
        title  = "#EEFFFF",
    },

    lsp = {
        error = "#FF5370",
    },

    syntax = {},
    git = {},
    backgrounds = {},
}

-- Style specific colors

if vim.g.black_style == "deep ocean" then
    -- Deep Ocean theme style

    colors.editor.bg           = "#0F111A" --
    colors.editor.bg_alt       = "#090B10"
    colors.editor.fg           = "#5da3e5"
    colors.editor.fg_dark      = "#8F93A2"
    colors.editor.selection    = "#1F2233"
    colors.editor.contrast     = "#090B10"
    colors.editor.active       = "#1A1C25"
    colors.editor.border       = "#232637"
    colors.editor.line_numbers = "#3B3F51"
    colors.editor.highlight    = "#1F2233"
    colors.editor.disabled     = "#464B5D"
    colors.editor.accent       = "#84FFFF"
    colors.syntax.comments     = "#464B5D"
end

---syntax colors
colors.syntax.variable = colors.main.darkyellow --
colors.syntax.field    = '#B0BEC5' --
colors.syntax.keyword  = colors.main.cyan --
colors.syntax.value    = colors.main.orange --
colors.syntax.operator = colors.main.cyan --
colors.syntax.fn       = colors.main.blue --
colors.syntax.string   = colors.main.green --
colors.syntax.type     = colors.main.purple --

---git colors
colors.git.added    = colors.main.green
colors.git.removed  = colors.main.red
colors.git.modified = colors.main.blue

---lsp colors
colors.lsp.warning = colors.main.yellow
colors.lsp.info    = colors.main.paleblue
colors.lsp.hint    = colors.main.purple

---contrasted backgrounds
colors.backgrounds.sidebars            = colors.editor.bg
colors.backgrounds.floating_windows    = colors.editor.bg
colors.backgrounds.non_current_windows = colors.editor.bg
colors.backgrounds.cursor_line         = colors.editor.active

return colors
