local CurrentPage = PageNames[props["page_index"].Value]
if CurrentPage == "Setup" then
  table.insert(graphics, {
    Type = "GroupBox",
    Fill = colors.medium,
    StrokeWidth = 1,
    Position = { 5, 5 },
    Size = { 200, 100 }
  })
  table.insert(graphics, {
    Type = "Text",
    Text = "Device Mac Address",
    Size = { 100, 25 },
    Position = { 50, 12 },
    FontSize = 10,
  })
  layout["MacAddress"] = {
    PrettyName = "Mac Address",
    Style      = "Text",
    Position   = { 50, 37 },
    Size       = { 100, 25 },
    Color      = colors.light
  }
  layout["WOL"] = {
    PrettyName = "Wake On LAN",
    Style = "Button",
    Position = { 75, 75 },
    Size = { 50, 25 },
    Color = colors.red
  }
elseif CurrentPage == "About" then
  local w, h, tol = 125, 50, 25
  local image_w, image_h = 264, 222
  local logo =
  "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"
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
    Size = { w * 2 + 25, h / 2 },
    Position = { tol * 2 + image_w, (tol * 2) + (h / 2) * 6 },
    FontSize = fonts.small,
    HTextAlign = "Left",
  })
end
