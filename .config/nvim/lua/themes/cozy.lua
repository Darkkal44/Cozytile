local M = {}

M.base_30 = {
  white = "#d0daf0",
  darker_black = "#282738",
  black = "#282738",
  black2 = "#353446",
  one_bg = "#1b1b2b",
  one_bg2 = "#353a44",
  one_bg3 = "#3e434d",
  grey = "#7a7f84",
  grey_fg = "#A28EB4",
  grey_fg2 = "#515558",
  light_grey = "#565a5d",
  red = "#A491AD",
  baby_pink = "#CAA9E0",
  pink = "#A493D4",
  line = "#1b1b2b",
  green = "#A893D4",
  vibrant_green = "#95c7ae",
  nord_blue = "#9CC1F3",
  blue = "#91B1F0",
  yellow = "#ACB7ED",
  sun = "#d0daf0",
  purple = "#CAA9E0",
  dark_purple = "#A58CBE",
  teal = "#8fb4b5",
  orange = "#c7ae95",
  cyan = "#9CC1F3",
  statusline_bg = "#353446",
  lightbg = "#1b1b2b",
  pmenu_bg = "#A893D4",
  folder_bg = "#9CC1F3",
}

M.base_16 = {
  base00 = "#282738",
  base01 = "#1b1b2b",
  base02 = "#353a44",
  base03 = "#7a7f84",
  base04 = "#adb3ba",
  base05 = "#d0daf0",
  base06 = "#dfe2e5",
  base07 = "#f3f4f5",
  base08 = "#A491AD",
  base09 = "#ACB7ED",
  base0A = "#A893D4",
  base0B = "#91B1F0",
  base0C = "#9CC1F3",
  base0D = "#CAA9E0",
  base0E = "#A493D4",
  base0F = "#A491AD",
}

M.type = "dark"

M = require("base46").override_theme(M, "ashes")

return M
