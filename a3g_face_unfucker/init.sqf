// Mark player as using the addon, this is used to send update requests via BIS_fnc_MP later by the server.
// Needs to be the first thing that happens because reasons.
player setVariable["a3g_face_unfucker_addon", true, true];

// Debug key binding to manually toggle face removal
#include "\a3\editor_f\Data\Scripts\dikCodes.h"
["a3g face unfucker", "DEBUG: Manually remove faces", { [] call a3g_face_unfucker_unfuck; }, [DIK_B, [true, true, false]]] call CBA_fnc_registerKeybind;

// ===================================== SERVERSIDE STUFF =========================================

// Persistence DISABLED, this code targets the server instead and only needs to run once at mission start, or
// when someone using this addon joins.
// We seed the faces here and pull them later clientside. This is used to synchronize faces across users of this addon.
[{
	// Function to find all units who's players run the addon.
	if(isNil "a3g_face_unfucker_addonUsers") then {
		a3g_face_unfucker_addonUsers = {
			_a3g_face_unfucker_addonUsers = [];
			{
				if(!isNil {_x getVariable "a3g_face_unfucker_addon"}) then {
					_a3g_face_unfucker_addonUsers pushBack _x;
				};
			} forEach (playableUnits + switchableUnits);
			
			// return value
			_a3g_face_unfucker_addonUsers
		};			
	};
	
	// Function to return a random non-custom face.
	if(isNil "a3g_face_unfucker_getRandomFace") then {
		a3g_face_unfucker_getRandomFace = {
			/* For some reason the reported face via the scripting command "face" is NOT predictable and is presumably based
			on the unit, not the player, and thus random, so we have to replace ALL faces at this point unfortunately. */
			
			// Filter for identities with non-empty faces.
			_identities = "getText (_x >> 'face') != ''" configClasses (configFile >> "CfgIdentities");		
			// Count the number of faces we get.
			_numIdentities = count _identities;		
			// Apply random face.
			_newFace = getText(_identities select (floor random _numIdentities) >> "face");		
			// Return value ( no semicolon ).
			_newFace
		};
	};
	
	// Function to decide and write face identities into the variable space of all player units on the server who don't have a face yet.
	// switchableUnits is included for editor debugging purposes.
	if(isNil "a3g_face_unfucker_faceCheck") then {
		a3g_face_unfucker_faceCheck = {
			{
				// If unit does not have a face decided yet.
				if(isNil{_x getVariable "a3g_face_unfucker_face"}) then {
					// Find a random face and write it to unit variable space. This value is broadcasted across clients _and_ JIPs, so it doesn't need to be repeated.
					_x setVariable["a3g_face_unfucker_face", [] call a3g_face_unfucker_getRandomFace, true];
				};
			} forEach (playableUnits + switchableUnits);
		};
	};

	// At this point we hook the face checker to the server event of people joining.
	// This event runs on the server only and kicks off face checking on it.
	// Event fires AFTER the JIP'd unit has gained control of his unit.
	if(isNil "a3g_face_unfucker_eventDefined") then {
		a3g_face_unfucker_eventDefined = true;
		["a3g_face_unfucker_someId", "onPlayerConnected", {
			[] call a3g_face_unfucker_faceCheck;			
			[] spawn {
				_addonUsers = [] call a3g_face_unfucker_addonUsers;				
				sleep 3;	// Sleep to compensate for clients receiving their custom face a bit later than this event is firing.
				[{
					[] call a3g_face_unfucker_unfuck;
				}, "BIS_fnc_spawn", _addonUsers, false] call BIS_fnc_MP;	// This is sent only to clients that have the addon.
			};
		}] call BIS_fnc_addStackedEventHandler;
	};
	
	// Finally, run the code above regardless once, to make absolutely sure that no matter which entry point this script has
	// ie. via JIP, present from the start or the server itself, it runs atleast once.
	[] call a3g_face_unfucker_faceCheck;
}, "BIS_fnc_spawn", false, false] call BIS_fnc_MP;	// Sends to the server only, no Persistence.

// ===================================== CLIENTSIDE STUFF =========================================

// Function to find out if whiteList is enabled
a3g_face_unfucker_blacklistEnabled = {
	// Return value
	[(configfile >> "a3g" >> "a3g_face_unfucker" >> "Config"), "useBlacklistInstead", "false"] call BIS_fnc_returnConfigEntry == "true"
};

// Function to find out if player of unit is white / blacklisted
a3g_face_unfucker_listCheck = {
	_testUnit = _this select 0;
	_list = _this select 1;
	
	// Get whiteList
	_listConfig = [(configfile >> "a3g" >> "a3g_face_unfucker" >> "Config"), _list, []] call BIS_fnc_returnConfigEntry;
	_listed = false;	
	{
		if(getPlayerUID _testUnit == _x) then {
			_listed = true;
		};
	} forEach _listConfig;
	
	// Return value
	_listed
};

// Function to apply or reapply all faces on the client. Those are grabbed from the unit variable space, so faces will be synchronized across clients.
// switchableUnits is here because playableUnits contains no units in the editor, ie. debugging purposes.
a3g_face_unfucker_unfuck = {
	{
		// Value pulled from the server, hence the waitUntil here.
		waitUntil {!isNil{_x getVariable "a3g_face_unfucker_face"}};
		_removeFace = true;
		if([] call a3g_face_unfucker_blacklistEnabled) then {
			// This is a blacklist, so all faces are fine unless they're on the blackList.
			_removeFace = false;
			if([_x, "blackList"] call a3g_face_unfucker_listCheck) then {
				_removeFace = true;
			};
		} else {
			// This is a whitelist, so all faces are bad, unless they're on the whiteList.
			// Since it's already set to true, we don't have to do anything here.
			if([_x, "whiteList"] call a3g_face_unfucker_listCheck) then {
				_removeFace = false;
			};
		};
		if(_removeFace) then {
			_x setFace (_x getVariable "a3g_face_unfucker_face");
		};
	} forEach (playableUnits + switchableUnits);
};

// Respawning players get their old face back, we don't want this for obvious reasons.
// This is for ALL "players" on your computer, so we need to loop through them here.
// BUG: The EH only ever fires on player unit, never on other players.
{
	_x addEventHandler["Respawn", {
		[] call a3g_face_unfucker_unfuck;
	}];
} forEach (playableUnits + switchableUnits);

// Like with the server, the script needs to run atleast once, so here goes:
[] call a3g_face_unfucker_unfuck;