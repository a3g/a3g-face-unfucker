// Tell clients that there's a server coordinating the faces.
A3G_FaceUnfucker_ServerRunning = true;
publicVariable "A3G_FaceUnfucker_ServerRunning";

// Make a join event
["A3G_FaceUnfucker_EventID", "onPlayerConnected", {
	[_uid] call A3G_FaceUnfucker_fnc_JoinEH;
}] call bis_fnc_addStackedEventHandler;