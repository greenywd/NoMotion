bool enabled;
NSString *tweakName = @"NoMotion";

%hook _UIMotionEffectEngine
+ (BOOL)_motionEffectsSupported{
    if(enabled){
    return NO;
} else {
    return YES;
    }
}

+ (BOOL)_motionEffectsEnabled{
    if(enabled){
    return NO;
} else {
    return YES;
    }
}
%end

%hook UIView
+ (BOOL)_shouldEnableUIKitDefaultParallaxEffects{
    if(enabled){
    return NO;
} else {
    return YES;
    }
}
%end

static NSDictionary *prefs;
static void loadPrefs() {
    [prefs release];
    prefs = [[NSDictionary alloc] initWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Preferences/com.greeny.nomotion.plist"]];
    CFStringRef appID = CFSTR("com.greeny.nomotion");
    CFArrayRef keyList = CFPreferencesCopyKeyList(appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    if (!keyList) {
        return;
    }
    prefs = (NSDictionary *)CFPreferencesCopyMultiple(keyList, appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    if (!prefs) {
        NSLog(@"[%@] Preferences not loaded correctly.", tweakName);
    }
    
    NSLog(@"[%@] The settings dictionary is %@", tweakName, prefs);
    enabled = ([prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : enabled);
    NSLog(@"[%@] isEnabled is %d", tweakName, enabled);

    CFRelease(keyList);
    
}

static void settingschanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
    loadPrefs();
    
    
}


%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingschanged, CFSTR("com.greeny.nomotion/prefschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}