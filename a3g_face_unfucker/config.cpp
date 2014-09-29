class CfgPatches {
	class a3g_face_unfucker {
		units[] = {};
		weapons[] = {};
		requiredAddons[] = {"Extended_EventHandlers"};
		author[] = {"Cephei"};
		version = "2.0";
	};
};

class Extended_PostInit_EventHandlers {
	class a3g_face_unfucker {
		init = "[] execVM 'a3g_face_unfucker\init.sqf';";
	};
};

class a3g {
	class a3g_face_unfucker {
		#include "\userconfig\a3g_face_unfucker\config.hpp"
	};
};