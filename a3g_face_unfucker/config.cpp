class CfgPatches {
	class A3G_Face_Unfucker {
		units[] = {};
		weapons[] = {};
		requiredAddons[] = {"Extended_EventHandlers"};
		author[] = {"Cephei"};
		version = "2.1";
	};
};

class Extended_PostInit_EventHandlers {
	class A3G_Face_Unfucker {
		init = "[] execVM 'a3g_face_unfucker\init.sqf';";
	};
};

class A3G {
	class A3G_Face_Unfucker {
		#include "\userconfig\a3g_face_unfucker\config.hpp"
	};
};