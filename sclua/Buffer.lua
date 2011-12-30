Buffer = {}
Buffer.__index = Buffer

function Buffer:new()
   local bufr = {}
   setmetatable(bufr, Buffer)
   bufr.bufnum = nextBufNum();
--   bufr.name = name
--   bufr.args = parseArgsX(args) -- convert the arg table into a string
   
--   s:sendMsg('/s_new', bufr.name, bufr.nodeID, 0, 1, unpack(bufr.args)) -- WORKS!
   return bufr
end

function Buffer:alloc(numframes, numchannels)
	print("creating a BUFFER: ", path)
	print("__________bufnum is: ", self.bufnum)
   s:sendMsg('/b_alloc', self.bufnum, numframes, numchannels)
end

function Buffer:read(path)
   s:sendMsg('/b_allocRead', self.bufnum, path) -- WORKS!
end


function Buffer:write(path)
	print("writing a BUFFER: ", path)
	s:sendMsg('/b_write', self.bufnum, path, "aiff", "int16") -- WORKS!
end


function Buffer:free()
	print("freeing a BUFFER: ", path)
	s:sendMsg('/b_free', self.bufnum)
end

function Buffer:zero()
	print("freeing a BUFFER: ", path)
	s:sendMsg('/b_zero', self.bufnum)
end

function Buffer:set(index, value)
	print("freeing a BUFFER: ", path)
	s:sendMsg('/b_set', self.bufnum, index, value)
end

function Buffer:setn(index, numsamples, value) -- not ready perphas ... instead of value or use unpack
	print("freeing a BUFFER: ", path)
	s:sendMsg('/b_setn', self.bufnum, index, numsamples, value)
end

function Buffer:fill(index, numsamples, value)
	print("freeing a BUFFER: ", path)
	s:sendMsg('/b_fill', self.bufnum, index, numsamples, value)
end

function Buffer:close()
	print("freeing a BUFFER: ", path)
	s:sendMsg('/b_close', self.bufnum)
end

function Buffer:query()
	s:sendMsg('/b_query', self.bufnum)
end

function Buffer:get(index)
	s:sendMsg('/b_get', self.bufnum, index)
end

function Buffer:getn(index, numsamples)
	s:sendMsg('/b_get', self.bufnum, index, numsamples)
end



