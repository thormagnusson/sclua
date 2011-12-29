local osc = require("osc")

Server = {}
Server.__index = Server

function Server:new(IP, port)
   local srv = {}
   setmetatable(srv, Server)
	IP = IP or '127.0.0.1'
	port = port or 57110
   local nodeID = 1000
   srv.IP = IP
   srv.port = port
   srv.nodeID = nodeID
   oscout = osc.Send(srv.IP, srv.port)
   return srv
end

function Server:nextNodeID()
	self.nodeID = self.nodeID + 1
	print("SERVER CLASS : nextNodeID", self.nodeID)
	return self.nodeID
end

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


--
--function Account:withdraw(amount)
--   self.balance = self.balance - amount
--end
--
--function Account:printT()
--   print(self.balance)
--end
--
---- create and use an Account
--acc = Account.create(1000)
--acc:withdraw(100)
--acc:printT()
--acc:withdraw(100)
--acc:printT()
