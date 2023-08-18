----------------------------------------------------------------
-- Panel Change
----------------------------------------------------------------
Controls.panelSelection.EventHandler = function(ctl)
  if isDynamic(ctl.String) then
    Controls.uciSelection.Choices = Ucis(ctl.String).Choices
    Controls.uciSelection.String = Ucis(ctl.String).String
  else
    Controls.uciSelection.String = "UCI is Static."
  end

  updatePageLabels()
  updateStatusDevice()
end


----------------------------------------------------------------
-- UCI Change
----------------------------------------------------------------
Controls.uciSelection.EventHandler = function(ctl)
  Ucis(Controls.panelSelection.String).String = ctl.String
  updatePageLabels()
end

----------------------------------------------------------------
-- Page Change Using Dropdown
----------------------------------------------------------------
Controls.pageSelection.EventHandler = function(ctl)
  Pages(Controls.panelSelection.String).String = ctl.String
  update_page_buttons(ctl.String)
end

----------------------------------------------------------------
-- Page Change Using Buttons
----------------------------------------------------------------
for index, ctl in pairs(Controls.pageButton) do
  ctl.EventHandler = function()
    set_page(Controls.pageLabel[index].String)
  end
end

----------------------------------------------------------------
-- Pin Number Controls
----------------------------------------------------------------
for index, ctl in pairs(Controls.numPad) do
  ctl.EventHandler = function()
    output_pin(ctl, index)      --Show the pin number using *
  end
end

Controls.clear.EventHandler = clear_pin
Controls.enter.EventHandler = enter_pin
Controls.back.EventHandler = backspace_pin


----------------------------------------------------------------
-- Update User Pins
----------------------------------------------------------------
for index = 1, Properties["Defined Pass Codes"].Value do
  for _, ctl in pairs { Controls.pinCode, Controls.pinEnable, Controls.pinLandingPage } do
    ctl[index].EventHandler = function()
      update_pins(index)
    end
  end
end

--
-- Add exclusivity
--
MakeExclusive(Controls.pageButton)
