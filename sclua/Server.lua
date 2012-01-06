local osc = require("osc")
local funcs = require("sclua.funcs")

local Server = {}
Server.__index = Server

Server.Synth = require("sclua.Synth")
Server.Buffer = require("sclua.Buffer")
Server.Group = require('sclua.Group')
Server.Bus = require('sclua.Bus')

function Server:new(IP, port)
	local srv = {}
	setmetatable(srv, Server)
	IP = IP or '127.0.0.1'
	port = port or 57110
	srv.IP = IP
	srv.port = port
	oscout = osc.Send(srv.IP, srv.port)
	-- oscin  = osc.Recv(57180) -- I need a two directional OSC port
   return srv
end

function Server:dumpOSC(mode)
-- 	I think this is buggy on the SC Server side (maybe not in 3.5)
--	0 - turn dumping OFF.
--	1 - print the parsed contents of the message.
--	2 - print the contents in hexadecimal.
--	3 - print both the parsed and hexadecimal representations of the contents.	
	oscout:send('/dumpOSC', mode)
end

function Server:boot()
	-- this is not working - I think it is because it searches for synthdefs in 
	-- the App Support/Extensions folder, not the synthdef folder next to the server
	--os.execute("/Applications/SuperCollider3.4.4/scsynth -u 57110 -b 1026 -R 0 &") 
	--os.execute("cd /Applications/SuperCollider3.4.4/ && ./scsynth -u 57110 -R 0 &") -- works
	os.execute("cd /Applications/LuaAV.12.12.11/ && ./scsynth -u 57110 -R 0 &") -- works
	oscout:send('/d_loadDir', "/Applications/LuaAV.12.12.11/synthdefs")

end

--os.execute("cd /Applications/SuperCollider/ && ./scsynth -u 57117 -R 0 &")


function Server:freeAll()
	oscout:send('/g_freeAll', 0)
	oscout:send('/clearSched')
	oscout:send("/g_new", 1, 0, 0)
end

function Server:sendMsg(...)
	oscout:send(...)
end

function Server:notify(arg)
	oscout:send('/notify', arg)
end

function Server:status()
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

return Server