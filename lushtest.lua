local lush = require 'lush'
local hsl = lush.hsl

local red = hsl(350, 100, 60)
local green = hsl(120, 80, 60)
local yellow = hsl(60, 87, 60)
local orange = hsl(39, 100, 60)
local blue = hsl(220, 80, 75)
local purple = hsl(300, 70, 60)
local cyan = hsl(180, 80, 58)

red = hsl(349, 100, 66)
orange = hsl(30, 100, 70)
yellow = hsl(60, 100, 70)
green = hsl(90, 66, 73)
blue = hsl(217, 100, 77)
purple = hsl(295, 59, 67)
local blue_purple = blue.mix(purple, 50)
cyan = hsl(197, 100, 79)

local dark_red = red.darken(25)
local dark_green = green.darken(25)
local dark_yellow = yellow.darken(25)
local dark_orange = orange.darken(25)
local dark_blue = blue.darken(25)
local dark_purple = purple.darken(25)
local dark_cyan = cyan.darken(25)

local light_red = red.lighten(20)
local light_green = green.lighten(20)
local light_yellow = yellow.lighten(20)
local light_orange = orange.lighten(20)
local light_blue = blue.lighten(20)
local light_purple = purple.lighten(20)
local light_cyan = cyan.lighten(20)

-- local blue_purple = hsl(242, 57, 70)

local white = blue.lightness(88).saturation(20)
local black = blue.lightness(12).saturation(17)

local comment_grey = black.lighten(45)
local inlay_hint = black.lighten(30)

local gutter_fg_grey = hsl(222, 14, 34)
local cursor_grey = black.lighten(10)

local visual_grey = hsl(222, 14, 28)
local menu_grey = hsl(222, 14, 28)
local special_grey = hsl(217, 10, 26)
local vertsplit = hsl(223, 13, 11)
local leap_primary_label = hsl(335, 100, 59)
local leap_secondary_label = leap_primary_label.rotate(220)

---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym

  return {
    Red { fg = red },
    Green { fg = green },
    Yellow { fg = yellow },
    Orange { fg = orange },
    Blue { fg = blue },
    Purple { fg = purple },
    Cyan { fg = cyan },
    BluePurple { fg = blue_purple },

    Dark_red { fg = dark_red },
    Dark_green { fg = dark_green },
    Dark_yellow { fg = dark_yellow },
    Dark_orange { fg = dark_orange },
    Dark_blue { fg = dark_blue },
    Dark_purple { fg = dark_purple },
    Dark_cyan { fg = dark_cyan },

    Light_red { fg = light_red },
    Light_green { fg = light_green },
    Light_yellow { fg = light_yellow },
    Light_orange { fg = light_orange },
    Light_blue { fg = light_blue },
    Light_purple { fg = light_purple },
    Light_cyan { fg = light_cyan },

    Blue_purple { fg = blue_purple },

    White { fg = white },
    Black { fg = black },
    Comment_grey { fg = comment_grey },
    Gutter_fg_grey { fg = gutter_fg_grey },
    Cursor_grey { fg = cursor_grey },
    Visual_grey { fg = visual_grey },
    Menu_grey { fg = menu_grey },
    Special_grey { fg = special_grey },
    Leap_primary_label { fg = leap_primary_label },
    Leap_secondary_label { fg = leap_secondary_label },

    --
    --
    --

    Normal { fg = white, bg = black }, -- normal text
    Comment { fg = comment_grey, italic = true }, -- any comment
    Constant { fg = light_purple }, -- any constant
    String { fg = light_green }, -- a string constant: "this is a string"
    Character { fg = light_green }, -- a character constant: 'c', '\n'
    Number { fg = orange }, -- a number constant: 234, 0xff
    Float { fg = light_yellow }, -- a floating point constant: 2.3e10

    Boolean { fg = red }, -- a boolean constant: TRUE, false
    Identifier { fg = red }, -- any variable name
    Function { fg = blue }, -- function name (also: methods for classes)
    Statement { fg = purple }, -- any statement
    Conditional { fg = purple }, -- if, then, else, endif, switch, etc.
    Repeat { fg = purple }, -- for, do, while, etc.
    Label { fg = purple }, -- case, default, etc.
    Operator { fg = cyan }, -- sizeof", "+", "*", etc.
    Keyword { fg = red }, -- any other keyword
    Exception { fg = purple }, -- try, catch, throw
    PreProc { fg = yellow }, -- generic Preprocessor
    Macro { fg = purple }, -- same as Define
    Type { fg = yellow }, -- int, long, char, etc.
    Structure { fg = light_orange }, -- struct, union, enum, etc.

    Include { fg = blue }, -- preprocessor #include
    Define { fg = purple }, -- preprocessor #define

    PreCondit { fg = yellow }, -- preprocessor #if, #else, #endif, etc.
    StorageClass { fg = yellow }, -- static, register, volatile, etc.
    Typedef { fg = yellow }, -- A typedef
    Delimiter { fg = white }, -- character that needs attention
    Special { fg = light_blue }, -- any special symbol
    SpecialChar {}, -- special character in a constant
    SpecialComment { fg = comment_grey }, -- special things inside a comment Underlined { underline = true, cterm = { underline = true } }, -- text that stands out, HTML links
    Ignore {}, -- left blank, hidden
    Error { fg = red }, -- any erroneous construct
    Todo { fg = cyan }, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    ColorColumn { bg = cursor_grey }, -- used for the columns set with 'colorcolumn'
    Cursor { fg = black, bg = white }, -- the character under the cursor
    CursorIM {}, -- like Cursor, but used when in IME mode
    CursorColumn { bg = cursor_grey }, -- the screen column when 'cursorcolumn' is set
    CursorLine { bg = cursor_grey }, -- the screen line when 'cursorline' is set
    Directory { fg = blue }, -- directory names
    DiffAdd { fg = green, bg = black }, -- diff mode: Added line
    DiffChange { fg = yellow, bg = black }, -- diff mode: Changed line
    DiffDelete { fg = red, bg = black }, -- diff mode: Deleted line
    DiffText { fg = yellow, bg = black }, -- diff mode: Changed text within a changed line
    ErrorMsg { fg = red }, -- error messages on the command line
    VertSplit { fg = vertsplit }, -- the column separating vertically split windows
    Folded { bg = cursor_grey, fg = comment_grey }, -- line used for closed folds
    FoldColumn {}, -- 'foldcolumn'
    SignColumn {}, -- column where signs are displayed
    IncSearch { fg = yellow, bg = comment_grey }, -- 'incsearch' highlighting
    LineNr { fg = gutter_fg_grey }, -- Line number for ":number" and ":#"
    CursorLineNr {}, -- Like LineNr when 'cursorline' or 'relativenumber' is set
    MatchParen { fg = blue, underline = true }, -- the character under the cursor if it's a paired bracket
    NonText { fg = special_grey }, -- '~' and '@' at the end of the window
    Pmenu { bg = menu_grey }, -- Popup menu: normal item
    PmenuSel { fg = black, bg = blue }, -- Popup menu: selected item
    PmenuSbar { bg = special_grey }, -- Popup menu: scrollbar
    PmenuThumb { bg = white }, -- Popup menu: Thumb of the scrollbar
    Question { fg = purple }, -- hit-enter prompt and yes/no questions
    Search { fg = black, bg = yellow }, -- Last search pattern highlighting
    SpecialKey { fg = special_grey }, -- Meta and special keys listed with ":map"
    SpellBad { fg = red, underline = true, cterm = { underline = true } }, -- Word not recognized by the spellchecker
    SpellCap { fg = dark_yellow }, -- Word that should start with a capital
    SpellLocal { fg = dark_yellow }, -- Word recognized by spellchecker as used in another region
    SpellRare { fg = dark_yellow }, -- Word recognized by spellchecker as hardly ever used
    StatusLine { fg = white, bg = cursor_grey }, -- status line of current window
    StatusLineNC { fg = blue }, -- status lines of not-current windows
    TabLine { fg = comment_grey }, -- tab pages line, not active tab page label
    TabLineFill {}, -- tab pages line, where there are no labels
    TabLineSel { fg = white }, -- tab pages line, active tab page label
    Title { fg = green }, -- titles for output from ":set all", ":autocmd" etc.
    Visual { fg = white, bg = visual_grey }, -- Visual mode selection
    WarningMsg { fg = yellow }, -- warning messages
    WildMenu { fg = black, bg = blue }, -- current match in 'wildmenu' completion
    DiagnosticError { fg = dark_red }, -- Error
    DiagnosticWarning { fg = yellow }, -- Warning
    DiagnosticInfo { fg = blue }, -- Info
    DiagnosticHint { fg = green }, -- Hint
    DiagnosticDefault { fg = dark_purple }, -- Test Error
    DiagnosticTest { fg = purple }, -- Test
    DiagnosticUnderlineError { sp = red, undercurl = true }, -- Underline for errors
    DiagnosticUnderlineWarn { sp = yellow, underdashed = true }, -- Underline for errors

    LspInlayHint { fg = inlay_hint }, -- Inlay Hint
    FloatTitle { fg = white, bg = black }, -- Float title
    FloatBorder { fg = white, bg = black }, -- Float border
    NormalFloat { fg = white, bg = black }, -- Normal floating window

    LeapBackdrop { Comment },
    LeapMatch { fg = white, bold = true, nocombine = true },
    LeapLabel { bg = black, fg = leap_primary_label, bold = false, nocombine = true },
    LeapLabelDimmed { bg = black, fg = leap_secondary_label, bold = false, nocombine = true },

    -- Git Highlighting
    gitcommitComment { fg = comment_grey },
    gitcommitUnmerged { fg = green },
    gitcommitOnBranch {},
    gitcommitBranch { fg = purple },
    gitcommitDiscardedType { fg = red },
    gitcommitSelectedType { fg = green },
    gitcommitHeader {},
    gitcommitUntrackedFile { fg = cyan },
    gitcommitDiscardedFile { fg = red },
    gitcommitSelectedFile { fg = green },
    gitcommitUnmergedFile { fg = yellow },
    gitcommitFile {},
    gitcommitSummary { fg = white },
    gitcommitOverflow { fg = red },

    sym '@character' { fg = green },
    sym '@character.special' { fg = dark_purple },

    sym '@constant' { fg = cyan },
    sym '@constant.builtin' { fg = yellow },
    sym '@constant.macro' { fg = light_purple, italic = true },

    sym '@function' { fg = blue },
    sym '@function.builtin' { fg = cyan },
    sym '@function.call' { fg = blue },
    sym '@function.macro' { fg = light_purple, italic = true },

    sym '@keyword' { fg = red, italic = true },
    sym '@keyword.function' { fg = red, italic = true },
    sym '@keyword.operator' { fg = purple },
    sym '@keyword.return' { fg = red },

    sym '@method' { fg = blue },
    sym '@method.builtin' { fg = cyan },
    sym '@method.call' { fg = blue },

    sym '@parameter' { fg = white, italic = true },
    sym '@parameter.builtin' { fg = cyan },
    -- sym '@parameter.reference' { fg = '#3E4452' },

    sym '@punctuation' { fg = white },
    sym '@punctuation.bracket' { fg = white },
    sym '@punctuation.delimiter' { fg = white },
    sym '@punctuation.special' { fg = white },

    sym '@string' { fg = light_green },
    sym '@string.escape' { fg = comment_grey },
    sym '@string.regex' { fg = green },
    sym '@string.special' { fg = light_orange },

    sym '@tag' { fg = light_red },
    sym '@tag.attribute' { fg = purple },
    sym '@tag.delimiter' { fg = white },

    sym '@type' { fg = yellow },
    sym '@type.builtin' { fg = light_orange },
    sym '@type.qualifier' { fg = light_yellow },

    sym '@variable' { fg = white },
    sym '@variable.builtin' { fg = dark_orange, italic = true },

    MiniStatuslineModeNormal { bg = blue, fg = black },
    MiniStatuslineModeInsert { bg = yellow, fg = black },
    MiniStatuslineModeVisual { bg = purple, fg = black },
    MiniStatuslineModeReplace { bg = green, fg = black },
    MiniStatuslineModeCommand { bg = black, fg = yellow },
    MiniStatuslineModeOther { bg = orange, fg = black },
  }
end)

return theme
