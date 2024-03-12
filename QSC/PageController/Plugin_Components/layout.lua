-- table.insert(graphics,{
--   Type = "GroupBox",
--   Text = "Control",
--   Fill = {200,200,200},
--   StrokeWidth = 1,
--   Position = {5,5},
--   Size = {200,100}
-- })
-- table.insert(graphics,{
--   Type = "Text",
--   Text = "Say Hello:",
--   Position = {10,42},
--   Size = {90,16},
--   FontSize = 14,
--   HTextAlign = "Right"
-- })
-- layout["SendButton"] = {
--   PrettyName = "Buttons~Send The Command",
--   Style = "Button",
--   Position = {105,42},
--   Size = {50,16},
--   Color = {0,0,0}
-- }


local CurrentPage = PageNames[props["page_index"].Value]
local w, h, tol = 150, 50, 25
local btn_w, btn_h = w / 2, h / 2
local row = 1
local col = 1

local function full_width()
    if props["Filtered Pages"].Value > 0 then return w * 2 + tol end
    return w
end

local function second_column_pos()
    return (tol * 2) + w
end

---------------------------------------------------------
-- Control Page
---------------------------------------------------------
if CurrentPage == "Control" then
    table.insert(graphics, {
        Type = "Text",
        Text = "Touch Panel Status",
        Size = { full_width(), tol / 2 },
        Position = { tol, 0 }
    })

    layout["panelStatus"] = {
        PrettyName = "Touch Panel Status",
        Style = "Indicator",
        Position = { tol, tol / 2 },
        Size = { full_width(), tol + (tol / 2) },
        Margin = 2,
        Padding = 3
    }

    table.insert(graphics,
                 {
                     Type = "Header",
                     Text = "Page Selection",
                     Position = { tol, tol + (tol / 2) },
                     Size = { full_width(), h },
                     FontSize = fonts.small
                 })

    --Selection Box--
    layout.pageSelection = {
        PrettyName = "Page Selection",
        Style = "ComboBox",
        Position = { tol, tol + (tol / 2) + h },
        Size = { full_width(), h },
        FontSize = fonts.small
    }

    --Header--
    table.insert(graphics,
                 {
                     Type = "Header",
                     Text = "Page Buttons",
                     Position = { tol, h * 2 + tol + tol },
                     Size = { w, btn_h },
                     FontSize = fonts.small
                 })

    --Init Layout for buttons and labels
    layout["pageButton"] = {
        Style = "Button",
        ButtonType = "Toggle",
        Size = { btn_w / 2, btn_h },
        Position = { tol, (h * 3) + (btn_h) }
    }

    layout["pageLabel"] = {
        Style = "ComboBox",
        Margin = 2,
        Size = { btn_w + btn_w / 2, btn_h },
        Position = { tol + btn_w - (btn_w / 2), (h * 3) + (btn_h) },
    }

    -- Each Button and Label layout
    for index = 1, props["Page Buttons"].Value do
        layout["pageButton " .. index] = {
            PrettyName = "Page Button~" .. index,
            Size = { btn_w / 2, btn_h },
            Position = { tol, (h * 3) + (index * btn_h) }
        }
        layout["pageLabel " .. index] = {
            Style = "ComboBox",
            Size = { btn_w + btn_w / 2, btn_h },
            Position = { tol + btn_w - (btn_w / 2), (h * 3) + (index * btn_h) },
        }
    end
    -- Filter List --
    if props["Filtered Pages"].Value > 0 then
        table.insert(graphics,
                     {
                         Type = "Header",
                         Text = "Filter List",
                         Position = { second_column_pos(), h * 2 + tol + tol },
                         Size = { w, btn_h },
                         FontSize = fonts.small
                     })
    end

    --Init Layout for buttons and labels
    layout["filterEnable"] = {
        Style = "Button",
        ButtonType = "Toggle",
        Size = { btn_w / 2, btn_h },
        Position = { second_column_pos(), (h * 3) + (btn_h) }
    }

    layout["filterList"] = {
        Style = "ComboBox",
        Margin = 2,
        Size = { btn_w + btn_w / 2, btn_h },
        Position = { second_column_pos() + btn_w - (btn_w / 2), (h * 3) + (btn_h) },
    }

    -- Each Button and Label layout
    for index = 1, props["Filtered Pages"].Value do
        layout["filterEnable " .. index] = {
            PrettyName = "Enable Filter~" .. index,
            Size = { btn_w / 2, btn_h },
            Position = { second_column_pos(), (h * 3) + (index * btn_h) }
        }
        layout["filterList " .. index] = {
            Style = "ComboBox",
            Size = { btn_w + btn_w / 2, btn_h },
            Position = { second_column_pos() + btn_w - (btn_w / 2), (h * 3) + (index * btn_h) },
        }
    end
    ------------------------------------------------------------
    ---------------------------PASSCODE-------------------------
    ------------------------------------------------------------
elseif CurrentPage == "Passcode" then
    --init button layout
    layout["numPad"] = {
        PrettyName = "Number Pad",
        Style = "Button",
        ButtonType = "Momentary",
        Size = { h, h },
        Position = { tol, tol + h }
    }

    for i = 1, 10 do
        local zero = nil
        if i == 10 then
            row, col = 4, 2
            zero = "0"
        elseif i < 4 then
            row, col = 1, i
        elseif i < 7 then
            row, col = 2, i - 3
        else
            row, col = 3, i - 6
        end
        layout["numPad " .. i] = {
            PrettyName = "Num Pad " .. i,
            Legend = zero or tostring(i),
            Size = { h, h },
            Position = { tol + col * h - h, tol + row * h },
            FontSize = fonts.normal
        }
    end

    layout["clear"] = {
        PrettyName = "Clear",
        Style = "Button",
        ButtonType = "Momentary",
        Legend = "Clear",
        Size = { h, h },
        Position = { tol, tol + 4 * h }
    }
    layout["back"] = {
        PrettyName = "Back",
        Legend = "Back",
        Style = "Button",
        ButtonType = "Momentary",
        Size = { h, h },
        Position = { tol + 3 * h - h, tol + 4 * h }
    }
    layout["enter"] = {
        PrettyName = "Enter",
        Legend = "Enter",
        Style = "Button",
        ButtonType = "Momentary",
        Size = { w, h },
        Position = { tol, tol + 5 * h },
        FontSize = fonts.normal
    }
    layout["pinDisplay"] = {
        PrettyName = "Pin Display",
        Style = "Text",
        Margin = 2,
        Size = { w, h },
        Position = { tol, tol },
        FontSize = fonts.normal
    }

    table.insert(graphics, {
        Type = "Text",
        Text = "Pin Success",
        Position = { tol * 2 + w, tol },
        Size = { btn_w, btn_h },
        FontSize = fonts.small
    })

    layout["pinSuccess"] = {
        PrettyName = "Pin Success",
        Style = "Indicator",
        Position = { w + tol * 2 + (btn_w / 2) - 7, tol + btn_h },
        Size = { 15, 15 },
    }

    table.insert(graphics, {
        Type = "GroupBox",
        StrokeWidth = 1,
        Position = { tol * 2 + w, tol + 2 },
        Size = { btn_w, h - 4 }
    })

    ---------------------------------------------------------------
    -------------------------CONFIGURATION-------------------------
    ---------------------------------------------------------
elseif CurrentPage == "Configuration" then
    w = w + btn_h

    for index, name in ipairs({ "Panel Selection", "UCI Selecion" }) do
        table.insert(graphics,
                     {
                         Type = "Text",
                         Text = name,
                         Position = { tol + w * index - w, tol },
                         Size = { w, h },
                         FontSize = 14,
                         HTextAlign = "Left"
                     })

        layout.panelSelection = {
            PrettyName = "Panel Selection",
            Style = "ComboBox",
            Position = { tol, tol + h },
            Size = { w, h },
            FontSize = 12,
            Margin = 2
        }

        layout.uciSelection = {
            PrettyName = "UCI Selection",
            Style = "ComboBox",
            Position = { tol + w, tol + h },
            Size = { w, h },
            FontSize = 12,
            Margin = 2
        }

        table.insert(graphics, {
            Type = "Header",
            Text = "Pin Code Configuration",
            Position = { tol, tol + (h * 3) },
            Size = { w * 2, h },
            FontSize = fonts.normal,
            Margin = 2,
        })

        table.insert(graphics, {
            Type = "Text",
            Text = "Admin Page",
            Position = { tol, tol + (h * 4) },
            Size = { w - btn_h, h },
            FontSize = fonts.small,
            Margin = 2,
            HTextAlign = "Left"
        })

        layout.adminLandingPage = {
            PrettyName = "Admin Landing Page",
            Style = "ComboBox",
            Position = { tol, tol + (h * 5) },
            Size = { w - btn_h, btn_h },
            FontSize = fonts.small,
            Margin = 2
        }

        table.insert(graphics, {
            Type = "Text",
            Text = "Pin",
            Position = { tol + w + btn_h, tol + (h * 4) },
            Size = { btn_w, h },
            FontSize = fonts.small,
            Margin = 2,
            HTextAlign = "Left"
        })

        table.insert(graphics, {
            Type = "Text",
            Text = "Page",
            Position = { tol + w + btn_h + btn_w, tol + (h * 4) },
            Size = { btn_w, h },
            FontSize = fonts.small,
            Margin = 2,
            HTextAlign = "Left"
        })

        layout["pinEnable"] = {
            PrettyName = "Pin Enable",
            Style = "Button",
            ButtonType = "Toggle",
            Size = { btn_h, btn_h },
            Position = { tol + w, tol + (h * 5) }
        }

        layout["pinCode"] = {
            PrettyName = "Pin Codes",
            Style = "ComboBox",
            Size = { btn_w, btn_h },
            Position = { (tol + w) + btn_h, tol + (h * 5) },
            Margin = 2
        }

        layout["pinLandingPage"] = {
            PrettyName = "Custom Landing Page",
            Style = "ComboBox",
            Size = { btn_w, btn_h },
            Position = { (tol + w) + btn_h + btn_w, tol + (h * 5) },
            Margin = 2
        }


        for i = 1, props["Defined Pass Codes"].Value do
            layout["pinEnable " .. i] = {
                PrettyName = "Pin Enable " .. i,
                Size = { btn_h, btn_h },
                Position = { tol + w, tol + (h * 5) + btn_h * (i - 1) }
            }

            layout["pinCode " .. i] = {
                PrettyName = "Pin Code " .. i,
                Size = { btn_w, btn_h },
                Position = { (tol + w) + btn_h, tol + (h * 5) + btn_h * (i - 1) },
                Margin = 2,
            }
            layout["pinLandingPage " .. i] = {
                PrettyName = "Custom Landing Page " .. i,
                Size = { btn_w, btn_h },
                Position = { (tol + w) + btn_h + btn_w, tol + (h * 5) + btn_h * (i - 1) },
                Margin = 2,
                Style = "ComboBox",
            }
        end
    end
elseif CurrentPage == "About" then
    -- table.insert(graphics,{
    --   Type = "Text",
    --   Text = "Say Hello:",
    --   Position = {10,42},
    --   Size = {90,16},
    --   FontSize = 14,
    --   HTextAlign = "Right"
    -- })
    local image_w, image_h = 264, 222
    local logo = '--[[ #encode "Assets/ASLogo.png" ]]'
    table.insert(graphics, {
        Type = "Image",
        Image = logo,
        Position = { tol, tol },
        Size = { image_w, image_h }
    })

    table.insert(graphics, {
        Type = "GroupBox",
        Position = { tol + image_w, tol },
        Size = { image_w + tol * 2, image_h },
        Fill = colors.light,
        StrokeWidth = 1,
    })

    table.insert(graphics, {
        Type = "Text",
        Text = "Ascend Studios",
        Size = { w * 2, h },
        Position = { tol * 2 + image_w, tol },
        FontSize = fonts.title,
        HTextAlign = "Left"
    })

    table.insert(graphics, {
        Type = "Text",
        Text = "Name: " .. PluginInfo.Name,
        Size = { w * 2, h / 2 },
        Position = { tol * 2 + image_w, (tol * 2) + (h / 2) },
        FontSize = fonts.small,
        HTextAlign = "Left"
    })
    table.insert(graphics, {
        Type = "Text",
        Text = "Version: " .. PluginInfo.Version,
        Size = { w * 2, h / 2 },
        Position = { tol * 2 + image_w, (tol * 2) + (h / 2) * 2 },
        FontSize = fonts.small,
        HTextAlign = "Left"
    })
    table.insert(graphics, {
        Type = "Text",
        Text = "Build: " .. PluginInfo.BuildVersion,
        Size = { w * 2, h / 2 },
        Position = { tol * 2 + image_w, (tol * 2) + (h / 2) * 3 },
        FontSize = fonts.small,
        HTextAlign = "Left"
    })
    table.insert(graphics, {
        Type = "Text",
        Text = "Author: " .. PluginInfo.Author,
        Size = { w * 2, h / 2 },
        Position = { tol * 2 + image_w, (tol * 2) + (h / 2) * 4 },
        FontSize = fonts.small,
        HTextAlign = "Left"
    })
    table.insert(graphics, {
        Type = "Text",
        Text = "Email: Support@AscendStudios.com",
        Size = { w * 2, h / 2 },
        Position = { tol * 2 + image_w, (tol * 2) + (h / 2) * 5 },
        FontSize = fonts.small,
        HTextAlign = "Left"
    })
    table.insert(graphics, {
        Type = "Text",
        Text = "https://github.com/AscendStudios/Q-SYS-Plugins",
        Size = { w * 2, h / 2 },
        Position = { tol * 2 + image_w, (tol * 2) + (h / 2) * 6 },
        FontSize = fonts.small,
        HTextAlign = "Left",
    })
end
