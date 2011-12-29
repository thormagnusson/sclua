require 'Synth'
require 'Server'

s = Server:new()
s:freeAll()
s:nextNodeID()
--s:dumpOSC(1)
--s:sendMsg('/s_new', 'default', 3000, 1, 1, "freq", 999 )
--s:sendMsg('/n_set', mysynth:getNodeID(), 'freq', 3*y)
--n = Node:new()
--n:speak()
--
----s = Synth:new("default", {freq = 322, amp = 0.3}, 2, 22)
--
mysynth = Synth:new("luaimpulse", { freq = 2 })
--mysynth:free()

reverb = Synth:new("luareverb", { freq = 2 })
--reverb:free()

delay = Synth:new("luadelay", { delaytime = 0.4, decaytime = 3 })

reverb:below(mysynth)
delay:below(mysynth)
--reverb:above(mysynth)
--mysynth:above(reverb)



local ctx = "OSC Template"
win = Window(ctx, 0, 0, 250, 250)

-- for example, sending messages based on mouse/keyboard interaction:
function win:mouse(event, btn, x, y)
	print(event, btn)
	if ((event == "down") and (btn == "left"))then
		mouseSynth = Synth:new("default", {freq=2222, amp=.01})
		mouseSynth:below(reverb)
	--	mouseSynth:below(delay)
		--mysynth:run()
	elseif event == "drag" then
		--print(mysynth:getNodeID())
		mouseSynth:set({freq = 3*y, amp= x/250})
		
		--s:sendMsg('/n_set', mysynth:getNodeID(), 'freq', 3*y)
	elseif event == "up" then	
		mouseSynth:free()
	end
	if ((event == "down") and (btn == "right")) then
		print("right click")
		--s:dumpOSC(1)
	end
end

function win:key(e, key)
	print("KEY", key)
	if key == 100 then -- KEY D
		
--		s:dumpOSC(1)
		reverb:below(mouseSynth)
		delay:below(mouseSynth)
	elseif key == 103 then -- KEY G - for grains
		Synth:new("luagrain", {freq=math.random(5222), amp=0.05})
	end
end
