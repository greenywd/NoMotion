#import <Preferences/Preferences.h>

@interface NoMotionListController: PSListController {
}
@end

@implementation NoMotionListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"NoMotion" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
