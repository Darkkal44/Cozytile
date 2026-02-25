local M = {}

M.base_30 = {
  white = "#efe5e4",
  darker_black = "#282738",
  black = "#282738",
  black2 = "#353446",
  one_bg = "#191929",
  one_bg2 = "#23272c",
  one_bg3 = "#2d3238",
  grey = "#a7a09f",
  grey_fg = "#D5A8AC",
  grey_fg2 = "#AF9295",
  light_grey = "#D5A8AC",
  red = "#E5B9C6",
  baby_pink = "#E5B9C6",
  pink = "#D5A8AC",
  line = "#191929",
  green = "#AF9295",
  vibrant_green = "#D5A8AC",
  nord_blue = "#FECDCE",
  blue = "#E5B9C6",
  yellow = "#E4C7B4",
  sun = "#efe5e4",
  purple = "#FECDCE",
  dark_purple = "#E5B9C6",
  teal = "#A7A09F",
  orange = "#D5A8AC",
  cyan = "#FECDCE",
  statusline_bg = "#353446",
  lightbg = "#191929",
  pmenu_bg = "#E4C7B4",
  folder_bg = "#FECDCE",
}

M.base_16 = {
  base00 = "#282738",
  base01 = "#191929",
  base02 = "#353446",
  base03 = "#a7a09f",
  base04 = "#efe5e4",
  base05 = "#efe5e4",
  base06 = "#dfe2e5",
  base07 = "#f3f4f5",
  base08 = "#D5A8AC",
  base09 = "#E4C7B4",
  base0A = "#AF9295",
  base0B = "#D5A8AC",
  base0C = "#FECDCE",
  base0D = "#E5B9C6",
  base0E = "#D5A8AC",
  base0F = "#D5A8AC",
}

M.type = "dark"

M = require("base46").override_theme(M, "ashes")

return M
