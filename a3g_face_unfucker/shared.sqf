// Function to get a random face from the config.
A3G_Face_Unfucker_fnc_getRandomFace = {
	// Filter for identities with non-empty faces.
	_identities = "getText (_x >> 'face') != ''" configClasses (configFile >> "CfgIdentities");
	// Count the number of faces we get.
	_numIdentities = count _identities;
	// Get random face.
	_newFace = getText( _identities select ( floor random _numIdentities ) >> "face" );
	_newFace
};

// Function to write face data into unit variable space.
A3G_Face_Unfucker_fnc_faceCheck = {
	_global = _this select 0;
	{
		// If unit does not have a face decided yet.
		if( isNil { _x getVariable "A3G_Face_Unfucker_face" } ) then {
			// Find a random face and write it to unit variable space. This value is broadcasted across clients _and_ JIPs, so it doesn't need to be repeated.
			_x setVariable["A3G_Face_Unfucker_face", [] call A3G_Face_Unfucker_fnc_getRandomFace, _global];
		};
	} forEach ( playableUnits + switchableUnits );
};