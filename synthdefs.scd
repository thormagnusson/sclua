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


s.plotTree // updated graph function in SC 3.5 - very nice










b = Bus.control(s, 1); b.set(880);
c = Bus.control(s, 1);	c.set(884);

SynthDef("luasine", { arg out=0, freq=440, amp=0.5; 
	Out.ar(out, Pan2.ar(SinOsc.ar(freq, 0, amp), 0));
}).store;

x.map(\freq1, b, \freq2, c);
x.free; b.free; c.free;



b = Bus.control(s, 1); 
b.set(880);

SynthDef("luasine", { arg out=0, freq=440, amp=0.5; 
	Out.ar(out, Pan2.ar(SinOsc.ar(freq, 0, amp), 0));
}).store;

x = Synth("luasine")
x.map(\freq, b);


SynthDef(\lfo, {arg ctrlbus = 2, freq=4, amp=100;
        Out.kr(ctrlbus, SinOsc.kr(freq, 0, mul: amp, add: 200)); // note the .kr
}).store;

SynthDef(\lfosaw, {arg ctrlbus = 2, freq=4, amp=100;
        Out.kr(ctrlbus, LFSaw.kr(freq, 0, mul: amp, add: 200)); // note the .kr
}).store;
