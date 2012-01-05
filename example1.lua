funcs = require('sclua.funcs')
Server = require('sclua.Server')
Buffer = require('sclua.Buffer')
Group = require('sclua.Group')
Synth = require('sclua.Synth')

--[[
This example shows:
	- starting server
	- loading a buffer
	- creating synths
	- creating groups
	- ordering synths and groups
]]

s = Server:new()
s:freeAll() -- free all synths playing and clear up the server
--s:notify(1) -- notify the client (not working atm).

mybuf = Buffer:new()
mybuf:read("/Users/thor/Library/Application Support/SuperCollider/sounds/a11wlk01.wav")

impulse = Synth:new("luaimpulse", { freq = 2 })
impulse2 = Synth:new("luaimpulse", { freq = 3 })
default = Synth:new("default", { freq = 2 })
reverb = Synth:new("luareverb", { freq = 2 })
delay = Synth:new("luadelay", { delaytime = 0.4, decaytime = 3 })

impulse:above(default)

-- try to comment out the lines below and add one by one in
-- perhaps running this line in SC-lang : s.dumpTree (or use provided SC_NodeTree.rtf file)

groop = Group:new()
impulse:moveToHead(groop)
impulse2:moveToHead(groop)
delay:moveToTail(groop)

groox = Group.new(groop)
groox:below(groop)

reverb:moveToTail(groox)
---------------------------

local ctx = "sclua test"
win = Window(ctx, 0, 0, 380, 200)

function win:mouse(event, btn, x, y)
	if ((event == "down") and (btn == "left"))then
		mouseSynth = Synth:new("luaimpulse", { freq = 2222, amp = 0.1 })
		mouseSynth:moveToHead(groox)
		groox:above(groop)
	elseif event == "drag" then
		mouseSynth:set({freq = 3*y, amp = x/250})
	elseif event == "up" then	
		mouseSynth:free()
		groox:below(groop)
	end
end

function win:key(e, key)
	print("KEY", key)
	if e == "down" then	
		if key == 100 then -- KEY D
			reverb:below(mouseSynth)
			delay:below(mouseSynth)
		elseif key == 103 then -- KEY G - for grains
			Synth:new("luagrain", { freq = math.random(5222), amp = 0.05 }) -- no variable (synth frees itself)
		elseif key == 98 then -- KEY B - for buffer synth
			bufsynth = Synth:new("luaplaybuf", { amp = 0.9 })
		elseif key == 118 then -- KEY V - for moving playbuf out of reverb and delay
			bufsynth:below(groox)
		elseif key == 99 then -- KEY C - for moving playbuf back on top w. reverb and delay
			bufsynth:above(groop)
		end
	end
end
