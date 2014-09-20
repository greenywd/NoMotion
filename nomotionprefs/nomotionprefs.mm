#import <Preferences/Preferences.h>

@interface nomotionprefsListController: PSListController {
}
@end

@implementation nomotionprefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"nomotionprefs" target:self] retain];
	}
	return _specifiers;
}
- (void)donate{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=9ZXVHGA5AW5CG&lc=AU&item_name=GreenyDev&currency_code=AUD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted"]];
}
-(void)respring{
  system("killall -9 backboardd");
}
- (void)save
{
    [self.view endEditing:YES];
}
@end

// vim:ft=objc
