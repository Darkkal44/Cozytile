local M = {}

M.base_30 = {
  white = "#bdc2be",
  darker_black = "#232A2E",
  black = "#232A2E",
  black2 = "#343F44",
  one_bg = "#171b1e",
  one_bg2 = "#252c2f",
  one_bg3 = "#2c3235",
  grey = "#848785",
  grey_fg = "#7D8882",
  grey_fg2 = "#87918B",
  light_grey = "#86918A",
  red = "#7D8882",
  baby_pink = "#89948D",
  pink = "#89938C",
  line = "#171b1e",
  green = "#87918B",
  vibrant_green = "#89938C",
  nord_blue = "#8B958F",
  blue = "#89948D",
  yellow = "#86918A",
  sun = "#bdc2be",
  purple = "#8B958F",
  dark_purple = "#7D8882",
  teal = "#848785",
  orange = "#86918A",
  cyan = "#8B958F",
  statusline_bg = "#343F44",
  lightbg = "#171b1e",
  pmenu_bg = "#89938C",
  folder_bg = "#8B958F",
}

M.base_16 = {
  base00 = "#232A2E",
  base01 = "#171b1e",
  base02 = "#343F44",
  base03 = "#848785",
  base04 = "#bdc2be",
  base05 = "#bdc2be",
  base06 = "#dfe2e5",
  base07 = "#f3f4f5",
  base08 = "#7D8882",
  base09 = "#89938C",
  base0A = "#87918B",
  base0B = "#86918A",
  base0C = "#8B958F",
  base0D = "#89948D",
  base0E = "#89938C",
  base0F = "#7D8882",
}

M.type = "dark"

M = require("base46").override_theme(M, "ashes")

return M
