local M = {}

M.base_30 = {
  white = "#b2bebc",
  darker_black = "#0f1212",
  black = "#0f1212",
  black2 = "#1a1c1c",
  one_bg = "#171717",
  one_bg2 = "#1a1c1c",
  one_bg3 = "#1e2020",
  grey = "#7c8583",
  grey_fg = "#455B4C",
  grey_fg2 = "#526852",
  light_grey = "#546E6C",
  red = "#455B4C",
  baby_pink = "#718871",
  pink = "#607767",
  line = "#171717",
  green = "#526852",
  vibrant_green = "#607767",
  nord_blue = "#788E7D",
  blue = "#718871",
  yellow = "#546E6C",
  sun = "#b2bebc",
  purple = "#788E7D",
  dark_purple = "#455B4C",
  teal = "#7c8583",
  orange = "#546E6C",
  cyan = "#788E7D",
  statusline_bg = "#1a1c1c",
  lightbg = "#171717",
  pmenu_bg = "#607767",
  folder_bg = "#788E7D",
}

M.base_16 = {
  base00 = "#0f1212",
  base01 = "#171717",
  base02 = "#1a1c1c",
  base03 = "#7c8583",
  base04 = "#b2bebc",
  base05 = "#b2bebc",
  base06 = "#dfe2e5",
  base07 = "#f3f4f5",
  base08 = "#455B4C",
  base09 = "#607767",
  base0A = "#526852",
  base0B = "#546E6C",
  base0C = "#788E7D",
  base0D = "#718871",
  base0E = "#607767",
  base0F = "#455B4C",
}

M.type = "dark"

M = require("base46").override_theme(M, "ashes")

return M
