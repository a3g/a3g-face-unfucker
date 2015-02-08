// Periodically check if the server could be reached by now
player sideChat "A3G Face Unfucker: Server appears to not run the mod. Running local instance instead. Faces will not be synchronized across the network.";
while { isNil "A3G_FaceUnfucker_ServerRunning" } do {
  {
    [_x, false] call A3G_FaceUnfucker_fnc_CheckFace;
    [_x] call A3G_FaceUnfucker_fnc_Unfuck;
  } forEach ( playableUnits + switchableUnits );
  sleep 60;
};

player sideChat "A3G Face Unfucker: Server connection established. Faces will be synchronized across the network now.";