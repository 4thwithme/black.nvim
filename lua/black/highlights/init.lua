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


local config                 = require("black.util.config")
local settings               = config.settings
local plugins                = require("black.highlights.plugins.init");
local styles                 = settings.styles;


local m                      = colors.main
local e                      = colors.editor
local g                      = colors.git
local l                      = colors.lsp
local s                      = colors.syntax
local b                      = colors.backgrounds

local M                      = {}

---main highlight functions
M.main_highlights            = {}

---async highlight functions
M.async_highlights           = {}

---regular Vim syntax highlights
M.main_highlights.syntax     = function()
	local syntax_hls        = {
		Identifier     = { fg = e.fg },
		Comment        = { fg = s.comments },
		Keyword        = { fg = s.keyword, bold = true },
		Conditional    = { fg = s.keyword, bold = true },
		Function       = { fg = s.fn, bold = true },
		Repeat         = { fg = s.keyword, bold = true },
		String         = { fg = s.string, bold = true },
		Type           = { fg = s.type, bold = true },
		StorageClass   = { fg = m.cyan, bold = true }, -- static, register, volatile, etc.
		Structure      = { fg = s.type, bold = true },
		SpecialComment = { link = "Comment" },       -- special things inside a comment
		Constant       = { fg = m.yellow, bold = true },
		Number         = { fg = s.value, bold = true },
		Character      = { link = "Number" },
		Boolean        = { link = "Number", bold = true },
		Float          = { link = "Number", bold = true },
		Statement      = { fg = m.cyan, bold = true },
		Label          = { fg = s.keyword, bold = true }, -- case, default, etc.
		Operator       = { fg = s.operator, bold = true },
		Exception      = { fg = m.red },
		Macro          = { fg = m.cyan, bold = true },
		Include        = { link = "Macro" },
		-- Define         = { link = "Macro" },
		-- PreProc        = { link = "Macro" },
		-- PreCondit   = { link = "Macro" },
		-- Typedef        = { link = "Operator" },
		Special        = { fg = m.cyan, bold = true },
		SpecialChar    = { fg = m.red },
		Tag            = { fg = m.red },
		Delimiter      = { fg = s.operator, bold = true }, -- ;
		Debug          = { fg = m.red },
		htmlLink       = { fg = e.link, underline = true },
		-- htmlH1         = { fg = m.cyan, bold = true },
		-- htmlH2         = { fg = m.red, bold = true },
		-- htmlH3         = { fg = m.green, bold = true },
	}

	-- apply the user set styles for these groups
	syntax_hls.Comment      = vim.tbl_extend("keep", syntax_hls.Comment, styles.comments)
	syntax_hls.Conditional  = vim.tbl_extend("keep", syntax_hls.Conditional, styles.keywords)
	syntax_hls.Function     = vim.tbl_extend("keep", syntax_hls.Function, styles.functions)
	syntax_hls.Identifier   = vim.tbl_extend("keep", syntax_hls.Identifier, styles.variables)
	syntax_hls.Keyword      = vim.tbl_extend("keep", syntax_hls.Keyword, styles.keywords)
	syntax_hls.Repeat       = vim.tbl_extend("keep", syntax_hls.Repeat, styles.keywords)
	syntax_hls.String       = vim.tbl_extend("keep", syntax_hls.String, styles.strings)
	syntax_hls.Type         = vim.tbl_extend("keep", syntax_hls.Type, styles.types)
	syntax_hls.Structure    = vim.tbl_extend("keep", syntax_hls.Structure, styles.types)
	syntax_hls.StorageClass = vim.tbl_extend("keep", syntax_hls.StorageClass, styles.keywords)

	return syntax_hls
end

---treesitter highlights
M.main_highlights.treesitter = function()
	if vim.fn.has("nvim-0.8.0") == 1 then
		local treesitter_hls = {
			["@type"]                   = { fg = s.type, bold = true },
			["@type.builtin"]           = { fg = s.type, bold = true },
			["@type.qualifier"]         = { fg = s.type, bold = true },

			["@variable"]               = { link = "Identifier" },
			["@variable.builtin"]       = { fg = "#9b30b9", italic = true, bold = true },
			["@field"]                  = { fg = e.fg_dark, bold = true },
			["@property"]               = { fg = e.fg_dark },
			["@parameter"]              = { fg = "#7a61e7", italic = true, bold = true }, -- TODO
			["@symbol"]                 = { fg = m.yellow, bold = true },

			["@function.builtin"]       = { fg = s.fn, bold = true },
			-- ["@function.macro"]   = { link = "Function" },
			["@constructor"]            = { fg = m.blue, bold = true },

			["@keyword"]                = { fg = m.cyan, bold = true },

			["@constant"]               = { fg = m.yellow, bold = true },
			["@constant.builtin"]       = { fg = m.yellow, bold = true },
			["@constant.macro"]         = { fg = m.yellow, bold = true },

			["@preproc"]                = { fg = m.cyan, bold = true },
			["@macro"]                  = { fg = m.cyan, bold = true },
			["@namespace"]              = { fg = m.yellow, bold = true },

			["@string.escape"]          = { fg = e.fg_dark },
			["@string.regex"]           = { fg = m.yellow },
			["@string.special"]         = { fg = e.fg_dark },

			["@text.diff.add"]          = { link = "DiffAdd" },
			["@text.diff.delete"]       = { link = "DiffDelete" },
			["@attribute"]              = { link = "DiffChange" },

			-- ["@structure"]             = { fg = s.type },
			-- ["@storageclass"]          = { fg = m.cyan },

			["@label"]                  = { fg = m.yellow },
			["@punctuation"]            = { fg = m.punc },
			["@punctuation.delimiter"]  = { fg = m.punc },
			-- ["@punctuation.bracket"]    = { fg = m.cyan },
			-- ["@punctuation.special"]    = { fg = m.cyan },
			-- ["@text.underline"]         = { underline = true },
			["@text.emphasis"]          = { italic = true },
			["@text.strong"]            = { bold = true },
			["@text.title"]             = { fg = m.cyan, bold = true },
			["@text.literal"]           = { fg = m.green, bold = true },
			["@text.uri"]               = { fg = e.link },
			["@text.note"]              = { fg = m.yellow, bold = true },
			["@text.environment"]       = { fg = m.red },
			["@text.environment.name"]  = { fg = m.red },
			-- ["@text.warning"]           = { fg = l.warning },
			-- ["@text.danger"]            = { fg = l.error },
			["@tag"]                    = { fg = m.red },
			["@tag.delimiter"]          = { fg = m.cyan, bold = true },
			["@tag.attribute"]          = { fg = m.purple },
			TreesitterContext           = { bg = e.contrast },
			TreesitterContextLineNumber = { fg = e.line_numbers, bg = e.contrast },
		}

		return treesitter_hls
	else
		local treesitter_hls = {
			TSType            = { fg = s.type },
			TSTypeBuiltin     = { fg = s.type },

			TSVariableBuiltin = { link = "Identifier" },
			TSField           = { fg = e.fg_dark },
			TSSymbol          = { fg = m.yellow },

			TSFuncBuiltin     = { fg = s.fn },
			TSFuncMacro       = { link = "Function" },
			TSConstructor     = { link = "Function" },

			TSKeyword         = { fg = m.cyan },

			TSConstant        = { fg = m.yellow },
			TSConstantBuiltin = { fg = m.yellow },
			TSConstantMacro   = { fg = m.cyan },

			TSMacro           = { fg = m.cyan },
			TSNamespace       = { fg = m.yellow },

			TSStringEscape    = { fg = e.fg_dark },
			TSStringRegex     = { fg = m.yellow },
			TSStringSpecial   = { fg = e.fg_dark },

			TSPunct           = { fg = m.cyan },
			TSPunctDelimiter  = { fg = m.cyan },
			TSPunctBracket    = { fg = e.title },
			TSURI             = { fg = e.link },
			TSTag             = { fg = m.red },
			TSTagDelimiter    = { fg = m.cyan },
			TSTagAttribute    = { fg = m.purple },
			TSTodo            = { fg = colors.yellow },
		}

		return treesitter_hls
	end
end

---parts of the editor that get loaded right away
M.main_highlights.editor     = function()
	local editor_hls = {
		Normal           = { fg = e.fg, bg = e.bg },
		NormalFloat      = { fg = e.fg, bg = b.floating_windows },
		NormalContrast   = { fg = e.fg, bg = e.bg_alt }, -- a help group for contrast fileypes
		ColorColumn      = { fg = m.none, bg = e.active },
		Conceal          = { fg = e.disabled },
		Cursor           = { fg = e.bg_alt, bg = e.cursor },
		CursorIM         = { link = "Cursor" }, -- like Cursor, but used when in IME mode
		ErrorMsg         = { fg = l.error },
		Folded           = { fg = e.disabled, bg = e.bg_alt, italic = true },
		FoldColumn       = { fg = m.blue },
		LineNr           = { fg = e.line_numbers },
		CursorLineNr     = { fg = e.accent },
		DiffAdd          = { fg = g.added, reverse = true },
		DiffChange       = { fg = g.modified },
		DiffDelete       = { fg = g.removed, reverse = true },
		DiffText         = { fg = g.modified, reverse = true },
		ModeMsg          = { fg = e.accent }, -- 'showmode' message (e.g., "-- INSERT -- ")
		NonText          = { fg = e.disabled },
		SignColumn       = { fg = e.fg },
		SpecialKey       = { fg = m.purple },
		StatusLine       = { fg = e.fg, bg = e.active },
		StatusLineNC     = { fg = e.disabled, bg = e.bg },
		StatusLineTerm   = { fg = e.fg, bg = e.active },
		StatusLineTermNC = { fg = e.disabled, bg = e.bg },
		TabLineFill      = { fg = e.fg },
		TablineSel       = { fg = e.bg, bg = e.accent },
		Tabline          = { fg = e.fg },
		Title            = { fg = m.cyan, bold = true },
		WarningMsg       = { fg = m.yellow },
		Whitespace       = { fg = e.disabled },
		CursorLine       = { bg = b.cursor_line },
		CursorColumn     = { link = "CursorLine" },
		Todo             = { fg = m.yellow, bold = true },
		Ignore           = { fg = e.disabled },
		Underlined       = { fg = e.links, underline = true },
		Error            = { fg = l.error, bold = true },
	}

	return editor_hls
end

---parts of the editor that get loaded asynchronously
M.async_highlights.editor    = function()
	local editor_hls = {
		NormalNC      = { bg = b.non_current_windows },
		FloatBorder   = { fg = e.border, bg = b.floating_windows },
		SpellBad      = { fg = m.red, italic = true, undercurl = true },
		SpellCap      = { fg = m.blue, italic = true, undercurl = true },
		SpellLocal    = { fg = m.cyan, italic = true, undercurl = true },
		SpellRare     = { fg = m.purple, italic = true, undercurl = true },
		Warnings      = { fg = m.yellow, bold = true, },
		healthError   = { fg = l.error, bold = true, },
		healthSuccess = { fg = m.yellow },
		healthWarning = { fg = m.yellow },
		Visual        = { fg = m.none, bg = e.selection },
		VisualNOS     = { link = "Visual" }, -- Visual mode selection when vim is "Not Owning the Selection".
		Directory     = { fg = m.blue },
		MatchParen    = { fg = m.yellow, bold = true },
		IncSearch     = { fg = e.title, underline = true, reverse = true },
		Question      = { fg = m.yellow }, -- |hit-enter| prompt and yes/no questions
		QuickFixLine  = { fg = e.highlight, bg = e.title, reverse = true },
		Search        = { fg = e.title, bold = true, reverse = true },
		MoreMsg       = { fg = e.accent },
		Pmenu         = { fg = e.fg, bg = e.border },     -- popup menu
		PmenuSel      = { fg = e.contrast, bg = e.accent }, -- Popup menu: selected item.
		PmenuSbar     = { bg = e.active },
		PmenuThumb    = { fg = e.fg },
		WildMenu      = { fg = m.orange, bold = true }, -- current match in 'wildmenu' completion
		VertSplit     = { fg = e.vsplit },
		WinSeparator  = { fg = e.vsplit },
		diffAdded     = { fg = g.added, bold = true, },
		diffRemoved   = { fg = g.removed, bold = true, },
		-- ToolbarLine   = { fg = e.fg, bg = e.bg_alt },
		-- ToolbarButton = { fg = e.fg, bold = true },
		-- NormalMode       = { fg = e.disabled }, -- Normal mode message in the cmdline
		-- InsertMode       = { link = "NormalMode" },
		-- ReplacelMode     = { link = "NormalMode" },
		-- VisualMode       = { link = "NormalMode" },
		-- CommandMode      = { link = "NormalMode" },
	}

	if settings.disable.eob_lines then
		editor_hls.EndOfBuffer = { fg = e.bg }
	else
		editor_hls.EndOfBuffer = { fg = e.disabled }
	end

	return editor_hls
end

-- these should be loaded right away because
-- some plugins like lualine.nvim inherit the colors
M.main_highlights.load_lsp   = function()
	local lsp_hls = {
		DiagnosticError       = { fg = l.error },
		DiagnosticWarn        = { fg = l.warning },
		DiagnosticInformation = { fg = l.info },
		DiagnosticHint        = { fg = l.hint },
	}

	return lsp_hls
end

M.async_highlights.load_lsp  = function()
	local lsp_hls = {
		-- Nvim 0.6. and up
		DiagnosticVirtualTextError               = { link = "DiagnosticError" },
		DiagnosticFloatingError                  = { link = "DiagnosticError" },
		DiagnosticSignError                      = { link = "DiagnosticError" },
		DiagnosticUnderlineError                 = { undercurl = true, sp = l.error },
		DiagnosticVirtualTextWarn                = { link = "DiagnosticWarn" },
		DiagnosticFloatingWarn                   = { link = "DiagnosticWarn" },
		DiagnosticSignWarn                       = { link = "DiagnosticWarn" },
		DiagnosticUnderlineWarn                  = { undercurl = true, sp = l.warning },
		DiagnosticVirtualTextInfo                = { link = "DiagnosticInfo" },
		DiagnosticFloatingInfo                   = { link = "DiagnosticInfo" },
		DiagnosticSignInfo                       = { link = "DiagnosticInfo" },
		DiagnosticUnderlineInfo                  = { undercurl = true, sp = l.info },
		DiagnosticVirtualTextHint                = { link = "DiagnosticHint" },
		DiagnosticFloatingHint                   = { link = "DiagnosticHint" },
		DiagnosticSignHint                       = { link = "DiagnosticHint" },
		DiagnosticUnderlineHint                  = { undercurl = true, sp = l.hint },
		LspReferenceText                         = { bg = e.selection },        -- used for highlighting "text" references
		LspReferenceRead                         = { link = "LspReferenceText" }, -- used for highlighting "read" references
		LspReferenceWrite                        = { link = "LspReferenceText" }, -- used for highlighting "write" references
		LspCodeLens                              = { link = "DiagnosticHint" },

		["@lsp.type.enum"]                       = { link = "@type" },
		['@lsp.type.class']                      = { link = "@type" },
		["@lsp.type.keyword"]                    = { link = "@keyword" },
		["@lsp.type.interface"]                  = { link = "@type" },
		["@lsp.type.namespace"]                  = { link = "@namespace" },
		["@lsp.type.parameter"]                  = { link = "@parameter" },
		["@lsp.type.property"]                   = { link = "@property" },
		['@lsp.type.enumMember']                 = { link = '@constant' },
		['@lsp.type.decorator']                  = { link = '@function' },
		["@lsp.typemod.constant.readonly"]       = { link = '@constant' },

		["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },

		--[[
          ['@lsp.type.namespace'] = '@namespace',
          ['@lsp.type.type'] = '@type',
          ['@lsp.type.class'] = '@type',
          ['@lsp.type.enum'] = '@type',
          ['@lsp.type.interface'] = '@type',
          ['@lsp.type.struct'] = '@structure',
          ['@lsp.type.parameter'] = '@parameter',
          ['@lsp.type.variable'] = '@variable',
          ['@lsp.type.property'] = '@property',
          ['@lsp.type.enumMember'] = '@constant',
          ['@lsp.type.function'] = '@function',
          ['@lsp.type.method'] = '@method',
          ['@lsp.type.macro'] = '@macro',
          ['@lsp.type.decorator'] = '@function',
        ]]

	}

	return lsp_hls
end

---function for setting the terminal colors
M.load_terminal              = function()
	vim.g.terminal_color_0 = m.black
	vim.g.terminal_color_1 = m.darkred
	vim.g.terminal_color_2 = m.darkgreen
	vim.g.terminal_color_3 = m.darkyellow
	vim.g.terminal_color_4 = m.darkblue
	vim.g.terminal_color_5 = m.darkpurple
	vim.g.terminal_color_6 = m.darkcyan
	vim.g.terminal_color_7 = m.white
	vim.g.terminal_color_8 = e.disabled
	vim.g.terminal_color_9 = m.red
	vim.g.terminal_color_10 = m.green
	vim.g.terminal_color_11 = m.yellow
	vim.g.terminal_color_12 = m.blue
	vim.g.terminal_color_13 = m.purple
	vim.g.terminal_color_14 = m.cyan
	vim.g.terminal_color_15 = m.white
end

-- apply plugin highlights
M.main_highlights            = vim.tbl_extend("keep", M.main_highlights, plugins.main_highlights)
M.async_highlights           = vim.tbl_extend("keep", M.async_highlights, plugins.async_highlights)

return M
