--require('sclua.*')

require 'sclua.funcs'
require 'sclua.Server'
require 'sclua.Synth'
require 'sclua.Buffer'
require 'sclua.Group'
require 'sclua.Bus'

s = Server:new()
s:freeAll() -- free all synths playing and clear up the server
s:notify(1) -- notify the client (not working atm).


sine = Synth:new("luasine", { freq = 440 })
bus = Bus:new()
bus:set(1000)
--bus:get()

sine:map("freq", bus)

lfo = Synth:new("lfo", { ctrlbus = bus:index() })

--sine:map("freq", bus:index())

local ctx = "sclua test"
win = Window(ctx, 0, 0, 350, 150)

function win:mouse(event, btn, x, y)
	if ((event == "down") and (btn == "left"))then
		
	elseif event == "drag" then

--		lfo:set({ freq = x / 10 })
--		lfo:set({ mul = y })
		lfo:set({freq = x / 10, mul = y})

	elseif event == "up" then	

	end
end

function win:key(e, key)
	print("KEY", key)
	if e == "down" then	
		if key == 100 then -- KEY D
			bus:set(math.random(2000))
		elseif key == 103 then -- KEY G - for grains

			Synth:new("luagrain", {freq=math.random(5222), amp=0.05}) -- no variable (synth frees itself)
		elseif key == 98 then -- KEY B - for buffer synth
			lfo:free()
			lfo = Synth:new("lfosaw", { ctrlbus = bus:index() })

		elseif key == 118 then -- KEY V - for moving playbuf out of reverb and delay
			lfo:free()
			lfo = Synth:new("lfosaw", { ctrlbus = bus:index() })

		elseif key == 99 then -- KEY C - for moving playbuf back on top w. reverb and delay

		end
	end
end
