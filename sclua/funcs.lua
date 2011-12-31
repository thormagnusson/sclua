-- Global Functions

bufnum = -1
nodeID = 999
groupID = 1
busIndex = 15

function parseArgsX(args)
--	print("parsing this:", args)
	local a = {}
	if args ~= nil then
		for arg, val in pairs(args) do 
			table.insert(a, arg)
			table.insert(a, val)
		end
	end
	return a
end

function nextBufNum()
	bufnum = bufnum + 1
	print("BUFNUM: Next available", bufnum)
	return bufnum
end

function nextNodeID()
	nodeID = nodeID + 1
	return nodeID
end

function nextGroupID()
	groupID = groupID + 1
	return groupID
end

function nextBusIndex()
	busIndex = busIndex + 1
	return busIndex
end
