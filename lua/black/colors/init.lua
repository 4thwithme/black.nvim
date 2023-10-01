local white        = "#EEFFFF"
local gray         = "#717CB4"
local black        = "#000000"
local red          = "#a973cd"
local green        = "#a3ce63"
local yellow       = "#FFCB6B"
local blue         = "#8989ce"
local paleblue     = "#B0C9FF"
local cyan         = "#16637e"
local purple       = "#FFCB6B"
local orange       = "#e68a6f"
local pink         = "#5da3e5"
local darkred      = "#DC6068"
local darkgreen    = "#ABCF76"
local darkyellow   = "#c3ae64"
local darkblue     = "#6E98EB"
local darkcyan     = "#71C6E7"
local darkpurple   = "#B480D6"
local darkorange   = "#E2795B"
local punc         = "#a973cd"
local link         = "#80CBC4"
local cursor       = "#FFCC00"
local title        = "#EEFFFF"
local bg           = "#0F111A"
local bg_alt       = "#090B10"
local fg           = "#5da3e5"
local fg_dark      = "#8F93A2"
local selection    = "#1F2233"
local contrast     = "#090B10"
local active       = "#1A1C25"
local border       = "#232637"
local line_numbers = "#3B3F51"
local highlight    = "#1F2233"
local disabled     = "#464B5D"
local accent       = "#84FFFF"
local comments     = "#464B5D"

local colors = {
    ---main colors
    main = {
        white      = white,
        gray       = gray,
        black      = black,
        red        = red,
        green      = green,
        yellow     = yellow,
        blue       = blue,
        paleblue   = paleblue,
        cyan       = cyan,
        purple     = purple,
        orange     = orange,
        pink       = pink,
        darkred    = darkred,
        darkgreen  = darkgreen,
        darkyellow = darkyellow,
        darkblue   = darkblue,
        darkcyan   = darkcyan,
        darkpurple = darkpurple,
        darkorange = darkorange,
        punc       = punc,
    },

    ---colors applied to the editor
    editor = {
        cursor       = cursor,
        link         = link,
        title        = title,
        bg           = bg,
        bg_alt       = bg_alt,
        fg           = fg,
        fg_dark      = fg_dark,
        selection    = selection,
        contrast     = contrast,
        active       = active,
        border       = border,
        line_numbers = line_numbers,
        highlight    = highlight,
        disabled     = disabled,
        accent       = accent,
        comments     = comments,
    },

    lsp = {
        error   = "#FF5370",
        warning = yellow,
        info    = paleblue,
        hint    = purple
    },

    syntax = {
        variable = darkyellow,
        field    = '#B0BEC5',
        keyword  = cyan,
        value    = orange,
        operator = cyan,
        fn       = blue,
        string   = green,
        type     = purple
    },
    git = {
        added    = green,
        removed  = red,
        modified = blue
    },
    backgrounds = {
        sidebars            = bg,
        floating_windows    = bg,
        non_current_windows = bg,
        cursor_line         = active
    },
}

return colors