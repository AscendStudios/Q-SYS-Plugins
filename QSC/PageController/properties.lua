local props = {
  {
      Name = "Debug Print",
      Type = "enum",
      Choices = {"None", "Tx/Rx", "Tx", "Rx", "Function Calls", "All"},
      Value = "None"
  },
  {
      Name = "Page Buttons",
      Type = "integer",
      Min = 0,
      Max = 1000,
      Value = 1,
  },
  {
      Name = "Defined Pass Codes",
      Type = "integer",
      Min = 0,
      Max = 100,
      Value = 1,
  },
  {
    Name = "Admin Pin",
    Type = "string",
  }
}
return props