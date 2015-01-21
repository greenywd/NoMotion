bool enabled;

%hook _UIMotionEffectEngine
+ (BOOL)_motionEffectsSupported{
    if(enabled){
    return NO;
} else {
    return %orig;
    }
}

+ (BOOL)_motionEffectsEnabled{
    if(enabled){
    return NO;
} else {
    return %orig;
    }
}
%end

%hook UIView
+ (BOOL)_shouldEnableUIKitDefaultParallaxEffects{
    if(enabled){
    return NO;
} else {
    return %orig;
    }
}
+ (BOOL)_motionEffectsEnabled{
    if(enabled){
    return NO;
} else {
    return %orig;
    }
}
+ (BOOL)_motionEffectsSupported{
    if(enabled){
    return NO;
} else {
    return %orig;
    }
}
%end

//Preferences
static void loadPreferences() {
    CFPreferencesAppSynchronize(CFSTR("com.greeny.nomotion"));

    //enabled = [(id)CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("com.greeny.nomotion")) boolValue];
}

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                NULL,
                                (CFNotificationCallback)loadPreferences,
                                CFSTR("com.greeny.nomotion/prefschanged"),
                                NULL,
                                CFNotificationSuspensionBehaviorDeliverImmediately);
    loadPreferences();
}