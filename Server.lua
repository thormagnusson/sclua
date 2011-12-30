local osc = require("osc")

Server = {}
Server.__index = Server

function Server:new(IP, port)
   local srv = {}
   setmetatable(srv, Server)
	IP = IP or '127.0.0.1'
	port = port or 57110
   --local nodeID = 1000
   --bufnum = -1
   srv.IP = IP
   srv.port = port
   --srv.nodeID = nodeID
   oscout = osc.Send(srv.IP, srv.port)
   -- oscin  = osc.Recv(57180) -- I need a two directional OSC port
   return srv
end

--function Server:nextNodeID()
--	self.nodeID = self.nodeID + 1
--	print("SERVER CLASS : nextNodeID", self.nodeID)
--	return self.nodeID
--end


function Server:dumpOSC(mode)
	print("SERVER CLASS: freeing all")
--	0 - turn dumping OFF.
--	1 - print the parsed contents of the message.
--	2 - print the contents in hexadecimal.
--	3 - print both the parsed and hexadecimal representations of the contents.	

	oscout:send('/dumpOSC', mode)
end

function Server:freeAll()
	print("SERVER CLASS: freeing all")
	oscout:send('/g_freeAll', 0)
	oscout:send("/g_new", 1, 0, 0)
	--oscout:send('/clearSched')
end

function Server:sendMsg(...)
	print("SERVER - sending this OSC:", ...)
	oscout:send(...)
end

function Server:notify(arg)
	print("SERVER - notification", arg)
	oscout:send('/notify', arg)
end

function Server:status()
	print("SERVER - notification", arg)
	oscout:send('/status', arg)
end

--function get_osc()
--	for msg in oscin:recv() do	
--		print(msg.addr, msg.types, unpack(msg))
--		-- add message handling here
--	end
--end
--
--go(function()
--	while(true) do
--		get_osc()
--		wait(1/40)
--	end
--end)





