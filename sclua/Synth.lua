local funcs = require("sclua.funcs")

local Synth = {}
Synth.__index = Synth

function Synth:new(name, args)
   local snth = {}
   setmetatable(snth, Synth)
   local nodeID = funcs.nextNodeID()
   snth.nodeID = nodeID
   snth.name = name
   snth.args = funcs.parseArgsX(args)
   s:sendMsg('/s_new', snth.name, snth.nodeID, 0, 1, unpack(snth.args))
   return snth
end

--function Synth_metatable:__newindex(key, value)
--	self._server:sendMsg('/n_set', self.nodeID, key, value)
--end

function Synth:set(args)
	local args = funcs.parseArgsX(args)
	s:sendMsg('/n_set', self.nodeID, unpack(args) )
end

-- unpacking not working here it seems
function Synth:setn(controlNameNum, args)
	local nn = funcs.parseArgsX(controlNameNum)
	local args = funcs.parseArgsX(controlNameNum)
	for arg, val in pairs(args) do 
		table.insert(nn, arg)
		table.insert(nn, val)
	end
	s:sendMsg('/n_setn', self.nodeID, unpack(nn))
end

function Synth:above(aSynth)
	s:sendMsg('/n_before', self.nodeID, aSynth.nodeID )
end

function Synth:below(aSynth)
	s:sendMsg('/n_after', self.nodeID, aSynth.nodeID )
end

function Synth:moveToHead(aNode)
	s:sendMsg('/g_head', aNode.nodeID, self.nodeID )
end

function Synth:moveToTail(aNode)
	s:sendMsg('/g_tail', aNode.nodeID, self.nodeID )
end

function Synth:free()
	s:sendMsg('/n_free', self.nodeID )
end

function Synth:run(arg)
	s:sendMsg('/n_run', self.nodeID, arg)
end

function Synth:getNodeID()
	return self.nodeID
end

function Synth:map(name, aBus)
	s:sendMsg('/n_map', self.nodeID, name, aBus.busIndex )
end

-- REVIEW
--function Synth:map(args)
--	s:sendMsg('/n_map', self.nodeID, unpack(args) )
--end

function Synth:mapn(args) -- mapping from control bus
	s:sendMsg('/n_mapn', self.nodeID, unpack(args) )
end

function Synth:mapa(args) -- mapping from control bus
	s:sendMsg('/n_mapa', self.nodeID, unpack(args) )
end

return Synth
