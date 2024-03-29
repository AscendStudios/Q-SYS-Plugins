local input_count = Properties["Transmitters"].Value
local output_count = Properties["Receivers"].Value
local serial_count = Properties["Serial Commands"].Value

local NHD_CTL = {
  ip = function() return Controls.IpAddress.String end,
  port = Properties["Port"].Value
}

-- Build Button And Label Tables
Controls.TX_Buttons, Controls.RX_Buttons = {}, {}
Controls.TX_Labels, Controls.RX_Labels = {}, {}
Controls.Serial_Commands, Controls.Serial_Buttons = {}, {}
Controls.USB_TX_Buttons, Controls.USB_RX_Buttons = {}, {}
Controls.TX_Status, Controls.RX_Status = {}, {}

local function build_tables()
  --[[ Video Button Control Tables ]]
  for i = 1, output_count do
    table.insert(Controls.RX_Buttons, Controls["RX_Btn_" .. i])
    table.insert(Controls.RX_Labels, Controls["RX_label_" .. i])
    table.insert(Controls.RX_Status, Controls["RX_Status_" .. i])
  end

  for i = 1, input_count do
    table.insert(Controls.TX_Buttons, Controls["TX_Btn_" .. i])
    table.insert(Controls.TX_Labels, Controls["TX_label_" .. i])
    table.insert(Controls.TX_Status, Controls["TX_Status_" .. i])
  end

  --[[ Serial Button Control Tables ]]
  for i = 1, serial_count do
    table.insert(Controls.Serial_Buttons, Controls["Serial_Btn_" .. i])
    table.insert(Controls.Serial_Commands, Controls["Serial_Str_" .. i])
  end

--[[ USB Button Control Tables ]]
--Labels are mirrored from the video routing control table. This keeps them synchronized.
  for i = 1, output_count do
    table.insert(Controls.USB_RX_Buttons, Controls["USB_Btn_RX_" .. i])
  end

  for i = 1, input_count do
    table.insert(Controls.USB_TX_Buttons, Controls["USB_Btn_TX_" .. i])
  end
end

build_tables()
