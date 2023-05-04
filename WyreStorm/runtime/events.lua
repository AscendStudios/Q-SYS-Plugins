Controls.Connect.EventHandler = connection_init

Controls.RX_All.EventHandler = function(ctl)
  for _, _ctl in ipairs(Controls.RX_Buttons) do
    _ctl.Boolean = ctl.Boolean
  end
  if ctl.Boolean and table.contains(Controls.TX_Buttons, true, "Boolean") then
    send_route()
    ctl.Boolean = false
  end
end

for _, ctl in ipairs(Controls.TX_Buttons) do
  ctl.EventHandler = function()
    Utilities.exclude(ctl, Controls.TX_Buttons)
    if ctl.Boolean and table.contains(Controls.RX_Buttons, true, "Boolean") then
      send_route()
    end
  end
end

for _, ctl in ipairs(Controls.RX_Buttons) do
  ctl.EventHandler = function()
    if ctl.Boolean and table.contains(Controls.TX_Buttons, true, "Boolean") then
      send_route()
    end
  end
end

for index, ctl in ipairs(Controls.Serial_Buttons) do
  ctl.EventHandler = function()
    send_serial(ctl, index)
  end
  
end


Controls.Prompt_Retrun.EventHandler = send_custom
