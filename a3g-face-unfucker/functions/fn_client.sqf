// Mark player as using the addon, this is used to send update requests via bis_fnc_MP later by the server.
player setVariable["A3G_FaceUnfucker_UsingAddon", true, true];

// Debug key binding to manually toggle face removal
#include "\a3\editor_f\Data\Scripts\dikCodes.h"
["A3G Face Unfucker", "DEBUG: Manually scramble faces", {
	{
		[_x] call A3G_FaceUnfucker_fnc_Unfuck;
	} forEach ( playableUnits + switchableUnits );
}, [DIK_O, [true, true, false]]] call CBA_fnc_registerKeybind;

if ( isNil "A3G_FaceUnfucker_ServerRunning" ) then {
	[] spawn A3G_FaceUnfucker_fnc_LocalInstance;
};