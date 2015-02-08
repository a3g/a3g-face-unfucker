_unit = _this select 0;
_list = _this select 1;

// Get whiteList
_listConfig = [(configfile >> "A3G" >> "A3G_FaceUnfucker" >> "Config"), _list, []] call bis_fnc_returnConfigEntry;
_listed = false;
{
  if(getPlayerUID _unit == _x) then {
    _listed = true;
  };
} forEach _listConfig;

// Return value
_listed