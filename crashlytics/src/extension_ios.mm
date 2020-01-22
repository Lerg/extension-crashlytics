#if defined(DM_PLATFORM_IOS)

#import <FirebaseCore/FirebaseCore.h>
#import <FirebaseCrashlytics/FirebaseCrashlytics.h>
#include "extension.h"

#import "ios/utils.h"

#define ExtensionInterface FUNCTION_NAME_EXPANDED(EXTENSION_NAME, ExtensionInterface)

// Using proper Objective-C object for main extension entity.
@interface ExtensionInterface : NSObject
@end

@implementation ExtensionInterface {
	bool is_initialized;
}

static ExtensionInterface *extension_instance;
int EXTENSION_INIT(lua_State *L) {return [extension_instance init_:L];}
int EXTENSION_CRASH(lua_State *L) {return [extension_instance crash:L];}

-(id)init:(lua_State*)L {
	self = [super init];

	is_initialized = false;

	return self;
}

-(bool)check_is_initialized {
	if (is_initialized) {
		return true;
	} else {
		dmLogInfo("The extension is not initialized.");
		return false;
	}
}

# pragma mark - Lua functions -

-(int)init_:(lua_State*)L {
	[Utils check_arg_count:L count:0];
	if (is_initialized) {
		dmLogInfo("The extension is already initialized.");
		return 0;
	}

	[FIRApp configure];
	[FIRCrashlytics.crashlytics sendUnsentReports];
	[FIRCrashlytics.crashlytics setCrashlyticsCollectionEnabled:YES];

	is_initialized = true;

	return 0;
}

-(int)crash:(lua_State*)L {
	[Utils check_arg_count:L count:0];
	if (![self check_is_initialized]) {
		return 0;
	}

	assert(NO);

	return 0;
}

@end

#pragma mark - Defold lifecycle -

void EXTENSION_INITIALIZE(lua_State *L) {
	extension_instance = [[ExtensionInterface alloc] init:L];
}

void EXTENSION_UPDATE(lua_State *L) {
	[Utils execute_tasks:L];
}

void EXTENSION_APP_ACTIVATE(lua_State *L) {
}

void EXTENSION_APP_DEACTIVATE(lua_State *L) {
}

void EXTENSION_FINALIZE(lua_State *L) {
    extension_instance = nil;
}

#endif
