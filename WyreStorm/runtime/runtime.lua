--[[ #include "modules\Utilities\init.lua" ]]
--[[ #include "modules\Table\init.lua" ]]
--[[ #include "modules\String\init.lua" ]]
local function clear_console() Controls.Console.String = '' end


local function logConsole(new_txt)
    local old_txt = Controls.Console.String
    local console_list = string.split(old_txt, '\n')

    if #console_list > 25 then
        clear_console()
        old_txt = Controls.Console.String
    end

    old_txt = string.gsub(old_txt, '-----\n', '')
    old_txt = string.gsub(old_txt, '\n\n', '\n')
    Controls.Console.String = old_txt .. '\n-----\n' .. os.date('%H:%M:%S ') .. new_txt
end

--[[ #include "runtime\globals.lua"]]
--[[ #include "runtime\tcp_conn.lua"]]
--[[ #include "runtime\funcs.lua"]]
-- EVENTHANDLERS --
--[[ #include "runtime\events.lua"]]
--INIT

if Properties["Enable Dev"].Value then
    Controls.IpAddress.String = "127.00.00.01"  -- If dev mode; set the IP to use local host.
end

--sync connection status to the button state
connection_init()
