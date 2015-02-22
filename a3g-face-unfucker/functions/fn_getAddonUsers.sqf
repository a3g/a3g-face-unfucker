private ["_addonUsers"];

// Function to find all units who run the addon.
_addonUsers = [];
{
  if( !isNil { _x getVariable "A3G_FaceUnfucker_UsingAddon" } ) then {
    _addonUsers pushBack _x;
  };
} forEach ( playableUnits + switchableUnits );

_addonUsers