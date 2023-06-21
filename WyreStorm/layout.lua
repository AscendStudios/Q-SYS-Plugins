local layout, graphics = {}, {}
local input_count = props.Transmitters.Value
local output_count = props.Receivers.Value
local serial_count = props["Serial Commands"].Value

local title_size = { 212, 50 }
local btn_size = { 50, 25 }
local label_size = { 125, 25 }
local led_size = {25, 25}

local font_size = 16

local bottom
if input_count > output_count then
  bottom = input_count
else
  bottom = output_count + 1
end

local function generate_console()
  layout["Console"] = {
    PrettyName = "Console Display",
    Style = "Text",
    HTextAlign = "Left",
    VTextAlign = "Bottom",
    Padding = 5,
    FontSize = 10,
    Position = { 600, 75 },
    Size = { 200, (7 * 25) },
    Color = colors.light
  }
  layout["Prompt"] = {
    PrettyName = "Console Prompt",
    Style = "Text",
    FontSize = 10,
    HTextAlign = "Left",
    Position = { 600, (8 * 25) + 50 },
    Size = { label_size[1] + 25, label_size[2] },
    Color = colors.light,

  }
  layout["Prompt_Retrun"] = {
    PrettyName = "Return",
    Style = "Button",
    Legend = "Enter",
    FontSize = font_size,
    Position = { 600 + label_size[1] + 25, (8 * 25) + 50 },
    Size = btn_size,
    Color = colors.accent,
  }

  layout["ConnectionState"] = {
    PrettyName = "System~Online",
    Style = "Indicator",
    FontSize = font_size,
    Position = { 25, bottom * 25 + 125 },
    Size = { 525, 50 }
  }
end

local function generate_groups()
  graphics = {
    { -- TRANSMITTER BOX
      Type = "Groupbox",
      Fill = colors.dark,
      StrokeColor = colors.accent,
      Color = colors.accent,
      Position = { 25, 25 },
      Size = { 250, props.Transmitters.Value * 25 + 75 }
    },

    { -- RECEIVER BOX
      Type = "Groupbox",
      Fill = colors.dark,
      StrokeColor = colors.accent,
      Color = colors.accent,
      Position = { 300, 25 },
      Size = { 250, (props.Receivers.Value + 1) * 25 + 75 }
    },

    { --CONSOLE BOX
      Type = "Groupbox",
      Fill = colors.dark,
      StrokeColor = colors.accent,
      Color = colors.accent,
      Position = { 575, 25 },
      Size = { 250, 8 * 25 + 75 }
    },
}
end

local CurrentPage = PageNames[props["page_index"].Value]

if CurrentPage == "Routing" then
    generate_groups()

    --[[ HEADERS ]]--
    table.insert(graphics,
    {
      Type = "Header",
      Text = "Transmitters",
      HTextAlign = "Center",
      Color = colors.accent,
      FontSize = font_size,
      Position = { 44, 25 },
      Size = title_size,
    }
  )
  table.insert(graphics,
    {
      Type = "Header",
      Text = "Receivers",
      HTextAlign = "Center",
      Color = colors.accent,
      FontSize = font_size,
      Position = { 319, 25 },
      Size = title_size,
    }
  )
  table.insert(graphics,
    {
      Type = "Header",
      Text = "Console",
      HTextAlign = "Center",
      Color = colors.accent,
      FontSize = font_size,
      Position = { 594, 25 },
      Size = title_size,
    }
  )
  -- TRANSMITTER Numbers
  for i = 1, input_count do
    table.insert(
      graphics,
      {
        Type = "Text",
        Text = tostring(i),
        HTextAlign = "Center",
        FontSize = font_size,
        Color = colors.accent,
        Size = { 25, 25 },
        Position = { 37, 25 * i + 50 }
      }
    )
  end

  -- Receiver Numbers
  for i = 1, output_count do
    table.insert(
      graphics,
      {
        Type = "Text",
        Text = tostring(i),
        HTextAlign = "Center",
        FontSize = font_size,
        Color = colors.accent,
        Size = { 25, 25 },
        Position = { 312, 25 * i + 50 }
      }
    )
  end

  table.insert(
    graphics,
    {
      Type = "Text",
      Text = "All Receivers",
      HTextAlign = "Center",
      FontSize = font_size,
      Color = colors.accent,
      Size = label_size,
      Position = { 337, 25 * (output_count + 1) + 50 }
    }
  )

  for i = 1, input_count do
    layout["TX_label_" .. i] = {
      PrettyName = "Transmiter " .. i .. "~Name",
      Style = "Text",
      Color = colors.green,
      Size = label_size,
      Position = { 62, 25 * i + 50 },
      Margin = 2,
    }
    layout["TX_Btn_" .. i] = {
      PrettyName = "Transmiter " .. i .. "~Select",
      Style = "Button",
      ButtonType = "Toggle",
      Color = colors.accent,
      FontColor = colors.light,
      Size = btn_size,
      Position = { 200, 25 * i + 50 },
      Margin = 2,
    }
    layout["TX_Status_" .. i] = {
      PrettyName = "Transmiter  " .. i .. "~Status",
      Style = "Led",
      Size = led_size,
      Margin = 8,
      Position = {247, 25 * i + 50}
    }
  end

  for i = 1, output_count do
    layout["RX_label_" .. i] = {
      PrettyName = "Receiver " .. i .. "~Name",
      Style = "Text",
      Color = colors.orange,
      Size = label_size,
      Position = { 337, 25 * i + 50 },
      Margin = 2,
    }
    layout["RX_Btn_" .. i] = {
      PrettyName = "Receiver " .. i .. "~Select",
      Style = "Button",
      ButtonType = "Toggle",
      Color = colors.accent,
      FontColor = colors.light,
      Size = btn_size,
      Position = { 475, 25 * i + 50 },
      Margin = 2,
    }
    layout["RX_All"] = {
      PrettyName = "Receiver All~Select",
      Style = "Button",
      ButtonType = "Toggle",
      Color = colors.accent,
      FontColor = colors.light,
      Size = btn_size,
      Position = { 475, 25 * (output_count + 1) + 50 },
      Margin = 2,
    }
  end

  for i = 1, output_count do
    layout["RX_Status_" .. i] = {
      PrettyName = "Receiver  " .. i .. "~Status",
      Style = "Led",
      Size = led_size,
      Margin = 8,
      Position = {522, 25 * i + 50}
    }
  end
  generate_console()
elseif CurrentPage == "Serial" then
  graphics = {
    {
      Type = "Groupbox",
      Fill = colors.dark,
      StrokeColor = colors.accent,
      Color = colors.accent,
      Position = { 25, 25 },
      Size = { 250, serial_count * 25 + 75 }
    },
    {
      Type = "Header",
      Text = "Serial Commands",
      HTextAlign = "Center",
      Color = colors.accent,
      FontSize = font_size,
      Position = { 50, 25 },
      Size = title_size,
    },
    {
      Type = "Groupbox",
      Fill = colors.dark,
      StrokeColor = colors.accent,
      Color = colors.accent,
      Position = { 300, 25 },
      Size = { 250, (output_count + 1) * 25 + 75 }
    },
    {
      Type = "Header",
      Text = "Receivers",
      HTextAlign = "Center",
      Color = colors.accent,
      FontSize = font_size,
      Position = { 312, 25 },
      Size = title_size,
    },
    {
      Type = "Groupbox",
      Fill = colors.dark,
      StrokeColor = colors.accent,
      Color = colors.accent,
      Position = { 575, 25 },
      Size = { 250, 8 * 25 + 75 }
    },
    {
      Type = "Header",
      Text = "Console",
      HTextAlign = "Center",
      Color = colors.accent,
      FontSize = font_size,
      Position = { 594, 25 },
      Size = title_size,
    },
  }

  for i = 1, serial_count do
    table.insert(
      graphics,
      {
        Type = "Text",
        Text = tostring(i),
        HTextAlign = "Center",
        FontSize = font_size,
        Color = colors.accent,
        Size = { 25, 25 },
        Position = { 37, 25 * i + 50 }
      }
    )
  end

  for i = 1, output_count do
    table.insert(
      graphics,
      {
        Type = "Text",
        Text = tostring(i),
        HTextAlign = "Center",
        FontSize = font_size,
        Color = colors.accent,
        Size = { 25, 25 },
        Position = { 312, 25 * i + 50 }
      }
    )
  end

  table.insert(
    graphics,
    {
      Type = "Text",
      Text = "All Receivers",
      HTextAlign = "Center",
      FontSize = font_size,
      Color = colors.accent,
      Size = label_size,
      Position = { 337, 25 * (output_count + 1) + 50 }
    }
  )

  for i = 1, serial_count do
    layout["Serial_Str_" .. i] = {
      PrettyName = "Transmiter " .. i .. "~Name",
      Style = "Text",
      Color = colors.pink,
      Size = label_size,
      Position = { 62, 25 * i + 50 },
      Margin = 2,
    }
    layout["Serial_Btn_" .. i] = {
      PrettyName = "Transmiter " .. i .. "~Select",
      Style = "Button",
      ButtonType = "Toggle",
      Color = colors.accent,
      FontColor = colors.light,
      Size = btn_size,
      Position = { 200, 25 * i + 50 },
      Margin = 2,
    }
  end

  for i = 1, output_count do
    layout["RX_label_" .. i] = {
      PrettyName = "Receiver " .. i .. "~Name",
      Style = "Text",
      Color = colors.orange,
      Size = label_size,
      Position = { 337, 25 * i + 50 },
      Margin = 2,
    }
    layout["RX_Btn_" .. i] = {
      PrettyName = "Receiver " .. i .. "~Select",
      Style = "Button",
      ButtonType = "Toggle",
      Color = colors.accent,
      FontColor = colors.light,
      Size = btn_size,
      Position = { 475, 25 * i + 50 },
      Margin = 2,
    }

    for i = 1, output_count do
      layout["RX_Status_" .. i] = {
        PrettyName = "Receiver  " .. i .. "~Status",
        Style = "Led",
        Size = led_size,
        Margin = 8,
        Position = {522, 25 * i + 50}
      }
    end

    layout["RX_All"] = {
      PrettyName = "Receiver All~Select",
      Style = "Button",
      ButtonType = "Toggle",
      Color = colors.accent,
      FontColor = colors.light,
      Size = btn_size,
      Position = { 475, 25 * (output_count + 1) + 50 },
      Margin = 2,
    }
  end

generate_console()

elseif CurrentPage == "USB" then
  graphics = {
    {
      Type = "Groupbox",
      Fill = colors.dark,
      StrokeColor = colors.accent,
      Color = colors.accent,
      Position = { 25, 25 },
      Size = { 250, input_count * 25 + 75 }
    },
    {
      Type = "Header",
      Text = "USB Transmitters",
      HTextAlign = "Center",
      Color = colors.accent,
      FontSize = font_size,
      Position = { 44, 25 },
      Size = title_size,
    },
    {
      Type = "Groupbox",
      Fill = colors.dark,
      StrokeColor = colors.accent,
      Color = colors.accent,
      Position = { 300, 25 },
      Size = { 250, (output_count) * 25 + 75 }
    },
    {
      Type = "Header",
      Text = "USB Receivers",
      HTextAlign = "Center",
      Color = colors.accent,
      FontSize = font_size,
      Position = { 319, 25 },
      Size = title_size,
    },
    {
      Type = "Groupbox",
      Fill = colors.dark,
      StrokeColor = colors.accent,
      Color = colors.accent,
      Position = { 575, 25 },
      Size = { 250, (input_count) * 25 + 75  }
    },
    {
      Type = "Header",
      Text = "Console",
      HTextAlign = "Center",
      Color = colors.accent,
      FontSize = font_size,
      Position = { 594, 25 },
      Size = title_size,
    },
  }

  for i = 1, input_count do
    table.insert(
      graphics,
      {
        Type = "Text",
        Text = tostring(i),
        HTextAlign = "Center",
        FontSize = font_size,
        Color = colors.accent,
        Size = { 25, 25 },
        Position = { 37, 25 * i + 50 }
      }
    )
  end

  for i = 1, output_count do
    table.insert(
      graphics,
      {
        Type = "Text",
        Text = tostring(i),
        HTextAlign = "Center",
        FontSize = font_size,
        Color = colors.accent,
        Size = { 25, 25 },
        Position = { 312, 25 * i + 50 }
      }
    )
  end


  for i = 1, input_count do
    layout["TX_label_" .. i] = {
      PrettyName = "USB Transmiter " .. i .. "~Name",
      Style = "Text",
      Color = colors.green,
      Size = label_size,
      Position = { 62, 25 * i + 50 },
      Margin = 2,
    }
    layout["USB_Btn_TX_" .. i] = {
      PrettyName = "USB Transmiter " .. i .. "~Select",
      Style = "Button",
      ButtonType = "Toggle",
      Color = colors.accent,
      FontColor = colors.light,
      Size = btn_size,
      Position = { 200, 25 * i + 50 },
      Margin = 2,
    }
    layout["TX_Status_" .. i] = {
      PrettyName = "Transmiter  " .. i .. "~Status",
      Style = "Led",
      Size = led_size,
      Margin = 8,
      Position = {247, 25 * i + 50}
    }
  end

  for i = 1, output_count do
    layout["RX_label_" .. i] = {
      PrettyName = "USB Receiver " .. i .. "~Name",
      Style = "Text",
      Color = colors.orange,
      Size = label_size,
      Position = { 337, 25 * i + 50 },
      Margin = 2,
    }
    layout["USB_Btn_RX_" .. i] = {
      PrettyName = "Receiver " .. i .. "~Select",
      Style = "Button",
      ButtonType = "Toggle",
      Color = colors.accent,
      FontColor = colors.light,
      Size = btn_size,
      Position = { 475, 25 * i + 50 },
      Margin = 2,
    }
    layout["RX_Status_" .. i] = {
      PrettyName = "Receiver  " .. i .. "~Status",
      Style = "Led",
      Size = led_size,
      Margin = 8,
      Position = {522, 25 * i + 50}
    }
  end
  generate_console()
elseif CurrentPage == "Config" then
  graphics = {
    {
      Type = "Groupbox",
      Fill = colors.dark,
      StrokeColor = colors.accent,
      Color = colors.accent,
      Position = { 25, 25 },
      Size = { 262, 287 }
    },
    {
      Type = "Header",
      Text = "Configuration",
      HTextAlign = "Center",
      Color = colors.accent,
      FontSize = font_size,
      Position = { 50, 25 },
      Size = title_size,
    },
  }
  layout["IpAddress"] = {
    PrettyName = "System~IpAddress",
    Style = "Textbox",
    Position = { 50, 75 },
    Size = title_size,
    FontSize = font_size,
    Color = colors.medium,
    FontColor = colors.light,
  }
  layout["ConnectionState"] = {
    PrettyName = "System~Online",
    Style = "Indicator",
    FontSize = font_size,
    Position = { 50, 137 },
    Size = title_size
  }
  table.insert(
    graphics,
    {
      Type = "Header",
      Text = "Connect",
      Size = title_size,
      HTextAlign = "Center",
      FontSize = font_size,
      Position = { 50, 187 },
      Color = colors.accent
    }
  )
  layout["Connect"] = {
    PrettyName = "System~Connect",
    Style = "Button",
    ButtonType = "Toggle",
    Color = colors.accent,
    FontColor = colors.light,
    Size = title_size,
    Position = { 50, 237 },
  }

elseif CurrentPage == "About" then
  graphics = {
    {
      Type = "Header",
      Text = "About",
      Size = title_size,
      HTextAlign = "Center",
      FontSize = font_size,
      Position = { 50, 5 },
      Color = colors.medium
    },
    {
      Type = "Textbox",
      Text = "Name",
      Size = { 75, 25 },
      VTextAlign = "Top",
      HTextAlign = "Left",
      Position = { 50, 50 },
      Color = colors.medium
    },
    {
      Type = "Textbox",
      Text = "Version",
      Size = { 75, 25 },
      VTextAlign = "Top",
      HTextAlign = "Left",
      Position = { 50, 75 },
      Color = colors.medium
    },
    {
      Type = "Textbox",
      Text = "Build",
      Size = { 75, 25 },
      VTextAlign = "Top",
      HTextAlign = "Left",
      Position = { 50, 100 },
      Color = colors.medium
    },
    {
      Type = "Textbox",
      Text = "Author",
      Size = { 75, 25 },
      VTextAlign = "Top",
      HTextAlign = "Left",
      Position = { 50, 125 },
      Color = colors.medium
    },
    {
      Type = "Textbox",
      Text = "Description",
      Size = { 75, 25 },
      VTextAlign = "Top",
      HTextAlign = "Left",
      Position = { 50, 150 },
      Color = colors.medium
    },
    {
      Type = "Textbox",
      Text = PluginInfo.Name,
      Size = { 200, 25 },
      VTextAlign = "Top",
      HTextAlign = "Left",
      Position = { 125, 50 },
      Color = colors.dark
    },
    {
      Type = "Textbox",
      Text = PluginInfo.Version,
      Size = { 200, 25 },
      VTextAlign = "Top",
      HTextAlign = "Left",
      Position = { 125, 75 },
      Color = colors.dark
    },
    {
      Type = "Textbox",
      Text = PluginInfo.BuildVersion,
      Size = { 200, 25 },
      VTextAlign = "Top",
      HTextAlign = "Left",
      Position = { 125, 100 },
      Color = colors.dark
    },
    {
      Type = "Textbox",
      Text = PluginInfo.Author,
      Size = { 200, 25 },
      VTextAlign = "Top",
      HTextAlign = "Left",
      Position = { 125, 125 },
      Color = colors.dark
    },
    {
      Type = "Textbox",
      Text = PluginInfo.Description,
      Size = { 200, 25 },
      VTextAlign = "Top",
      HTextAlign = "Left",
      Position = { 125, 150 },
      Color = colors.dark
    },

    -- TODO: Add an logo image

  }
end
return layout, graphics
