// ======================================= SHARED STUFF ===========================================
[] call compile preprocessFile "a3g_face_unfucker\shared.sqf";

// ===================================== SERVERSIDE STUFF =========================================
if ( isServer ) then {
	[] call compile preprocessFile "a3g_face_unfucker\server.sqf";
};

// ===================================== CLIENTSIDE STUFF =========================================
if ( !isDedicated ) then {
	[] call compile preprocessFile "a3g_face_unfucker\client.sqf";
};