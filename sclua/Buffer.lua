Buffer = {}
Buffer.__index = Buffer

function Buffer:new()
   local bufr = {}
   setmetatable(bufr, Buffer)
   bufr.bufnum = nextBufNum();
   return bufr
end

function Buffer:alloc(numframes, numchannels)
   s:sendMsg('/b_alloc', self.bufnum, numframes, numchannels)
end

function Buffer:read(path)
   s:sendMsg('/b_allocRead', self.bufnum, path)
end

function Buffer:write(path)
	s:sendMsg('/b_write', self.bufnum, path, "aiff", "int16")
end

function Buffer:free()
	s:sendMsg('/b_free', self.bufnum)
end

function Buffer:zero()
	s:sendMsg('/b_zero', self.bufnum)
end

function Buffer:set(index, value)
	s:sendMsg('/b_set', self.bufnum, index, value)
end

function Buffer:setn(index, numsamples, value) -- not ready perphas ... instead of value or use unpack
	s:sendMsg('/b_setn', self.bufnum, index, numsamples, value)
end

function Buffer:fill(index, numsamples, value)
	s:sendMsg('/b_fill', self.bufnum, index, numsamples, value)
end

function Buffer:close()
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



