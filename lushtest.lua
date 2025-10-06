local lush = require 'lush'
local hsl = lush.hsl

local red = hsl(350, 80, 65)
local green = hsl(120, 80, 65)
local yellow = hsl(65, 80, 65)
local orange = hsl(39, 80, 65)
local blue = hsl(220, 80, 65)
local purple = hsl(300, 80, 65)
local cyan = hsl(180, 80, 65)
local blue_purple = blue.mix(purple, 50)

-- red = hsl(349, 100, 66)
-- orange = hsl(30, 100, 70)
-- yellow = hsl(60, 100, 70)
-- green = hsl(90, 66, 73)
-- blue = hsl(217, 100, 77)
-- purple = hsl(295, 59, 67)
-- cyan = hsl(197, 100, 79)

local dark_red = red.darken(30)
local dark_green = green.darken(30)
local dark_yellow = yellow.darken(30)
local dark_orange = orange.darken(30)
local dark_blue = blue.darken(30)
local dark_purple = purple.darken(30)
local dark_cyan = cyan.darken(30)

local light_red = red.lighten(30).saturation(100)
local light_green = green.lighten(30).saturation(100)
local light_yellow = yellow.lighten(30).saturation(100)
local light_orange = orange.lighten(30).saturation(100)
local light_blue = blue.lighten(30).saturation(100)
local light_purple = purple.lighten(30).saturation(100)
local light_cyan = cyan.lighten(30).saturation(100)

local white = blue.lightness(88).saturation(20)
local black = blue.lightness(9).saturation(15)

local comment_grey = black.lighten(40).saturation(10)
local inlay_hint = black.lighten(30)

local grey = black.lighten(20)

local gutter_fg_grey = grey
local cursor_grey = black.lighten(10)

local visual_grey = grey
local menu_grey = grey
local special_grey = grey
local vertsplit = grey

local leap_primary_label = hsl(335, 100, 59)
local leap_secondary_label = leap_primary_label.rotate(220)

---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym

  return {

    Dark_red { fg = dark_red },
    Red { fg = red },
    Light_red { fg = light_red },

    Dark_green { fg = dark_green },
    Green { fg = green },
    Light_green { fg = light_green },

    Dark_yellow { fg = dark_yellow },
    Yellow { fg = yellow },
    Light_yellow { fg = light_yellow },

    Dark_orange { fg = dark_orange },
    Orange { fg = orange },
    Light_orange { fg = light_orange },

    Dark_blue { fg = dark_blue },
    Blue { fg = blue },
    Light_blue { fg = light_blue },

    Dark_purple { fg = dark_purple },
    Purple { fg = purple },
    Light_purple { fg = light_purple },

    Dark_cyan { fg = dark_cyan },
    Cyan { fg = cyan },
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

    Comment { fg = comment_grey, italic = true, cterm = { italic = true } }, -- any comment
    Constant { fg = cyan }, -- any constant
    String { fg = green }, -- a string constant: "this is a string"
    Character { fg = green }, -- a character constant: 'c', '\n'
    Number { fg = dark_yellow }, -- a number constant: 234, 0xff
    Boolean { fg = red }, -- a boolean constant: TRUE, false
    Float { fg = dark_yellow }, -- a floating point constant: 2.3e10
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
    Include { fg = blue }, -- preprocessor #include
    Define { fg = purple }, -- preprocessor #define
    Macro { fg = purple }, -- same as Define
    PreCondit { fg = yellow }, -- preprocessor #if, #else, #endif, etc.
    Type { fg = yellow }, -- int, long, char, etc.
    StorageClass { fg = yellow }, -- static, register, volatile, etc.
    Structure { fg = yellow }, -- struct, union, enum, etc.
    Typedef { fg = yellow }, -- A typedef
    Special { fg = blue }, -- any special symbol
    SpecialChar {}, -- special character in a constant
    Tag {}, -- you can use CTRL-] on this
    Delimiter {}, -- character that needs attention
    SpecialComment { fg = comment_grey }, -- special things inside a comment
    Debug {}, -- debugging statements
    Underlined { underline = true, cterm = { underline = true } }, -- text that stands out, HTML links
    Ignore {}, -- left blank, hidden
    Error { fg = red }, -- any erroneous construct
    Todo { fg = cyan }, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    ColorColumn { bg = cursor_grey }, -- used for the columns set with 'colorcolumn'
    Conceal {}, -- placeholder characters substituted for concealed text
    Cursor { fg = black, bg = blue }, -- the character under the cursor
    CursorIM {}, -- like Cursor, but used when in IME mode
    CursorColumn { bg = cursor_grey }, -- the screen column when 'cursorcolumn' is set
    CursorLine { bg = cursor_grey }, -- the screen line when 'cursorline' is set
    Directory { fg = blue }, -- directory names
    DiffAdd { bg = green }, -- diff mode: Added line
    DiffChange { bg = blue }, -- diff mode: Changed line
    DiffDelete { bg = red }, -- diff mode: Deleted line
    DiffText { bg = yellow }, -- diff mode: Changed text within a changed line
    ErrorMsg { fg = red }, -- error messages on the command line
    VertSplit { fg = vertsplit }, -- the column separating vertically split windows
    Folded { bg = cursor_grey, fg = comment_grey }, -- line used for closed folds
    FoldColumn {}, -- 'foldcolumn'
    SignColumn {}, -- column where signs are displayed
    IncSearch { fg = yellow, bg = comment_grey }, -- 'incsearch' highlighting
    LineNr { fg = gutter_fg_grey }, -- Line number for ":number" and ":#"
    CursorLineNr {}, -- Like LineNr when 'cursorline' or 'relativenumber' is set
    MatchParen { fg = blue, underline = true }, -- the character under the cursor if it's a paired bracket
    ModeMsg {}, -- 'showmode' message (e.g., "-- INSERT --")
    MoreMsg {}, -- more-prompt
    NonText { fg = special_grey }, -- '~' and '@' at the end of the window
    Normal { fg = white, bg = black }, -- normal text
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
    StatusLineNC { fg = comment_grey }, -- status lines of not-current windows
    TabLine { fg = comment_grey }, -- tab pages line, not active tab page label
    TabLineFill {}, -- tab pages line, where there are no labels
    TabLineSel { fg = white }, -- tab pages line, active tab page label
    Title { fg = green }, -- titles for output from ":set all", ":autocmd" etc.
    Visual { fg = black, bg = visual_grey }, -- Visual mode selection
    VisualNOS { bg = visual_grey }, -- Visual mode selection when vim is "Not Owning the Selection"
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

    LspInlayHint { fg = comment_grey }, -- Inlay Hint
    FloatTitle { fg = white, bg = black }, -- Float title
    FloatBorder { fg = white, bg = black }, -- Float border
    NormalFloat { fg = white, bg = black }, -- Normal floating window

    dockerfileKeyword { fg = purple }, -- Dockerfile keywords
    shSet { fg = cyan }, -- Shell Set
    shSetOption { fg = white }, -- Shell Set Option
    shStatement { fg = cyan }, -- Shell Statement
    shFunctionKey { fg = purple }, -- Shell Function Key
    goDeclaration { fg = purple }, -- Go Declaration

    SignifySignAdd { fg = green },
    SignifySignChange { fg = yellow },
    SignifySignDelete { fg = red },

    NeomakeWarningSign { fg = yellow },
    NeomakeErrorSign { fg = red },
    NeomakeInfoSign { fg = blue },

    Added { fg = green },
    Removed { fg = red },

    VistaBracket { fg = purple },
    VistaChildrenNr { fg = dark_yellow },
    VistaScope { fg = dark_purple },
    VistaTag { fg = purple },
    VistaPrefix { fg = dark_purple },
    VistaParenthesis { fg = purple },
    VistaColon { fg = cyan },
    VistaIcon { fg = cyan },
    VistaLineNr { fg = comment_grey },
    VistaArgs { fg = comment_grey },
    VistaKind { fg = comment_grey },
    VistaScopeKind { fg = yellow },

    debugBreakpoint { fg = dark_purple },
    debugPC { bg = dark_purple, fg = black },

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

    MiniTablineHidden { bg = cursor_grey, fg = white },
    MiniTablineVisible { bg = cursor_grey, fg = white },
    MiniTablineCurrent { bg = blue, fg = white },

    MiniTablineModifiedHidden { bg = cursor_grey, fg = green },
    MiniTablineModifiedVisible { bg = cursor_grey, fg = green },
    MiniTablineModifiedCurrent { bg = green, fg = black },

    MiniStatuslineModeNormal { bg = blue, fg = black },
    MiniStatuslineModeInsert { bg = yellow, fg = black },
    MiniStatuslineModeVisual { bg = dark_purple, fg = black },
    MiniStatuslineModeReplace { bg = green, fg = black },
    MiniStatuslineModeCommand { bg = black, fg = yellow },
    MiniStatuslineModeOther { bg = purple, fg = black },

    LeapBackdrop { link = 'Comment' },
    LeapMatch { fg = white, bold = true, nocombine = true },
    LeapLabel { bg = black, fg = leap_primary_label, bold = false, nocombine = true },
    LeapLabelDimmed { bg = black, fg = leap_secondary_label, bold = false, nocombine = true },

    sym '@character' { fg = green },
    sym '@character.special' { fg = dark_purple },
    sym '@constant' { fg = cyan },
    sym '@constant.builtin' { fg = yellow },
    sym '@constant.macro' { fg = dark_yellow },
    sym '@function' { fg = blue },
    sym '@function.builtin' { fg = cyan },
    sym '@function.call' { fg = blue },
    sym '@function.macro' { fg = purple, italic = true },
    sym '@keyword' { fg = red, italic = true },
    sym '@keyword.function' { fg = dark_purple, italic = true },
    sym '@keyword.operator' { fg = dark_purple },
    sym '@keyword.return' { fg = red },
    sym '@method' { fg = blue },
    sym '@method.builtin' { fg = cyan },
    sym '@method.call' { fg = blue },
    sym '@parameter' { fg = white, italic = true },
    sym '@parameter.builtin' { fg = cyan },
    sym '@parameter.reference' { fg = menu_grey },
    sym '@punctuation' { fg = white },
    sym '@punctuation.bracket' { fg = white },
    sym '@punctuation.delimiter' { fg = white },
    sym '@punctuation.special' { fg = white },
    sym '@string' { fg = green },
    sym '@string.escape' { fg = comment_grey },
    sym '@string.regex' { fg = dark_green },
    sym '@string.special' { fg = yellow },
    sym '@tag' { fg = light_red },
    sym '@tag.attribute' { fg = dark_purple },
    sym '@tag.delimiter' { fg = white },
    sym '@type' { fg = yellow },
    sym '@type.builtin' { fg = yellow },
    sym '@type.qualifier' { fg = yellow },
    sym '@variable' { fg = white },
    sym '@variable.builtin' { fg = dark_yellow },
  }
end)

return theme
