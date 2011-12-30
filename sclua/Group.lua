Group = {}
Group.__index = Group

function Group:new(aGroup)
	local grp = {}
	setmetatable(grp, Group)
	grp.name = name
	grp.args = parseArgsX(args) -- convert the arg table into a string
	if aGroup == nil then
		target = 1 -- default SC server group 
	else
		target = aGroup.nodeID
	end
	grp.nodeID = nextGroupID()
	s:sendMsg('/g_new', grp.nodeID, 0, target) -- add to head by default
	return grp
end

function Group:moveToHead(aNode)
	s:sendMsg('/g_head', aNode.nodeID, self.nodeID)
end

function Group:moveToTail(aNode)
	s:sendMsg('/g_tail', aNode.nodeID, self.nodeID)
end

function Group:above(aGroup)
	s:sendMsg('/n_before', self.nodeID, aGroup.nodeID )
end

function Group:below(aGroup)
	s:sendMsg('/n_after', self.nodeID, aGroup.nodeID )
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
	-- Replies to the sender with a /g_queryTree.reply message
	s:sendMsg('/g_queryTree', self.nodeID, flag )
end
