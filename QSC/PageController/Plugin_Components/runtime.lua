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

--[[ #include "Modules/advanced_tables.lua" ]]

function MakeExclusive(ArrayOfCtrls)
    for i , v in pairs(ArrayOfCtrls) do
      local oldEH = v.EventHandler or function() end
      v.EventHandler = function()
        for x,y in pairs(ArrayOfCtrls) do
          y.Boolean = x == i
        end
        oldEH()
      end
    end
end

------------------------------------------
-- GLOBALS
------------------------------------------
local PIN = ''
local CODES = {["Admin"] = {
    pin = Properties["Admin Pin"].Value,
    page = Controls.adminLandingPage.String,
    enabled = Properties["Admin Pin"].Value ~= '',
} }
-- Add in the custom pin codes to the codes table
for i=1, Properties["Defined Pass Codes"].Value do
    CODES[i] = {
        pin = Controls.pinCode[i].String,
        page = Controls.pinLandingPage[i].String,
        enabled = Controls.pinEnable[i].Boolean
    }
    
end

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

local function Ucis(panel)
    return Component.New(panel)["current.uci"]
end

local function set_page(page_name)
    if table.contains(Controls.pageSelection.Choices, page_name) then
        Controls.pageSelection.String = page_name           --Update the plugin dropdown
        Pages(Controls.panelSelection.String).String = page_name   --Update the actual panel
    else
        Controls.pinDisplay.String = "Error PNF"
        Timer.CallAfter( function() PIN = ''; Controls.pinDisplay.String = '' end, 2)
        Log.Error(string.format(
            "PAGE LOADING ERROR: \t Page: %s is not found on Panel: %s",
            page_name,
            Controls.panelSelection.String))
    end
end

local function clear_pin( ctl )
    if ctl.Boolean then
        PIN = ''; Controls.pinDisplay.String = ''
    end
end

local function output_pin( ctl, num )
    if num == 10 then num = 0 end
    if ctl.Boolean then
        PIN = PIN..num
        Controls.pinDisplay.String = string.rep("*", #PIN)
    end
end



local function enter_pin( ctl )

    local function incorrect()
        Controls.pinDisplay.String = 'INCORRECT'; Timer.CallAfter(
            function() Controls.pinDisplay.String = ''; PIN = '' end,
            2
        )
    end

    local pseudo_ctl = {Boolean = true}

    if ctl.Boolean then

        for name, code in pairs(CODES) do
            if name == "Admin" and code.enabled then
                if PIN == code.pin then
                    Log.Message("Admin Logged In")
                    set_page(Controls.adminLandingPage.String)
                    clear_pin(pseudo_ctl)
                    return
                end
            else
                if PIN == code.pin and code.enabled then
                    Log.Message(string.format("User: %d Logged In", name))
                    set_page( Controls.pinLandingPage[name].String)
                    clear_pin(pseudo_ctl)
                    return
                end
            end
        end
        incorrect()
    end
end

local function backspace_pin( ctl )
    if ctl.Boolean then
        PIN = PIN:sub(1, #PIN -1)
        Controls.pinDisplay.String = PIN
    end

end

local function update_pins(index)
    CODES[index].pin = Controls.pinCode[index].String
    CODES[index].enabled = Controls.pinEnable[index].Boolean
    CODES[index].page = Controls.pinLandingPage[index].String
end

local function get_landing_pages()
    local pages = Pages(Controls.panelSelection.String).Choices

    Controls.adminLandingPage.Choices = pages

    for _, ctl in pairs(Controls.pinLandingPage) do
        ctl.Choices = pages
    end
end

local function updatePageLabels()
    local pages = Pages(Controls.panelSelection.String).Choices
    --Panels
    Controls.pageSelection.Choices = pages
    for _, label in pairs(Controls.pageLabel) do
        label.Choices = pages
    end
    --Pins
    get_landing_pages()
end

-----------------------------------------------------------------------------
-- EVENTHANDLERS
-----------------------------------------------------------------------------
-- Panel Controls
Controls.panelSelection.EventHandler = function( ctl )
    if isDynamic(ctl.String) then
        Controls.uciSelection.Choices = Ucis(ctl.String).Choices
        Controls.uciSelection.String = Ucis(ctl.String).String
    else 
        ctl.String = "UCI is Static."
    end

    updatePageLabels()
    
end

Controls.uciSelection.EventHandler = function( ctl )
    Ucis(Controls.panelSelection.String).String = ctl.String
    updatePageLabels()
end

Controls.pageSelection.EventHandler = function( ctl )
    Pages(Controls.panelSelection.String).String = ctl.String
end

-- Page Button Control Logic

for index, ctl in pairs(Controls.pageButton) do
    ctl.EventHandler = function()
        set_page(Controls.pageLabel[index].String)
    end
end


-- Pin Number Controls
for index, ctl in pairs(Controls.numPad) do
    ctl.EventHandler = function()
        output_pin( ctl, index )  --Show the pin number using *
    end
end

Controls.clear.EventHandler = clear_pin
Controls.enter.EventHandler = enter_pin
Controls.back.EventHandler = backspace_pin


-- Update Pins
for index=1, Properties["Defined Pass Codes"].Value do
    for _, ctl in pairs{Controls.pinCode, Controls.pinEnable, Controls.pinLandingPage} do
        ctl[index].EventHandler = function()
            update_pins(index)
        end
    end
end



--
-- Add exclusivity
--

MakeExclusive(Controls.pageButton)

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

if isDynamic(Controls.panelSelection.String) then
    Controls.uciSelection.Choices = Ucis(Controls.panelSelection.String).Choices
    Controls.uciSelection.String = Ucis(Controls.panelSelection.String).String
else
    Controls.uciSelection.String = "UCI is Static."
end
