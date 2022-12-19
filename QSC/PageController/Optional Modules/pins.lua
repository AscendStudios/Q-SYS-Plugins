-- Optional function to define pins on the plugin that are not connected to a Control
function GetPins(props)
  local pins = {}
  --[[ #include "pins.lua" ]]
  return pins
end

table.insert(pins,{
  Name = "Audio Output",
  Direction = "output",
})