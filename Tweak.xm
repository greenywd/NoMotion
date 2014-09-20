BOOL Enabled = YES;

%hook _UIMotionEffectEngine

+ (BOOL)_motionEffectsSupported{
	if(Enabled){
	return NO;
} else {
	return YES;
	}
}

+ (BOOL)_motionEffectsEnabled
{
	if(Enabled){
	return NO;
} else {
	return YES;
	}
}
%end

%hook UIView

+ (BOOL)_shouldEnableUIKitDefaultParallaxEffects
{
if(Enabled){
	return NO;
} else {
	return YES;
	}
}
%end

%hook SpringBoard
-(void)applicationDidFinishLaunching:(id)application{
  %orig;
    BOOL ranBeforeNoMotion = [[NSUserDefaults standardUserDefaults] boolForKey:@"ranBeforeNoMotion"];

    if (!ranBeforeNoMotion) {
        UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Hey There!"
                          message:@"Thank you for downloading NoMotion!\n If you appreciate my work, please donate by using the button in the settings app."
                          delegate:self
                          cancelButtonTitle:@"Thanks!"
                          otherButtonTitles:nil];
        [alert show];
        [alert release];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ranBeforeNoMotion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
	} 
}
%end

static void loadPrefs()
{
  NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.greeny.nomotionprefs.plist"];
  if(prefs)
    {
      Enabled = [prefs objectForKey:@"Enabled"] ? [[prefs objectForKey:@"Enabled"] boolValue] : Enabled;
    }
    [prefs release];
  }

  %ctor
  {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.greeny.nomotionprefs/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
  }