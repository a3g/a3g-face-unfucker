class Config {
	whiteList[] = {};
	blackList[] = {};
	useBlacklistInstead = "false";				// If you set this to true, the blacklist is enabled instead of whitelist.
	
	// Example:
	// whiteList[] = {"76561197961167880"};		// Id's have to be seperated with a comma AND surrounded by quotes.
	// blackList[] = {};						// Two Id's would look like this: whiteList[] = {"76561197961167880", "76561197961167880"};
	// useBlacklistInstead = "false";
	// An empty list has no effect.
	
	// These need to be the unique player Id's. You can find them by looking up their Steam64 Id ( google it ).
	// The above setting is comfy blanket btw.
};