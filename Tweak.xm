#import <substrate.h>

// Destroy all the things!!

%hook _UIMotionEffectEngineClient

- (id)initWithMotionEffect:(id)arg1 view:(id)arg2
{
	return nil;
}

%end

%hook _UIMotionEffectEngine

- (id)init
{
	return nil;
}

%end

// Tell UIView motion effect is gone

%hook UIView

+ (BOOL)_shouldEnableUIKitDefaultParallaxEffects
{
    return NO;
}

+ (BOOL)_motionEffectsEnabled
{
   return NO;
}

+ (BOOL)_motionEffectsSupported
{
    return NO;
}

%end
