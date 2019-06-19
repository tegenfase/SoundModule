
var index = List.fill(16,{0});
var depth = 0;

~samples = Dictionary.new;
~samples[\rootPath] = PathName.new("~/samples");

x = { | path |
	var files = Dictionary.new();
	index[depth] = index[depth]+1;
	index[depth+1] = 0;

	postln(index.copyRange(0,depth+1).asArray.asString ++ ">---------- " ++ path.folderName ++ " ---------<");
	path.entries.do{|entry|
		if(entry.isFile,{
			if("\.wav|WAV$".matchRegexp(entry.fullPath),{
				index[depth+1] = index[depth+1] + 1;
				index.copyRange(0,depth+1).asArray;
				// post(": ");
				// postln(entry.fileName ++ "\t");
				files[entry.fileName.asSymbol] = entry;

			});
		},{
			if(entry.isFolder,{
				depth = depth + 1;
				files[entry.folderName.asSymbol] = x.value(entry);
			});
		});
	};
	depth = depth-1;

	files;

};
~samples.put(\filePaths,x.value(~samples[\rootPath]));




//s = Server.new(\scsynth,NetAddr("127.0.0.1",57110));
//s = Server.local;
//s.options.protocol_(\udp);
//Server.default = s;
//s.startAliveThread(0);


post("classLibraryDir = "); Platform.classLibraryDir.postln;
post("userConfigDir = "); Platform.userConfigDir.postln;
post("userExtensionDir = "); Platform.userExtensionDir.postln;
post("platformDir = "); Platform.platformDir.postln;


// Nested function that scans an entire path and outputs the PathNames as a value and the name as key
// Nested function that scans an entire path and outputs the PathNames as a value and the name as key

