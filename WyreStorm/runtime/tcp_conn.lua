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
conn.Data = function()
  local message_line = conn:ReadLine(TcpSocket.EOL.Any)
  local message_body = ''
  while (message_line ~= nil) do  -- While there is data, append each line to message body
    message_body = message_body .. '\n' .. message_line
    message_line = conn:ReadLine(TcpSocket.EOL.Any)
  end
  logConsole(message_body)
  return message_body
end
