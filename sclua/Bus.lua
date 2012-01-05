local funcs = require("sclua.funcs")

local Bus = {}
Bus.__index = Bus

function Bus:new()
   local bs = {}
   setmetatable(bs, Bus)
   bs.busIndex = nextBusIndex()
   return bs
end

function Bus:set(value)
	s:sendMsg('/c_set', self.busIndex, value)
end

-- Untested
function Bus:setn(nrofbusses, values)
	s:sendMsg('/c_setn', self.busIndex, nrofbusses, values)
end

function Bus:fill(nrofbusses, value)
	s:sendMsg('/c_fill', self.busIndex, nrofbusses, value)
end

function Bus:get()
	s:sendMsg('/c_get', self.busIndex)
end

function Bus:getn(index, nrofbusses)
	s:sendMsg('/c_getn', self.busIndex, nrofbusses)
end

function Bus:index()
	return self.busIndex
end

return Bus