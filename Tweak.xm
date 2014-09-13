%hook _UIMotionEffectEngine

+ (BOOL)_motionEffectsSupported
{
	return NO;
}

+ (BOOL)_motionEffectsEnabled
{
	return NO;
}

%end

%hook UIView

+ (BOOL)_shouldEnableUIKitDefaultParallaxEffects
{
	return NO;
}

%end