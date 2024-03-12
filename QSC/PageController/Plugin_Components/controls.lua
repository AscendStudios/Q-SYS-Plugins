-- table.insert(ctrls, {
--   Name = "SendButton",
--   ControlType = "Button",
--   ButtonType = "Momentary",
--   Count = 1,
--   UserPin = true,
--   PinStyle = "Input",
--   Icon = "Power"
-- })

--------------------------------------------------------
-- Navigation
--------------------------------------------------------

for _, name in ipairs { "panelSelection", "pageSelection", "uciSelection" } do
    table.insert(ctrls, {
        Name = name,
        ControlType = "Text",
        UserPin = true,
        PinStyle = "Both",
    })
end


table.insert(ctrls, {
    Name = "pageButton",
    ControlType = "Button",
    ButtonType = "Toggle",
    Count = props["Page Buttons"].Value,
    PinStyle = "Both",
    UserPin = true
})

table.insert(ctrls, {
    Name = "pageLabel",
    ControlType = "Text",
    Count = props["Page Buttons"].Value
})

--------------------------------------------------------
-- Pin Code Controls
--------------------------------------------------------

table.insert(ctrls, {
    Name = "pinCode",
    ControlType = "Text",
    Count = props["Defined Pass Codes"].Value,
})

table.insert(ctrls, {
    Name = "pinEnable",
    ControlType = "Button",
    ButtonType = "Toggle",
    Count = props["Defined Pass Codes"].Value,

})

table.insert(ctrls, {
    Name = "adminLandingPage",
    ControlType = "Text",
})

table.insert(ctrls, {
    Name = "pinLandingPage",
    ControlType = "Text",
    Count = props["Defined Pass Codes"].Value
})

table.insert(ctrls, {
    Name = "numPad",
    ControlType = "Button",
    ButtonType = "Momentary",
    Count = 10
})


for _, name in ipairs({ "clear", "back", "enter" }) do
    table.insert(ctrls, {
        Name = name,
        ControlType = "Button",
        ButtonType = "Momentary",
    })
end

table.insert(ctrls, {
    Name = "pinDisplay",
    ControlType = "Text",
})

table.insert(ctrls, {
    Name = "panelStatus",
    ControlType = "Indicator",
    IndicatorType = "Status",
    PinStyle = "Output",
    UserPin = true
})

table.insert(ctrls, {
    Name = "pinSuccess",
    ControlType = "Indicator",
    IndicatorType = "Led",
    PinStyle = "Output",
    UserPin = true
})


-------
-- Filter Controls
-------

table.insert(ctrls, {
    Name = "filterList",
    ControlType = "Text",
    Count = props["Filtered Pages"].Value,
})

table.insert(ctrls, {
    Name = "filterEnable",
    ControlType = "Button",
    ButtonType = "Toggle",
    Count = props["Filtered Pages"].Value
})
