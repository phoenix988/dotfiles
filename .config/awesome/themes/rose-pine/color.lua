local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/rose-pine"
theme.wallpaper                                 = theme.dir .. "/wall_default.png"
theme.font                                      = "JetBrains Mono Nerd 14"
theme.taglist_font 				                = "Xirod 13"
theme.fg_normal                                 = "#9CCFD8"
theme.fg_focus                                  = "#C4A7E7"
theme.fg_alt                                    = "#EBBCBA"
theme.fg_clock                                  = "#31748F"
theme.fg_cpu                                    = "#EBCB8B"
theme.fg_mem                                    = "#31748F"
theme.fg_icon                                   = "#9CCFD8"
theme.fg_white                                  = "#ffffff"
theme.bg_normal                                 = "#191724"
theme.bg_focus                                  = "#191724"
theme.fg_urgent                                 = "#EB6F92"
theme.bg_alt                                    = "#2E3440"
theme.bg_urgent                                 = "#191724"
theme.border_width                              = 3
theme.border_normal                             = "#390F1C"
theme.border_focus                              = "#EBBCBA"
theme.taglist_fg_focus                          = "#EBBCBA"
theme.taglist_bg_focus                          = "#191724"
theme.taglist_bg_normal                         = "#191724"
theme.taglist_fg_normal                         = "#191724"
theme.taglist_bg_occupied                       = "#191724"
theme.taglist_fg_occupied                       = "#6E6A86"
theme.titlebar_bg_normal                        = "#191724"
theme.titlebar_bg_focus                         = "#6E6A86"
theme.seperator_1                               = "#9CCFD8"
theme.seperator_2                               = "#2E3440"
theme.seperator_3                               = theme.bg_normal
theme.tasklist_fg_focus                         = "#191724"
theme.tasklist_bg_focus                         = "#9CCFD8"
theme.menu_height                               = 25
theme.menu_width                                = 250
theme.systray_icon_spacing                      = 2
theme.tasklist_disable_icon                     = true
theme.tasklist_plain_task_name                  = true
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_unsel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.vol                                       = theme.dir .. "/icons/vol.png"
theme.vol_low                                   = theme.dir .. "/icons/vol_low.png"
theme.vol_no                                    = theme.dir .. "/icons/vol_no.png"
theme.vol_mute                                  = theme.dir .. "/icons/vol_mute.png"
theme.disk                                      = theme.dir .. "/icons/disk.png"
theme.ac                                        = theme.dir .. "/icons/ac.png"
theme.ac_low                                    = theme.dir .. "/icons/ac_low.png"
theme.ac_full                                   = theme.dir .. "/icons/ac_full.png"
theme.bat                                       = theme.dir .. "/icons/bat.png"
theme.bat_full                                  = theme.dir .. "/icons/bat_full.png"
theme.bat_low                                   = theme.dir .. "/icons/bat_low.png"
theme.bat_no                                    = theme.dir .. "/icons/bat_no.png"
theme.cpu                                       = theme.dir .. "/icons/cpu.png"
theme.play                                      = theme.dir .. "/icons/play.png"
theme.pause                                     = theme.dir .. "/icons/pause.png"
theme.stop                                      = theme.dir .. "/icons/stop.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.useless_gap                               = 6
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

-- lain related
theme.layout_centerfair                         = theme.dir .. "/icons/centerfair.png"
theme.layout_termfair                           = theme.dir .. "/icons/termfair.png"
theme.layout_centerwork                         = theme.dir .. "/icons/centerwork.png"

return theme
