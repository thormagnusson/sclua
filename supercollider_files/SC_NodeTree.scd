
// A SC patch that shows AND UPDATES the nodes on the server
// for SC lang 3.4 (this is already implemented in SC 3.5)
 
f = {|interval=0.5|
		var resp, done = false;
		var collectChildren, levels, countSize;
		var window, view, bounds;
		var updater, updateFunc;
		var tabSize = 25;

		window = Window.new("SC Server - Node Tree",
			Rect(5, 255, 400, 400),
			scroll:true
		).front;
		window.view.hasHorizontalScroller_(false).background_(Color.grey(0.9));

		view = UserView.new(window, Rect(0,0,400,400));

		view.drawFunc = {
			var xtabs = 0, ytabs = 0, drawFunc;

			drawFunc = {|group|
				var thisSize, rect, endYTabs;
				xtabs = xtabs + 1;
				ytabs = ytabs + 1;
				//Pen.font = Font.sansSerif(10);
				Pen.font = Font("Helvetica", 10);

				group.do({|node|
					if(node.value.isArray, {
						thisSize = countSize.value(node);
						endYTabs = ytabs + thisSize + 0.2;
						rect = Rect(xtabs * tabSize + 0.5,
							ytabs * tabSize + 0.5,
							window.view.bounds.width - (xtabs * tabSize * 2),
							thisSize * tabSize;
						);
						Pen.fillColor = Color.grey(0.8);
						Pen.fillRect(rect);
						Pen.strokeRect(rect);
						Pen.color = Color.black;
						Pen.stringInRect(
							" Group" + node.key.asString +
							(node.key == 1).if("- default group", ""),
							rect
						);
						drawFunc.value(node.value);
						ytabs = endYTabs;
					},{
						rect = Rect(xtabs * tabSize + 0.5,
							ytabs * tabSize + 0.5,
							7 * tabSize,
							0.8 * tabSize
						);
						Pen.fillColor = Color.white;
						Pen.fillRect(rect);
						Pen.strokeRect(rect);
						Pen.color = Color.black;
						Pen.stringInRect(
							" " ++ node.key.asString + node.value.asString,
							rect
						);
						ytabs = ytabs + 1;
					});
				});
				xtabs = xtabs - 1;
			};
			drawFunc.value(levels);
		};

		// msg[1] controls included
		// msg[2] nodeID of queried group
		// initial number of children
		resp = OSCresponderNode(nil, '/g_queryTree.reply', { arg time, responder, msg;
			var finalEvent;
			var i = 2, j, controls, printControls = false, dumpFunc;
			if(msg[1] != 0, {printControls = true});
			dumpFunc = {|numChildren|
				var event, children;
				event = ().group;
				event.id = msg[i];
				event.instrument = nil; // need to know it's a group
				i = i + 2;
				children = Array.fill(numChildren, {
					var id, child;
					// i = id
					// i + 1 = numChildren
					// i + 2 = def (if synth)
					id = msg[i];
					if(msg[i+1] >=0, {
						child = dumpFunc.value(msg[i+1]);
					}, {
						j = 4;
						child = ().synth.instrument_(msg[i+2]);
						if(printControls, {
							controls = ();
							msg[i+3].do({
								controls[msg[i + j]] = msg[i + j + 1];
								j = j + 2;
							});
							child.controls = controls;
							i = i + 4 + (2 * controls.size);
						}, {i = i + 3 });
					});
					child.id = id;
				});
				event.children = children;
				event;
			};

			finalEvent = dumpFunc.value(msg[3]);
			done = true;
			collectChildren = {|group|
				group.children.collect({|child|
					if(child.children.notNil,{
						child.id -> collectChildren.value(child);
					}, {
						child.id -> child.instrument;
					});
				});
			};
			levels = collectChildren.value(finalEvent);
			countSize = {|array|
				var size = 0;
				array.do({|elem|
					if(elem.value.isArray, { size = size + countSize.value(elem.value) + 2}, {size = size + 1;});
				});
				size
			};

			defer {
				view.bounds = Rect(0, 0, 400, max(400, tabSize * (countSize.value(levels) + 2)));
				view.refresh;
			}
		}).add;

		updateFunc = {
			fork {
				loop {
					s.sendMsg("/g_queryTree", 0, 0);
					interval.wait;
				}
			}
		};
		updater = updateFunc.value;
		CmdPeriod.add(updateFunc);
		window.onClose = {
			view.remove;
			updater.stop;
			CmdPeriod.remove(updateFunc);
			resp.remove;
		};
		SystemClock.sched(3, {
			if(done.not, {
				defer {window.close};
				"Server failed to respond to Group:queryTree!".warn;
			});
		});
};

f.value;
	
