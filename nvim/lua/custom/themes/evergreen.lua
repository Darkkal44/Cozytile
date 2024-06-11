
local M = {}

M.base_30 = {
  white = "#bdc2be",
  darker_black = "#232a2e",
  black = "#232a2e", -- nvim bg
  black2 = "#424a50",
  one_bg = "#232a2e",
  one_bg2 = "#353e44",
  one_bg3 = "#3a4248",
  grey = "#87918b",
  grey_fg = "#bdc2be",
  grey_fg2 = "#89948d",
  light_grey = "#8b958f",
  red = "#86918a",
  baby_pink = "#86918a",
  pink = "#86918a",
  line = "#353e44", -- for lines like vertsplit
  green = "#86918A",
  vibrant_green = "#86918A",
  nord_blue = "#86918a",
  blue = "#86918a",
  yellow = "#86918a",
  sun = "#86918a",
  purple = "#848785",
  dark_purple = "#848785",
  teal = "#86918A",
  orange = "#87918b",
  cyan = "#86918a",
  statusline_bg = "#232a2e",
  lightbg = "#353e44",
  pmenu_bg = "#86918A",
  folder_bg = "#87918b",
}

M.base_16 = {
  base00 = "#232a2e",
  base01 = "#353e44",
  base02 = "#3a4248",
  base03 = "#424a50",
  base04 = "#4a5258",
  base05 = "#bdc2be",
  base06 = "#8b958f",
  base07 = "#bdc2be",
  base08 = "#86918a",
  base09 = "#87918b",
  base0A = "#86918A",
  base0B = "#86918A",
  base0C = "#86918a",
  base0D = "#86918a",
  base0E = "#86918a",
  base0F = "#86918a",
}

M.type = "light"

M.polish_hl = {
  ["@tag"] = { fg = M.base_30.orange },
  ["@tag.delimiter"] = { fg = M.base_30.green },
}


return M

