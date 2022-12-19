-- Page Navigation Plugin
-- By Casey Compton
-- December 02 2022


-- Information block for the plugin
--[[ #include "info.lua" ]]

local colors = {
  dark = {59, 66, 82},
  light = {229, 233, 240},
  medium = {129,161,193},
  accent = {143,188,187},
  red = {191,97,106},
  orange = {208,135,112},
  yellow = {235,203,139},
  green = {163,190,140},
  pink = {180,142,173},
}

local fonts = {
  title = 24,
  normal = 16,
  small = 12,
}

-- Define the color of the plugin object in the design
function GetColor(props)
  return { 50, 82, 123 }
end

-- The name that will initially display when dragged into a design
function GetPrettyName(props)
  return "Page Navigation, V " .. PluginInfo.Version
end

-- Optional function used if plugin has multiple pages
PageNames = { "Control", "Passcode", "Configuration" }  --List the pages within the plugin
function GetPages(props)
  local pages = {}
  --[[ #include "pages.lua" ]]
  return pages
end

-- Define User configurable Properties of the plugin
function GetProperties()
  --[[ #include "properties.lua" ]]
end


-- Optional function to update available properties when properties are altered by the user
function RectifyProperties(props)
  --[[ #include "rectify_properties.lua" ]]
  return props
end


-- Defines the Controls used within the plugin
function GetControls(props)
  local ctrls = {}
  --[[ #include "controls.lua" ]]
  return ctrls
end

--Layout of controls and graphics for the plugin UI to display
function GetControlLayout(props)
  local layout = {}
  local graphics = {}
  --[[ #include "layout.lua" ]]
  return layout, graphics
end

--Start event based logic
if Controls then
  --[[ #include "runtime.lua" ]]
end
