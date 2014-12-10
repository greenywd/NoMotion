
//Initialize the variables.
bool enabled;

static void loadPreferences() {
    CFPreferencesAppSynchronize(CFSTR("com.greeny.nomotion"));
    //In this case, you get the value for the key "enabled"
    //you could do the same thing for any other value, just cast it to id and use the conversion methods
    //if the value doesn't exist (i.e. the user hasn't changed their preferences), it is set to the value after the "?:" (in this case, YES and @"default", respectively
    enabled = [(id)CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR("com.greeny.nomotion")) boolValue];
}

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

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                NULL,
                                (CFNotificationCallback)loadPreferences,
                                CFSTR("com.greeny.nomotion/prefsChanged"),
                                NULL,
                                CFNotificationSuspensionBehaviorDeliverImmediately);
    loadPreferences();
}