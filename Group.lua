Group = {}
Group.__index = Group

function Group:new(aGroup)
	local grp = {}
	setmetatable(grp, Group)
	print("_______________MAKING GROUP")
	grp.name = name
	grp.args = parseArgsX(args) -- convert the arg table into a string
	if aGroup == nil then
		print("_______A NODE IS NIL")
		target = 1 -- default sc group 
	else
		print("_______A NODE IS NIL__________________")
		target = aGroup.nodeID
	end
	grp.nodeID = nextGroupID()
	--local target = aNode.nodeID or 1 -- default SC server nodeID is 0
	print("GROUP: Target is : ", target)
--	s:sendMsg('/g_new', target, 0, grp.nodeID) -- add to head by default
	s:sendMsg('/g_new', grp.nodeID, 0, target) -- add to head by default
   
--   s:sendMsg('/s_new', grp.name, grp.nodeID, 0, 1, unpack(grp.args)) -- WORKS
	return grp
end

function Group:moveToHead(aNode)
	print("anode ID:", aNode.nodeID)
	print("self ID:", self.nodeID)
	
--	s:sendMsg('/g_head', self.nodeID, aNode.nodeID )
	s:sendMsg('/g_head', aNode.nodeID, self.nodeID)
end

function Group:moveToTail(aNode)
	s:sendMsg('/g_tail', self.nodeID, aNode.nodeID )
end


function Group:freeAll()
	s:sendMsg('/g_freeAll', self.nodeID )
end

function Group:deepFree()
	s:sendMsg('/g_deepFree', self.nodeID )
end

function Group:dumpTree(flag)
	flag = flag or 0
	s:sendMsg('/g_dumpTree', self.nodeID, flag )
end

function Group:queryTree(flag)
	flag = flag or 0
	s:sendMsg('/g_queryTree', self.nodeID, flag )
	-- Replies to the sender with a /g_queryTree.reply message
end
