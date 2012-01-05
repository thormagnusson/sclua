-- Global Functions

local funcs = {}
local bufnum = -1
local nodeID = 999
local groupID = 1
local busIndex = 15

function funcs.parseArgsX(args)
	local a = {}
	if args ~= nil then
		for arg, val in pairs(args) do 
			table.insert(a, arg)
			table.insert(a, val)
		end
	end
	return a
end

function funcs.nextBufNum()
	bufnum = bufnum + 1
	return bufnum
end

function funcs.nextNodeID()
	nodeID = nodeID + 1
	return nodeID
end

function funcs.nextGroupID()
	groupID = groupID + 1
	return groupID
end

function funcs.nextBusIndex()
	busIndex = busIndex + 1
	return busIndex
end

return funcs