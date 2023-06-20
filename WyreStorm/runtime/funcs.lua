local function send_route()
  -- Controls table (ie Controls.TX_Buttons) defined in the runtime/globals.lua script
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
    print("Not Connected")
    return
  end
end

local function route_usb()
  -- Controls table (ie Controls.USB_TX_Buttons) defined in the runtime/globals.lua script
  if conn.IsConnected then
    local _, input_index = table.contains(Controls.USB_TX_Buttons, true, "Boolean")
    local input_device = Controls.TX_Labels[input_index]
    local output_device
    -- Send to each output
    local command = "matrix usb set ".. input_device.String
    for index, ctl in pairs(Controls.USB_RX_Buttons) do
      if ctl.Boolean then
        command = string.format("%s %s", command, Controls.RX_Labels[index].String )
        ctl.Boolean = false
      end
    end
    -- send TCP command
    conn:Write(command .. " \r\n")
    Controls.TX_Buttons[input_index].Boolean = false
  else
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
