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
  for i, v in pairs(ArrayOfCtrls) do
    local oldEH = v.EventHandler or function() end
    v.EventHandler = function()
      for x, y in pairs(ArrayOfCtrls) do
        y.Boolean = x == i
      end
      oldEH()
    end
  end
end

------------------------------------------
-- RUNTIME GLOBALS
------------------------------------------
--[[ #include "Plugin_Components/Runtime/globals.lua" ]]
------------------------------------------
-- FUNCTIONS
------------------------------------------
--[[ #include "Plugin_Components/Runtime/funcs.lua" ]]
-----------------------------------------------------------------------------
-- EVENTHANDLERS
-----------------------------------------------------------------------------
--[[ #include "Plugin_Components/Runtime/events.lua" ]]

--------------------------------------------------------------------
-- INIT
--------------------------------------------------------------------
-- Set the Panel List

local function init()
  Controls.panelSelection.Choices = panel_list()

  if #panel_list() == 0 then
    Controls.panelStatus.String =
    "Fault No Panels Found!\nDebug for more info"
    error(
      "There must be at least be 1 control device in your design with the Script Access property enabled or if you're using LTS or earlier, make sure that you name the device's status block.",
      1)
  end

  -- Set a default Panel Selection
  if Controls.panelSelection.String == '' then Controls.panelSelection.String = Controls.panelSelection.Choices[1] end

  -- Set Page List
  Controls.pageSelection.Choices = Pages(Controls.panelSelection.String).Choices

  -- Set Current Page
  Controls.pageSelection.String = Pages(Controls.panelSelection.String).String

  -- Set Page labels for Page buttons and pin labels
  updatePageLabels()

  if isDynamic(Controls.panelSelection.String) then
    Controls.uciSelection.Choices = Ucis(Controls.panelSelection.String).Choices
    Controls.uciSelection.String = Ucis(Controls.panelSelection.String).String
  else
    Controls.uciSelection.String = "UCI is Static."
  end


  updateStatusDevice()
end

init()
