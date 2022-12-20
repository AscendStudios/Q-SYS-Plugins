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
local btn_w, btn_h = w/2, h/2
local row = 1
local col = 1

---------------------------------------------------------
-- Control Page
---------------------------------------------------------
if CurrentPage == "Control" then

    table.insert(graphics,
    {
        Type = "Header",
        Text = "Page Selection",
        Position = { tol, tol },
        Size = { w, h },
        FontSize = fonts.small
      })

    --Selection Box--
    layout.pageSelection = {
        PrettyName = "Page Selection",
        Style = "ComboBox",
        Position = { tol, tol+h},
        Size = { w, h },
        FontSize = fonts.small
      }

    --Header--
    table.insert(graphics,
    {
        Type = "Header",
        Text = "Page Buttons",
        Position = { tol, h*2+tol},
        Size = { w, h },
        FontSize = fonts.small
      })
    
    --Init Layout for buttons and labels
    layout["pageButton"] = {
    Style = "Button",
    ButtonType = "Toggle",
    Size = { btn_w/2, btn_h },
    Position = { tol, (h*3) + (btn_h) }
    }

    layout["pageLabel"] = {
    Style = "ComboBox",
    Margin = 2,
    Size = { btn_w + btn_w/2, btn_h },
    Position = { tol + btn_w - (btn_w/2), (h*3) + ( btn_h) },
    }

    -- Each Button and Label layout
    for index=1, props["Page Buttons"].Value do
        layout["pageButton "..index] = {
            PrettyName = "Page Button~"..index,
            Size = { btn_w/2, btn_h },
            Position = { tol, (h*3) + (index * btn_h) }
        }
        layout["pageLabel "..index] = {
            Style = "ComboBox",
            Size = { btn_w + btn_w/2, btn_h },
            Position = { tol + btn_w - (btn_w/2), (h*3) + (index * btn_h) },
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
        Size = {h, h},
        Position = {tol, tol + h}
    }

    for i=1, 10 do
        if i == 10 then
            row, col = 4, 2
        elseif i < 4 then
            row, col = 1, i
        elseif i < 7 then
            row, col = 2, i-3
        else
            row , col = 3, i-6
        end
        layout["numPad "..i] = {
            PrettyName = "Num Pad "..i,
            Size = {h, h},
            Position = {tol + col*h-h, tol + row*h}
        }
    end

  layout["clear"] = {
      PrettyName = "Clear",
      Style = "Button",
      ButtonType = "Momentary",
      Size = {h, h},
      Position = {tol, tol + 4*h}
  }
  layout["back"] = {
      PrettyName = "Back",
      Style = "Button",
      ButtonType = "Momentary",
      Size = {h, h},
      Position = {tol + 3*h-h, tol + 4*h}
  }
  layout["enter"] = {
      PrettyName = "Enter",
      Style = "Button",
      ButtonType = "Momentary",
      Size = {w, h},
      Position = {tol, tol + 5*h}
  }
  layout["pinDisplay"] = {
      PrettyName = "Pin Display",
      Style = "Text",
      Margin = 2,
      Size = {w, h},
      Position = {tol, tol}
  }

---------------------------------------------------------------
-------------------------CONFIGURATION-------------------------
---------------------------------------------------------

elseif CurrentPage == "Configuration" then

    w = w + btn_h

    for index, name in ipairs({"Panel Selection", "UCI Selecion"}) do
        table.insert(graphics,
            {
                Type = "Text",
                Text = name,
                Position = {tol+w*index - w, tol},
                Size = {w,h},
                FontSize = 14,
                HTextAlign = "Left"
            })

    layout.panelSelection = {
        PrettyName = "Panel Selection",
        Style = "ComboBox",
        Position = {tol, tol+h},
        Size = {w, h},
        FontSize = 12,
        Margin = 2
    }

    layout.uciSelection = {
        PrettyName = "UCI Selection",
        Style = "ComboBox",
        Position = {tol+w, tol+h},
        Size = {w, h},
        FontSize = 12,
        Margin = 2
    }

    table.insert(graphics, {
        Type = "Header",
        Text = "Pin Code Configuration",
        Position = {tol, tol+(h*3)},
        Size = {w*2, h},
        FontSize = fonts.normal,
        Margin = 2,
    })

    table.insert(graphics, {
        Type = "Text",
        Text = "Admin Page",
        Position = {tol, tol+(h*4)},
        Size = {w-btn_h, h},
        FontSize = fonts.small,
        Margin = 2,
        HTextAlign = "Left"
    })

    layout.adminLandingPage = {
        PrettyName = "Admin Landing Page",
        Style = "ComboBox",
        Position = {tol, tol+(h*5)},
        Size = {w-btn_h, btn_h},
        FontSize = fonts.small,
        Margin = 2
    }

    table.insert(graphics, {
      Type = "Text",
      Text = "Pin",
      Position = {tol+w + btn_h, tol+(h*4)},
      Size = {btn_w, h},
      FontSize = fonts.small,
      Margin = 2,
      HTextAlign = "Left"
      })

    table.insert(graphics, {
    Type = "Text",
    Text = "Page",
    Position = {tol+w + btn_h+btn_w, tol+(h*4)},
    Size = {btn_w, h},
    FontSize = fonts.small,
    Margin = 2,
    HTextAlign = "Left"
    })

    layout["pinEnable"] = {
    PrettyName = "Pin Enable",
    Style = "Button",
    ButtonType = "Toggle",
    Size = {btn_h, btn_h},
    Position = { tol+w, tol+(h*5)}
    }

    layout["pinCode"] = {
    PrettyName = "Pin Codes",
    Style = "ComboBox",
    Size = {btn_w, btn_h},
    Position = { (tol+w)+btn_h, tol+(h*5)},
    Margin = 2
    }

    layout["pinLandingPage"] = {
    PrettyName = "Custom Landing Page",
    Style = "ComboBox",
    Size = {btn_w, btn_h},
    Position = {(tol+w)+btn_h+btn_w, tol+(h*5)},
    Margin = 2
    }


      for i=1, props["Defined Pass Codes"].Value do
        layout["pinEnable "..i] = {
            PrettyName = "Pin Enable "..i,
            Size = {btn_h, btn_h},
            Position = {tol+w, tol+(h*5)+btn_h*(i-1)}
        }

        layout["pinCode "..i] = {
            PrettyName = "Pin Code "..i,
            Size = {btn_w, btn_h},
            Position = { (tol+w)+btn_h, tol+(h*5)+btn_h*(i-1)},
            Margin = 2,
        }
        layout["pinLandingPage "..i] = {
            PrettyName = "Custom Landing Page "..i,
            Size = {btn_w, btn_h},
            Position = {(tol+w)+btn_h+btn_w, tol+(h*5)+btn_h*(i-1)},
            Margin = 2,
            Style = "ComboBox",
        }
      end
  end
end