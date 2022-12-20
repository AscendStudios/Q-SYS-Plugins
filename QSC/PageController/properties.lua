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
      Min = 2,
      Max = 1000,
      Value = 3,
  },
  {
      Name = "Defined Pass Codes",
      Type = "integer",
      Min = 2,
      Max = 100,
      Value = 4,
  },
  {
    Name = "Admin Pin",
    Type = "string",
  }
}
return props