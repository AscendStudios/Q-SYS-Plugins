local function send_route()
  if conn.IsConnected then
    local _, input_index = table.contains(Controls.TX_Buttons, true, "Boolean")
    local input_device = Controls.TX_Labels[input_index]
    local output_device
    -- Send to each output
    for index, ctl in pairs(Controls.RX_Buttons) do
      if ctl.Boolean then
        output_device = Controls.RX_Labels[index]
        -- send TCP command
        conn:Write("matrix set " .. input_device.String .. " " .. output_device.String .. " \r\n")
        ctl.Boolean = false
      end
    end
    Controls.TX_Buttons[input_index].Boolean = false
  else
    -- TODO: Show the user this.
    print("Not Connected")
    return
  end
end

local function send_serial(_ctl, _i)
  local bool = table.contains(Controls.RX_Buttons, true, "Boolean")
  if _ctl.Boolean and bool then
    -- TODO: Add baud; bits, parity, cr, lf, hex
    for index, ctl in pairs(Controls.RX_Buttons) do
      if ctl.Boolean then
        conn:Write("serial " .. Controls.Serial_Commands[_i].String .. ' ' .. Controls.RX_Labels[index].String, "\r\n")
      end
    end
  end
end

local function send_custom(ctl)
  if ctl.Boolean then
    conn:Write(Controls.Prompt.String .. "\r\n")
    logConsole(Controls.Prompt.String)
  end
end
