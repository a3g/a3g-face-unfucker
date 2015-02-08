class CfgPatches {
	class A3G_FaceUnfucker {
		units[] = {};
		weapons[] = {};
		requiredAddons[] = {"Extended_Eventhandlers"};
		author[] = {"Cephei"};
		version = "3.0";
	};
};

class CfgFunctions {
	#include "a3g-face-unfucker\cfgFunctions.hpp"
};

class A3G {
	class A3G_FaceUnfucker {
		#include "userconfig\a3g-face-unfucker\config.hpp"
	};
};