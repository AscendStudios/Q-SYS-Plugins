---------------------------------------------------------------------------
-- PANELS
---------------------------------------------------------------------------
local function panel_list()
    local list = {}
    for _, component in ipairs(Component.GetComponents()) do
        if table.contains(inventory.controlDevices, component.Type) then
            table.insert(list, component.Name)
        end
    end
    return list
end

local function isReadOnly(attribute)
    --attribute should be a table for the component control
    return attribute.Direction == "Read Only"
end

local function isDynamic(panel)
    for _, t in pairs(Component.GetControls(panel)) do
        if table.contains(t, "current.uci") then
            return not isReadOnly(t)  -- t is the attribute table that contains the current.uci control.
        end
    end
end

local function Pages(panel)
    return Component.New(panel)["current.page"]
end

local function Ucis(panel)
    return Component.New(panel)["current.uci"]
end

local function Status(panel)
    return Component.New(panel)["status"]
end

local function updateStatusDevice()
    if PANEL_STATUS ~= nil then PANEL_STATUS.EventHandler = function() end end
    PANEL_STATUS = Status(Controls.panelSelection.String)
    PANEL_STATUS.EventHandler = function(ctl)
        Controls.panelStatus.String = ctl.String
    end
    Controls.panelStatus.String = PANEL_STATUS.String
end

local function update_page_buttons(selection)
    for index, label in ipairs(Controls.pageLabel) do
        if label.String == selection then
            Controls.pageButton[index].Boolean = true
        else
            Controls.pageButton[index].Boolean = false
        end
    end
end

local function set_page(page_name)
    if table.contains(Controls.pageSelection.Choices, page_name) then
        Controls.pageSelection.String = page_name                 --Update the plugin dropdown
        Pages(Controls.panelSelection.String).String = page_name  --Update the actual panel
    else
        Controls.pinDisplay.String = "Error PNF"
        Timer.CallAfter(function()
                            PIN = ''; Controls.pinDisplay.String = ''
                        end, 2)
        Log.Error(string.format(
            "PAGE LOADING ERROR: \t Page: %s is not found on Panel: %s",
            page_name,
            Controls.panelSelection.String))
    end
end

---------------------------------------------------------------------------
-- PIN LOGIC
---------------------------------------------------------------------------
local function output_pin(ctl, num)
    if num == 10 then num = 0 end
    if ctl.Boolean then
        PIN = PIN .. num
        Controls.pinDisplay.String = string.rep("*", #PIN)
    end
end

local function clear_pin(ctl)
    if ctl.Boolean then
        PIN = ''; Controls.pinDisplay.String = ''
    end
end

local function backspace_pin(ctl)
    if ctl.Boolean then
        PIN = PIN:sub(1, #PIN - 1)
        Controls.pinDisplay.String = string.rep("*", #PIN)
    end
end

local function enter_pin(ctl)
    local function incorrect()
        Controls.pinDisplay.String = 'INCORRECT'; Timer.CallAfter(
            function()
                Controls.pinDisplay.String = ''; PIN = ''
            end,
            2
        )
    end

    local function correct()
        local p = Controls.pinSuccess
        p.Boolean = true; p.Color = "green"
        Timer.CallAfter(
            function()
                p.Boolean = false; p.Color = "#FF7C0000"
            end,
            1
        )
    end

    local pseudo_ctl = { Boolean = true }

    if ctl.Boolean then
        for name, code in pairs(CODES) do
            if name == "Admin" and code.enabled then
                if PIN == code.pin then
                    Log.Message("Admin Logged In")
                    set_page(Controls.adminLandingPage.String)
                    clear_pin(pseudo_ctl)
                    correct()
                    return
                end
            else
                if PIN == code.pin and code.enabled then
                    Log.Message(string.format("User: %d Logged In", name))
                    set_page(Controls.pinLandingPage[name].String)
                    clear_pin(pseudo_ctl)
                    correct()
                    return
                end
            end
        end
        incorrect()
    end
end


local function update_pins(index)
    CODES[index].pin = Controls.pinCode[index].String
    CODES[index].enabled = Controls.pinEnable[index].Boolean
    CODES[index].page = Controls.pinLandingPage[index].String
end

local function get_landing_pages()
    local pages = Pages(Controls.panelSelection.String).Choices

    -- Set the choices for the pin landing pages
    Controls.adminLandingPage.Choices = pages
    for _, ctl in pairs(Controls.pinLandingPage) do
        ctl.Choices = pages
    end
end

local function get_filter_labels()
    local pages = Pages(Controls.panelSelection.String).Choices
    for _, ctl in pairs(Controls.filterList) do
        ctl.Choices = pages
    end
end

---------------------------------------------------------------------------
-- Update Pages and Labels
---------------------------------------------------------------------------
local function filter_page_labels(choices)
    local filtered_list = {}
    for index, name in pairs(Controls.filterList) do
        local found, idx = table.contains(choices, name.String)
        if found and Controls.filterEnable[index].Boolean then
            table.remove(choices, idx)
        end
    end
    return choices
end

local function updatePageLabels()
    local pages = Pages(Controls.panelSelection.String)
    local filtered_choices = filter_page_labels(pages.Choices)
    -- Create the lables for the filters.
    get_filter_labels()
    --Panels
    Controls.pageSelection.Choices = filtered_choices
    Controls.pageSelection.String = pages.String
    -- Update Page Button Labels
    for _, label in pairs(Controls.pageLabel) do
        label.Choices = pages.Choices
    end
    --Pins
    get_landing_pages()
end
