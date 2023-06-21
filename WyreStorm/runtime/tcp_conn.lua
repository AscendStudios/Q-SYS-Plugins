local conn = TcpSocket.New()

conn.ReadTimeout = 0
conn.WriteTimeout = 0
conn.ReconnectTimeout = 5

local function connect_to_sock(ip, port)  -- Tries to connect the socket, but checks to see if IP or port are blank
  if ip ~= '' and port ~= '' then
    conn:Connect(ip, tonumber(port))
  elseif ip == '' then
    print("Please input an IP address")
  elseif port == '' then
    print("Please input a port number")
  else
    print("No sock info found")  -- Should never happen
  end
end

local connection_init =
    function()  -- initializes connection and runs the connect_to_sock function
      if Controls.Connect.Boolean then
        Controls.Connect.Legend = "Close Connection"
        print("\nOpening a connection...")
        connect_to_sock(NHD_CTL.ip(), NHD_CTL.port)
        Controls.ConnectionState.String = "Initializing - Connection..."
      else
        Controls.Connect.Legend = "Open Connection"
        print("\nClosing connection...")
        conn:Disconnect()
        Controls.ConnectionState.String = "Not Present - Closed by user"
        Controls.ConnectionState.Color = 'Gray'
      end
    end

-- Setup Utility Callbacks as required
conn.Connected = function(_conn)
  print("Connected")
  Controls.ConnectionState.String = "OK - Connected"
  Controls.ConnectionState.Color = "Green"
  Controls["Online"].Boolean = true
end
conn.Reconnect = function(_conn)
  Controls.ConnectionState.String = "Initializing - Reconnecting"
  Controls.ConnectionState.Color = "Blue"
  Controls["Online"].Boolean = false
end
conn.Closed = function(_conn)
  Controls.ConnectionState.String = "Fault - Closed by the remote end"
  Controls.ConnectionState.Color = "Orange"
  Controls["Online"].Boolean = false
end
conn.Error = function(_conn, err)
  Controls.ConnectionState.String = "Fault - Error :: " .. err
  Controls.ConnectionState.Color = "Red"
  Controls["Online"].Boolean = false
end
conn.Timeout = function(_conn, err)
  Controls.ConnectionState.String = "Fault - Timeout :: " .. err
  Controls.ConnectionState.Color = "Orange"
  Controls["Online"].Boolean = false
end

-- Data Handling --
local function get_device_index(device_id)
  local tx, tx_index = table.contains(Controls.TX_Labels, device_id, "String")
  local rx, rx_index = table.contains(Controls.RX_Labels, device_id, "String")
  local ctl
  if tx then ctl = "tx" elseif rx then ctl = "rx" end
  return ctl, tx_index or rx_index
end

local function handle_device_status(data_message)
  local message = data_message:match("notify endpoint %p %g*")
  if message then
    local symbol, index = message:match("%p"), message:find("%p")
    local devices = string.split(message:sub(index - #message))
    for device in devices do
      local ctl, device_index = get_device_index(device)
      if ctl == "tx" then
        ctl = Controls.TX_Status[device_index]
      elseif ctl == "rx" then
        ctl = Controls.RX_Status[device_index]
      end
      if symbol == "+" and ctl then
        ctl.Boolean = true; ctl.Color = "Chartreuse"
      elseif symbol == "-" and ctl then
        ctl.Boolean = false; ctl.Color = "Red"
      else
        logConsole("Symbol or Device Unkown: ")
        logConsole(string.format("Symbol: %s, Device: %s", symbol, device))
      end
    end
  end
end

conn.Data = function()
  local message_line = conn:ReadLine(TcpSocket.EOL.Any)
  local message_body = ''
  while (message_line ~= nil) do  -- While there is data, append each line to message body
    handle_device_status(message_line)
    message_body = message_body .. '\n' .. message_line
    message_line = conn:ReadLine(TcpSocket.EOL.Any)
  end
  logConsole(message_body)
  return message_body
end
