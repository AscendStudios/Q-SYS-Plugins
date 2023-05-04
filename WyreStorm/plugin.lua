-- WyreSrom NHD 100 Series Controller
-- By Casey Compton
-- July 01 2022
-- Information block for the plugin


--[[ #include "info.lua" ]]
local colors = {
    dark = { 59, 66, 82 },
    light = { 229, 233, 240 },
    medium = { 129, 161, 193 },
    accent = { 143, 188, 187 },
    red = { 191, 97, 106 },
    orange = { 208, 135, 112 },
    yellow = { 235, 203, 139 },
    green = { 163, 190, 140 },
    pink = { 180, 142, 173 },
    block = { 207, 129, 45 }
}

-- Define the color of the plugin object in the design
function GetColor(props) return colors.block end

-- The name that will initially display when dragged into a design
function GetPrettyName(props)
    return PluginInfo.Name .. "V " .. PluginInfo.Version
end

-- Optional function used if plugin has multiple pages
PageNames = { "Routing", "Serial", "Config", "About" }  -- List the pages within the plugin
function GetPages(props)
    --[[ #include "pages.lua" ]]
end

-- Define User configurable Properties of the plugin
function GetProperties()
    --[[ #include "properties.lua" ]]
end

-- Optional function to update available properties when properties are altered by the user
function RectifyProperties(props)
    --[[ #include "rectify_properties.lua" ]]
    return
        props
end

--[[
      TODO:
            Add Custom Prompt
            Add Submit Button for Custom
            Add Serial Labels
            Add Serial Buttons
  ]]
-- Defines the Controls used within the plugin
function GetControls(props)
    --[[ #include "controls.lua" ]]
end

-- Layout of controls and graphics for the plugin UI to display
function GetControlLayout(props)
    --[[ #include "layout.lua" ]]
end

-- Start event based logic
if Controls then
    --[[ #include "runtime/runtime.lua" ]]
end
