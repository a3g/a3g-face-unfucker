_player = if ( count _this > 0 ) then { objectFromNetId ( _this select 0 )} else { player };

[_player, true] call A3G_FaceUnfucker_fnc_CheckFace;
_addonUsers = [] call A3G_FaceUnfucker_fnc_GetAddonUsers;

// This is sent only to clients that have the addon.
[[_player], "A3G_FaceUnfucker_fnc_Unfuck", _addonUsers, false] call bis_fnc_MP;