Read Me - sclua - Jan 5th, 2012 - version 1

Early version of sclua - a lua client for SuperCollider

Description: This library is a lua client for SC-Server. It is a simple client, but implements most of the interface of SC-Server. A decision was taken to refrain from the complexity of SC lang and let the user build that complexity as they want in Lua itself. The library consists of the following classes:

Server (a class that communicates to the SC-Server)
Synth (a synth, i.e., an instantiation of a SynthDef on the server)
Group (a representation of a Group on the server)
Bus (a control bus on the server)
Buffer (sound samples read into RAM)
- there is also a funcs.lua file that provides necessary functions

This does library does not support compiling synthdefs for the server. To do that, use SuperCollider language.

Instructions:
- Start SuperCollider and boot the localhost server
- Run the synthdefs.scd (this will write the synthdefs we use)
- Run the SC_NodeTree.scd file provided in this lib (to view server status)
- Run the LuaAV examples (have fun!)


Issues
- two directional OSC ports required for server replying to lang


for SC users
- there is no concept of nodes (those are in the Synth and Group clesses)


TODO:
- make the OSC library independent of LuaAV



