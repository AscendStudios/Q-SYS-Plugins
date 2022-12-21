-- Optional function to define wiring of components used within the plugin
function GetWiring(props)
  local wiring = {}
  --[[ #include "wiring.lua" ]]
  return wiring
end

table.insert( wiring, { "Audio Output", "main_mixer Output 1" } )