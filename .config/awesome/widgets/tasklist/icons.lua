local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")

local chosen_theme = require("activate_theme")
local theme = require("themes/" .. chosen_theme .. "/color")

local markup = lain.util.markup

-- Eminent-like task filtering
local orig_filter = awful.widget.taglist.filter.all

-- Taglist label functions
awful.widget.taglist.filter.all = function(t, args)
    if t.selected or #t:clients() > 0 then
        return orig_filter(t, args)
    end
end

-- Create tasklist with icons
local icontasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = awful.util.tasklist_buttons,
    style = {
        shape_border_width = 1,
        shape_border_color = theme.bg_normal,
        shape = gears.shape.rounded_bar,
        bg_focus = theme.taglist_fg_focus,
        bg_normal = theme.bg_alt,
        spacing = 10,
    },
    layout = {
        spacing_widget = {
            {
                forced_width = 5,
                forced_height = 30,
                thickness = 1,
                shape = gears.shape.circle,
                color = theme.bg_normal,
                margin = 20,
                widget = wibox.widget.separator,
            },
            valign = "center",
            halign = "center",
            widget = wibox.container.place,
        },
        spacing = 20,
        layout = wibox.layout.fixed.horizontal,
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
        {
            wibox.widget.base.make_widget(),
            forced_height = 5,
            id = "background_role",
            widget = wibox.container.background,
        },
        {
            {
                id = "clienticon",
                widget = awful.widget.clienticon,
                forced_width = 25,
            },
            margins = 2,
            widget = wibox.container.margin,
        },
        nil,
        create_callback = function(self, c, index, objects) --luacheck: no unused args
            self:get_children_by_id("clienticon")[1].client = c
        end,
        layout = wibox.layout.align.vertical,
    },
})

return icontasklist
