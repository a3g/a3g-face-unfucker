// Tell clients that there's a server coordinating the faces.
A3G_Face_Unfucker_serverRunning = true;
publicVariable "A3G_Face_Unfucker_serverRunning";

// Function to find all units who run the addon.
A3G_Face_Unfucker_fnc_getAddonUsers = {
	_addonUsers = [];
	{
		if( !isNil { _x getVariable "A3G_Face_Unfucker_usingAddon" } ) then {
			_addonUsers pushBack _x;
		};
	} forEach ( playableUnits + switchableUnits );
	_addonUsers
};

// JIP & Join event
A3G_Face_Unfucker_fnc_joinEvent = {
	[true] call A3G_Face_Unfucker_fnc_faceCheck;
	_addonUsers = [] call A3G_Face_Unfucker_fnc_getAddonUsers;				
	sleep 5;	// Sleep to wait a bit for clients properly loading into the game.
	[{
		[] call A3G_Face_Unfucker_fnc_unfuck;
	}, "BIS_fnc_spawn", _addonUsers, false] call BIS_fnc_MP;	// This is sent only to clients that have the addon.
};	

["A3G_Face_Unfucker_eventID", "onPlayerConnected", {
	[] spawn A3G_Face_Unfucker_fnc_joinEvent;
}] call BIS_fnc_addStackedEventHandler;

// The event above doesn't fire in the editor.
[] spawn A3G_Face_Unfucker_fnc_joinEvent;