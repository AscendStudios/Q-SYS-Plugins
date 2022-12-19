--[[ LIST OF CONTROLS:

    "panelSelection",
    "pageSelection",
    "uciSelection",
    "pageButton",
    "pageLabel",
    "pinCode",
    pinLandingPage,
    adminLandingPage,
    "pinEnable",
    "numPad",
    "clear",
    "enter",
    "back",
    "pinDisplay"

]]

--[[ #include "advanced_tables.lua" ]]


------------------------------------------
-- GLOBALS
------------------------------------------
local PIN = ''
local CODES = {props["Admin Pin"]}
local inventory = {
    controlDevices = {  -- List of possible invetory items that might have a uci attached.
        "touch_screen_status",
        "uci_viewer",
    }
}

------------------------------------------
-- FUNCTIONS
------------------------------------------

-- PANELS
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

local function output_pin( ctl, num )
    if num == 10 then num = 0 end
    if ctl.Boolean then
        PIN = PIN..num
        Controls.pinDisplay.String = string.rep("*", #PIN)
    end
end

local function clear_pin( ctl )
    if ctl.Boolean then
        PIN = ''; Controls.pinDisplay.String = ''
    end
end

local function enter_pin( ctl )
    if ctl.Boolean then
        -- Check pin
        local bool = table.contains(CODES, PIN)
        if bool and PIN ~= props["Admin Pin"].String then
            local idx = table.contains(Controls.pinCode, PIN)
            Controls.pageSelection.String = Controls.pinPage[idx].String
        elseif PIN == props["Admin Pin"].String then
            Controls.pageSelection.String = Contols.adminPage.String
        else
            Controls.pinDisplay.String = 'INCORRECT'; Timer.CallAfter(
                function() Controls.pinDisplay = '' end,
                2
            )
        end
    end
end

local function add_pin_code(index)
    table.insert(CODES, Controls.pinCode[index])
end

local function remove_pin_code(index)
    local _, idx = table.contains(CODES, Controls.pinCode[index])
    if idx then table.remove(CODES, idx) end
end


for _, panel in pairs(panel_list()) do
    if not isDynamic(panel) then print(panel, "Is not configured to be dynamic.") end
    -- for _, ctl in pairs(Component.GetControls(panel)) do
    --     -- for name, val in pairs(ctl) do print(v, i, name,val) end
    --     print("\t", ctl.Name, ctl.Direction, ctl.Type)
    -- end
end

function UpdateLabels()
    for ctl in pairs(Controls) do
        if ctl:match("pageLabel_%d") then Controls[ctl].Choices = Pages(Controls.panelSelection.String).Choices end
    end
end

local function get_landing_pages()
    local pages = Pages(Controls.panelSelection.String)
    Controls.adminLandingPage.Choices = pages
    for _ ,ctl in pairs(Controls.pinLandingPage) do
        ctl.Choices = pages
    end 
end

-----------------------------------------------------------------------------
-- EVENTHANDLERS
-----------------------------------------------------------------------------
-- Panel Controls
Controls.panelSelection.EventHandler = function( ctl )
    Controls.pageSelection.Choices = Pages(Controls.panelSelection.String).Choices
    get_landing_pages()
    UpdateLabels()
end

Controls.pageSelection.EventHandler = function( ctl )
    Pages(Controls.panelSelection.String).String = ctl.String
end


-- Pin Number Controls
for index, ctl in pairs(Controls.numPad) do
    ctl.EventHandler = function()
        output_pin( ctl, index )
    end
end

Controls.clear.EventHandler = clear_pin

for index, ctl in pairs(Controls.pinCode) do
    ctl.EventHandler = function()
        if ctl.Boolean then
            add_pin_code(index)
        else
            remove_pin_code(index)
        end
    end
end


--------------------------------------------------------------------
-- INIT
--------------------------------------------------------------------
-- Set the Panel List
Controls.panelSelection.Choices = panel_list()

-- Set a default Panel Selection
if Controls.panelSelection.String == '' then Controls.panelSelection.String = Controls.panelSelection.Choices[1] end

-- Set Page List
Controls.pageSelection.Choices = Pages(Controls.panelSelection.String).Choices

-- Set Page list for pin code landing pages
get_landing_pages()
