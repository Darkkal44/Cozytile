local M = {}

M.base_30 = {
  white = "#efe5e4",
  darker_black = "#282738",
  black = "#282738", --  nvim bg
  black2 = "#353446",
  one_bg = "#282738",
  one_bg2 = "#3a4248",
  one_bg3 = "#424a50",
  grey = "#a7a09f",
  grey_fg = "#efe5e4",
  grey_fg2 = "#DDD0B4",
  light_grey = "#DDD0B4",
  red = "#D5A8AC",
  baby_pink = "#E5B9C6",
  pink = "#FECDCE",
  line = "#3a4248", -- for lines like vertsplit
  green = "#A7C080",
  vibrant_green = "#AF9295",
  nord_blue = "#E4C7B4",
  blue = "#E5B9C6",
  yellow = "#FECDCE",
  sun = "#FECDCE",
  purple = "#AA7489",
  dark_purple = "#AA7489",
  teal = "#AF9295",
  orange = "#E4C7B4",
  cyan = "#D5A8AC",
  statusline_bg = "#282738",
  lightbg = "#353446",
  pmenu_bg = "#A7C080",
  folder_bg = "#E5B9C6",
}

M.base_16 = {
  base00 = "#282738",
  base01 = "#353446",
  base02 = "#3a4248",
  base03 = "#424a50",
  base04 = "#4a5258",
  base05 = "#efe5e4",
  base06 = "#DDD0B4",
  base07 = "#E7DABE",
  base08 = "#AA7489",
  base09 = "#D5A8AC",
  base0A = "#A7C080",
  base0B = "#FECDCE",
  base0C = "#D699B6",
  base0D = "#E4C7B4",
  base0E = "#AA7489",
  base0F = "#AA7489",
}

M.type = "dark"

M.polish_hl = {
  ["@tag"] = { fg = M.base_30.orange },
  ["@tag.delimiter"] = { fg = M.base_30.green },
}

M = require("base46").override_theme(M, "everforest")

return M
