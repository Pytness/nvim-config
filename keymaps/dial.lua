return {
  {
    'n',
    '<C-a>',
    require('dial.map').inc_normal(),
    { noremap = true },
  },
  {
    'n',
    '<C-x>',
    require('dial.map').dec_normal(),
    { noremap = true },
  },
  {
    'n',
    'g<C-a>',
    require('dial.map').inc_gnormal(),
    { noremap = true },
  },
  {
    'n',
    'g<C-x>',
    require('dial.map').dec_gnormal(),
    { noremap = true },
  },
  {
    'v',
    '<C-a>',
    require('dial.map').inc_visual(),
    { noremap = true },
  },
  {
    'v',
    '<C-x>',
    require('dial.map').dec_visual(),
    { noremap = true },
  },
  {
    'v',
    'g<C-a>',
    require('dial.map').inc_gvisual(),
    { noremap = true },
  },
  {
    'v',
    'g<C-x>',
    require('dial.map').dec_gvisual(),
    { noremap = true },
  },
}
