_player = _this select 0;
_global = _this select 1;

// Find a random face and write it to unit variable space. This value is then broadcasted across clients _and_ JIPs, so it doesn't need to be repeated.
_player setVariable["A3G_FaceUnfucker_Face", [] call A3G_FaceUnfucker_fnc_GetRandomFace, _global];