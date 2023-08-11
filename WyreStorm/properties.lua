local props = {
    {
        Name = "Debug Print",
        Type = "enum",
        Choices = { "None", "Tx/Rx", "Tx", "Rx", "Function Calls", "All" },
        Value = "None"
    },
    {
        Name = "Enable Dev",
        Type = "boolean",
        Value = false
    },
    {
        Name = "Port",
        Type = "integer",
        Min = 0,
        Max = 65535,
        Value = 23,
    },
    {
        Name = "Transmitters",
        Type = "integer",
        Min = 1,
        Max = 100,
        Value = 8,
    },
    {
        Name = "Receivers",
        Type = "integer",
        Min = 1,
        Max = 100,
        Value = 8,
    },
    {
        Name = "Serial Commands",
        Type = "integer",
        Min = 0,
        Max = 25,
        Value = 2
    },

}
return props
