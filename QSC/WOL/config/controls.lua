table.insert(ctrls, {
  Name = "WOL",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
  Icon = "Power"
})

table.insert(ctrls, {
  Name = "MacAddress",
  ControlType = "Text",
  Count = 1,
  UserPin = false
})
