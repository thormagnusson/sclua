Bus = {}
Bus.__index = Bus

function Bus:new()
   local bs = {}
   setmetatable(bs, Bus)
--   local nodeID = nextNodeID()
   s:sendMsg('/s_new', snth.name, snth.nodeID, 0, 1, unpack(snth.args)) -- WORKS!
   return bs
end
