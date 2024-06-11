
local M = {}

M.base_30 = {
  white = "#d0daf0",
  darker_black = "#282738",
  black = "#282738", --  nvim bg
  black2 = "#353446",
  one_bg = "#282738",
  one_bg2 = "#9198a8",
  one_bg3 = "#9198a8",
  grey = "#A491AD",
  grey_fg = "#d0daf0",
  grey_fg2 = "#d0daf0",
  light_grey = "#9198a8",
  red = "#9198a8",
  baby_pink = "#9198a8",
  pink = "#A491AD",
  line = "#9198a8", -- for lines like vertsplit
  green = "#A893D4",
  vibrant_green = "#A893D4",
  nord_blue = "#9198a8",
  blue = "#91B1F0",
  yellow = "#9CC1F3",
  sun = "#9CC1F3",
  purple = "#282738",
  dark_purple = "#282738",
  teal = "#9CC1F3",
  orange = "#9198a8",
  cyan = "#ACB7ED",
  statusline_bg = "#282738",
  lightbg = "#353446",
  pmenu_bg = "#353446",
  folder_bg = "#353446",
}

M.base_16 = {
  base00 = "#282738",
  base01 = "#9198a8",
  base02 = "#9198a8",
  base03 = "#A491AD",
  base04 = "#d0daf0",
  base05 = "#d0daf0",
  base06 = "#9198a8",
  base07 = "#d0daf0",
  base08 = "#9198a8",
  base09 = "#A491AD",
  base0A = "#A893D4",
  base0B = "#A893D4",
  base0C = "#ACB7ED",
  base0D = "#91B1F0",
  base0E = "#9CC1F3",
  base0F = "#9CC1F3",
}

M.type = "dark"

M.polish_hl = {
  ["@tag"] = { fg = M.base_30.orange },
  ["@tag.delimiter"] = { fg = M.base_30.green },
}

return M

