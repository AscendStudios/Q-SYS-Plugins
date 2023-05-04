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

local function build_tables()
  for i = 1, output_count do
    table.insert(Controls.RX_Buttons, Controls["RX_Btn_" .. i])
    table.insert(Controls.RX_Labels, Controls["RX_label_" .. i])
  end

  for i = 1, input_count do
    table.insert(Controls.TX_Buttons, Controls["TX_Btn_" .. i])
    table.insert(Controls.TX_Labels, Controls["TX_label_" .. i])
  end

  for i = 1, serial_count do
    table.insert(Controls.Serial_Buttons, Controls["Serial_Btn_" .. i])
    table.insert(Controls.Serial_Commands, Controls["Serial_Str_" .. i])
  end
end

build_tables()
