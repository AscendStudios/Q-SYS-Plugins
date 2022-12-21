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
