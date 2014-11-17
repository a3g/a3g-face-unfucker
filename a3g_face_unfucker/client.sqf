// Mark player as using the addon, this is used to send update requests via BIS_fnc_MP later by the server.
player setVariable["A3G_Face_Unfucker_usingAddon", true, true];

// Debug key binding to manually toggle face removal
#include "\a3\editor_f\Data\Scripts\dikCodes.h"
["A3G Face Unfucker", "DEBUG: Manually scramble faces", { [] call A3G_Face_Unfucker_fnc_unfuck; }, [DIK_F, [true, true, false]]] call CBA_fnc_registerKeybind;

// Function to find out if whiteList is enabled
A3G_Face_Unfucker_fnc_blacklistEnabled = {
	// Return value
	[(configfile >> "A3G" >> "A3G_Face_Unfucker" >> "Config"), "useBlacklistInstead", "false"] call BIS_fnc_returnConfigEntry == "true"
};

// Function to find out if unit is white or blacklisted
A3G_Face_Unfucker_fnc_checkList = {
	_unit = _this select 0;
	_list = _this select 1;
	
	// Get whiteList
	_listConfig = [(configfile >> "A3G" >> "A3G_Face_Unfucker" >> "Config"), _list, []] call BIS_fnc_returnConfigEntry;
	_listed = false;
	{
		if(getPlayerUID _unit == _x) then {
			_listed = true;
		};
	} forEach _listConfig;
	
	// Return value
	_listed
};

// Function to apply or reapply all faces on the client. This function is called by the server, via timer or manually via keybinding.
A3G_Face_Unfucker_fnc_unfuck = {
	{
		_removeFace = true;
		if([] call A3G_Face_Unfucker_fnc_blacklistEnabled) then {
			// This is a blacklist, so all faces are fine unless they're on the blackList.
			_removeFace = false;
			if([_x, "blackList"] call A3G_Face_Unfucker_fnc_checkList) then {
				_removeFace = true;
			};
		} else {
			// This is a whitelist, so all faces are bad, unless they're on the whiteList.
			// Since it's already set to true, we don't have to do anything here.
			if([_x, "whiteList"] call A3G_Face_Unfucker_fnc_checkList) then {
				_removeFace = false;
			};
		};
		if(_removeFace) then {
			_x setFace ( _x getVariable "A3G_Face_Unfucker_face" );
		};
	} forEach ( playableUnits + switchableUnits );
};

// Periodically check if the server could be reached by now
if ( isNil "A3G_Face_Unfucker_serverRunning" ) then {
	systemChat "A3G Face Unfucker: Server appears to not run the mod. Running local instance instead. Faces will not be synchronized across the network.";
	while { isNil "A3G_Face_Unfucker_serverRunning" } do {
		[false] call A3G_Face_Unfucker_fnc_faceCheck;
		[] call A3G_Face_Unfucker_fnc_unfuck;
		sleep 60;
	};
	systemChat "A3G Face Unfucker: Server connection established. Faces will be synchronized across the network now.";
};