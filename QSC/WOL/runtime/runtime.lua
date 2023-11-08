--This is the length of time the socket will stay open
TimeInSeconds = 3
--Declare the udp socket
UDP = UdpSocket.New()

function GetLan()
  for _, v in pairs(Network.Interfaces()) do
    if v.Interface == Properties.LAN then
      return v.Address
    end
  end
end

function GetMac()
  -- Function to change canonical mac address to bytes
  local mac = Controls.MacAddress.String:gsub("%X", "")  -- remove non hex chars
  if #mac ~= 12 then error("Invalid Mac Address") end    --raise error if mac not correct length
  return Controls.MacAddress.String:gsub("%x%x", function(match) return string.char(tonumber(match, 16)) end)
end

function CreatePacket()
  local header = string.char(0xff):rep(6)  --builds header of 6 hexbytes of FF
  local body = ''

  for i = 1, 16 do body = body .. GetMac() end  --builds body of 16 iterations of the mac

  return header .. body
end

Controls.WOL.EventHandler = function(ctl)
  if ctl.Boolean then
    UDP:Open(GetLan())                                            --Binds UDP to the NIC to Send
    UDP:Send("255.255.255.255", Properties.PORT, CreatePacket())  --Sends the Packet that was built to the specified port
    Timer.CallAfter(
      function()                                                  --internal function timer for a delay
        UDP:Close()                                               --Closes the UDP socket
        collectgarbage()                                          --Minor maintenance nice to clean up your workspace
      end,
      TimeInSeconds
    )
  end
end
