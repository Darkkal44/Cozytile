local M = {}

M.base_30 = {
  white = "#b2bebc",
  darker_black = "#343F44",
  black = "#0f1212", --  nvim bg
  black2 = "#202222",
  one_bg = "#0f1212",
  one_bg2 = "#526852",
  one_bg3 = "#546E6C",
  grey = "#788E7D",
  grey_fg = "#b2bebc",
  grey_fg2 = "#7c8583",
  light_grey = "#7c8583",
  red = "#546E6C",
  baby_pink = "#607767",
  pink = "#718871",
  line = "#526852", -- for lines like vertsplit
  green = "#607767",
  vibrant_green = "#718871",
  nord_blue = "#526852",
  blue = "#546E6C",
  yellow = "#718871",
  sun = "#718871",
  purple = "#0f1212",
  dark_purple = "#455B4C",
  teal = "#526852",
  orange = "#546E6C",
  cyan = "#788E7D",
  statusline_bg = "#0f1212",
  lightbg = "#455B4C",
  pmenu_bg = "#607767",
  folder_bg = "#546E6C",
}

M.base_16 = {
  base00 = "#0f1212",
  base01 = "#455B4C",
  base02 = "#526852",
  base03 = "#546E6C",
  base04 = "#607767",
  base05 = "#b2bebc",
  base06 = "#7c8583",
  base07 = "#788E7D",
  base08 = "#546E6C",
  base09 = "#607767",
  base0A = "#718871",
  base0B = "#788E7D",
  base0C = "#526852",
  base0D = "#546E6C",
  base0E = "#607767",
  base0F = "#718871",
}

M.type = "dark"

M.polish_hl = {
  ["@tag"] = { fg = M.base_30.orange },
  ["@tag.delimiter"] = { fg = M.base_30.green },
}


return M

