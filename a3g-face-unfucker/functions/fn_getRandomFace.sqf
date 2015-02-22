private ["_identities", "_numIdentities", "_newFace"];

// Filter for identities with non-empty faces.
_identities = "getText (_x >> 'face') != ''" configClasses (configFile >> "CfgIdentities");
// Count the number of faces we get.
_numIdentities = count _identities;
// Get random face.
_newFace = getText( _identities select ( floor random _numIdentities ) >> "face" );

_newFace