local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = "Fira Mono NF Bold 9"

----------------------------------
-- Dark translucent color theme --
----------------------------------

theme.bg_normal     = "#1811155F"
theme.bg_urgent     = "#f11a6906"
theme.bg_minimize   = "#a3e3ff1F"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#caba96DF"
theme.fg_focus      = "#f11a69FF"
theme.fg_urgent     = "#a3e3ffFF"
theme.fg_minimize   = "#f4cc76AF"

theme.useless_gap   = dpi(4)
theme.border_width  = dpi(2)
theme.border_normal = "#181115"
theme.border_focus  = "#f11a69"
theme.border_marked = "#f4cc76"

theme.hotkeys_bg = theme.bg_normal
theme.hotkeys_modifiers_fg = theme.fg_urgent

theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_focus = theme.bg_normal

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.nofication_bg = "#181115"
theme.nofication_bg = "#181115"

theme.notification_border_color = theme.border_focus
theme.notification_border_color = 100

-- Set the size of notifications
theme.notification_icon_size = 80
theme.notification_max_width = 600
theme.notification_max_height = 250

theme.wallpaper = "~/Pictures/wallpapers/wallhaven-288jox.jpg"

-- Set the spacing between the system tray icons
theme.systray_icon_spacing = 5

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Customise tasklist
theme.tasklist_disable_icon = true
theme.tasklist_align = "center"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = Adwaita

return theme
