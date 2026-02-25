local M = {}

-- Three-color light theme
M.base_30 = {
  white = "#474747",         -- Text color
  darker_black = "#CCCCCC",  -- Light background base
  black = "#CCCCCC",         -- Background
  black2 = "#CCCCCC",        -- Same as base
  one_bg = "#CCCCCC",        -- Panel background
  one_bg2 = "#CCCCCC",
  one_bg3 = "#CCCCCC",
  grey = "#333333",          -- Subtle darker elements
  grey_fg = "#474747",
  grey_fg2 = "#474747",
  light_grey = "#474747",
  red = "#333333",
  baby_pink = "#474747",
  pink = "#474747",
  line = "#CCCCCC",
  green = "#333333",
  vibrant_green = "#474747",
  nord_blue = "#474747",
  blue = "#333333",
  yellow = "#474747",
  sun = "#333333",
  purple = "#474747",
  dark_purple = "#333333",
  teal = "#474747",
  orange = "#333333",
  cyan = "#474747",
  statusline_bg = "#CCCCCC",
  lightbg = "#CCCCCC",
  pmenu_bg = "#333333",
  folder_bg = "#333333",
}

M.base_16 = {
  base00 = "#CCCCCC",  -- background
  base01 = "#CCCCCC",
  base02 = "#CCCCCC",
  base03 = "#474747",
  base04 = "#474747",
  base05 = "#333333",  -- main text
  base06 = "#333333",
  base07 = "#333333",
  base08 = "#333333",
  base09 = "#474747",
  base0A = "#474747",
  base0B = "#474747",
  base0C = "#333333",
  base0D = "#333333",
  base0E = "#474747",
  base0F = "#333333",
}

M.type = "light"

-- Optional: override with base46 logic if needed
-- M = require("base46").override_theme(M, "paperwhite")

return M

