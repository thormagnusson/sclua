SynthDef(\luaimpulse, {arg out=0, freq=2, amp=1;
	Out.ar(out, Pan2.ar(Impulse.ar(freq)*amp, 0))
}).store;

Synth(\luaimpulse)



SynthDef(\luagrain, {arg out=0, freq=880, amp=1;
	var signal;
	signal = EnvGen.ar(Env.perc, doneAction:2) * SinOsc.ar(freq, 0, amp);
	Out.ar(out, Pan2.ar(signal, 0))
}).store;

Synth(\luaimpulse)



SynthDef(\luaplaybuf, {arg out=0, bufnum=0, rate=1, amp=1;
	var signal;
	signal = PlayBuf.ar(1, bufnum, rate, doneAction:2) * amp;
	Out.ar(out, Pan2.ar(signal, 0))
}).store;

Synth(\luaplaybuf)




SynthDef(\luareverb, {arg in=0, out=0, mix = 0.83, room = 0.5, damp = 0.5;
	var signal;
	signal = In.ar(0, 2);
	Out.ar(out, FreeVerb.ar(signal, mix, room, damp))
}).store;

Synth(\luareverb, addAction:\addToTail)






SynthDef(\luadelay, {arg in=0, out=0, maxdelaytime = 0.2, delaytime = 0.2, decaytime = 1.0;
	var signal;
	signal = In.ar(0, 2);
	Out.ar(out, AllpassC.ar(signal, maxdelaytime, delaytime, decaytime))
}).store;

Synth(\luadelay, addAction:\addToTail)



// a function to view nodes on the server
fork{
	inf.do({
		s.queryAllNodes;
		1.wait;
	})
}

