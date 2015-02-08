if( isServer ) then {
  // Do serverside
  [] call A3G_FaceUnfucker_fnc_Server;
};

if ( !isDedicated ) then {
  // Do clientside
  [] call A3G_FaceUnfucker_fnc_Client;
};

// If server is also a client, we need to raise a join event for him specifically.
if ( isServer && !isDedicated ) then {
  [] call A3G_FaceUnfucker_fnc_JoinEH;
};