local function toggle()
  require('bafa.ui').toggle()
end

local function select_menu_item()
  require('bafa.ui').select_menu_item()
end

local function delete_menu_item()
  require('bafa.ui').delete_menu_item()
end

local function delete_multiple_menu_items()
  require('bafa.ui').delete_multiple_menu_items()
end

local function cycle_sort()
  require('bafa.ui').cycle_sort()
end

return {
  { 'n', 'q', toggle, { silent = true } },
  { 'n', '<ESC>', toggle, { silent = true } },
  { 'n', '<CR>', select_menu_item, {} },
  { 'n', 'L', select_menu_item, {} },
  { 'n', 'dd', delete_menu_item, {} },
  { 'n', 'D', delete_menu_item, {} },
  { 'v', 'd', delete_multiple_menu_items, {} },
  { 'n', 's', cycle_sort, {} },
}
