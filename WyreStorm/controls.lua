local ctrls = {
  -- System Config --
  {
    Name = "IpAddress",
    ControlType = "Text",
    Count = 1,
    PinStyle = "Both",
    UserPin = true
  },
  {
    Name = "Connect",
    ControlType = "Button",
    ButtonType = "Toggle",
    PinStyle = "Both",
    UserPin = true
  },
  {
    Name = "Online",
    ControlType = "Indicator",
    IndicatorType = "Led",
    PinStyle = "Output",
    Count = 1,
    UserPin = true
  },
  {
    Name = "ConnectionState",
    ControlType = "Indicator",
    IndicatorType = "Status",
    PinStyle = "Output",
    UserPin = true
  },
  {
    Name = "Console",
    ControlType = "Indicator",
    IndicatorType = "Text",
  },
  {
    Name = "Prompt",
    ControlType = "Text",
  },
  {
    Name = "Prompt_Retrun",
    ControlType = "Button",
    ButtonType = "Momentary"
  }
}

-- Controls --

for i = 1, props.Transmitters.Value do
  --[[ VIDEO ROUTING CONTROLS ]]
  --
  table.insert(ctrls,
               {
                 Name = "TX_Btn_" .. i,
                 ControlType = "Button",
                 ButtonType = "Toggle",
                 PinStyle = "Both",
                 UserPin = true
               })
  table.insert(ctrls,
               {
                 Name = "TX_label_" .. i,
                 ControlType = "Text",
                 PinStyle = "Input",
                 UserPin = true
               })
  --[[ SERIAL ROUTING CONTROLS ]]
  --
  table.insert(ctrls,
               {
                 Name = "Serial_Btn_" .. i,
                 ControlType = "Button",
                 ButtonType = "Momentary",
                 PinStyle = "Both",
                 UserPin = true
               })
  table.insert(ctrls,
               {
                 Name = "Serial_Str_" .. i,
                 ControlType = "Text",
                 PinStyle = "Input",
                 UserPin = true
               })
  --[[ USB ROUTING CONTROLS ]]
  --
  table.insert(ctrls,
               {
                 Name = "USB_Btn_TX_" .. i,
                 ControlType = "Button",
                 ButtonType = "Toggle",
                 PinStyle = "Both",
                 UserPin = true
               })
  --[[ STATUS LEDS ]]
  --
  table.insert(ctrls,
               {
                 Name = "TX_Status_" .. i,
                 ControlType = "Indicator",
                 ButtonType = "Led",
                 PinStyle = "Both",
                 UserPin = true
               })
end

for i = 1, props.Receivers.Value do
  --[[ VIDEO ROUTING CONTROLS ]]
  --
  table.insert(ctrls,
               {
                 Name = "RX_Btn_" .. i,
                 ControlType = "Button",
                 ButtonType = "Toggle",
                 PinStyle = "Both",
                 UserPin = true
               })

  table.insert(ctrls,
               {
                 Name = "RX_label_" .. i,
                 ControlType = "Text",
                 PinStyle = "Input",
                 UserPin = true
               })
  --[[ USB ROUTING CONTROLS ]]
  --
  table.insert(ctrls,
               {
                 Name = "USB_Btn_RX_" .. i,
                 ControlType = "Button",
                 ButtonType = "Toggle",
                 PinStyle = "Both",
                 UserPin = true
               })
  --[[ STATUS LEDS ]]
  --
  table.insert(ctrls,
               {
                 Name = "RX_Status_" .. i,
                 ControlType = "Indicator",
                 ButtonType = "Led",
                 PinStyle = "Both",
                 UserPin = true
               })
end

table.insert(ctrls,
             {
               Name = "RX_All",
               ControlType = "Button",
               ButtonType = "Toggle",
               PinStyle = "Both",
               UserPin = true
             })
return ctrls
