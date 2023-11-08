table.insert(props, {
  Name = "Debug Print",
  Type = "enum",
  Choices = { "None", "Tx/Rx", "Tx", "Rx", "Function Calls", "All" },
  Value = "None"
})

table.insert(props, {
  Name = "LAN",
  Type = "enum",
  Choices = { "LAN A", "LAN B", "LAN C", "LAN D" },
  Value = "LAN A"
})

table.insert(props, {
  Name = "PORT",
  Type = "integer",
  Min = 1,
  Max = 65535,
  Value = 9
})
