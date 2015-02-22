private ["_player", "_removeFace"];

_player = _this select 0;

_removeFace = true;
if([] call A3G_FaceUnfucker_fnc_BlacklistEnabled) then {
  // This is a blacklist, so all faces are fine unless they're on the blackList.
  _removeFace = false;
  if([_player, "blackList"] call A3G_FaceUnfucker_fnc_CheckList) then {
    _removeFace = true;
  };
} else {
  // This is a whitelist, so all faces are bad, unless they're on the whiteList.
  // Since it's already set to true, we don't have to do anything here.
  if([_player, "whiteList"] call A3G_FaceUnfucker_fnc_CheckList) then {
    _removeFace = false;
  };
};
if(_removeFace) then {
  _player setFace ( _player getVariable "A3G_FaceUnfucker_Face" );
};
