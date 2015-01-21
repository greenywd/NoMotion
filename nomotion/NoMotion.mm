#import <Preferences/Preferences.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSViewController.h>
#import <Preferences/Preferences.h>
#import <Preferences/PSTableCell.h>
#import <Twitter/TWTweetComposeViewController.h>
#import <MessageUI/MFMailComposeViewController.h>

#define kTintColor [UIColor colorWithRed:0/256.0 green:172/256.0 blue:237/256.0 alpha:1]
#define kTweetText @"I'm using #NoMotion by @GreenyDev to completely remove the parallax effect!"

@protocol PreferencesTableCustomView
- (id)initWithSpecifier:(id)arg1;
@end

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
- (void)viewWillAppear:(BOOL)arg1 {
	    [super viewWillAppear:arg1];

[[UIApplication sharedApplication] keyWindow].tintColor = kTintColor;
    self.navigationController.navigationBar.tintColor = kTintColor;

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
[[UIApplication sharedApplication] keyWindow].tintColor = nil;
    self.navigationController.navigationBar.tintColor = nil;
}

- (void)loadView {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(tweetSP:)];
        self.navigationItem.rightBarButtonItem.tintColor = kTintColor;
    [super loadView];
    [UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = kTintColor;

}

- (void)tweetSP:(id)sender {
    TWTweetComposeViewController *tweetController = [[TWTweetComposeViewController alloc] init];
    [tweetController setInitialText:kTweetText];
    [self.navigationController presentViewController:tweetController animated:YES completion:nil];
    [tweetController release];
}

- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2 {
    PSTableCell *cell = [super tableView:arg1 cellForRowAtIndexPath:arg2];
((UILabel *)cell.titleLabel).textColor = kTintColor;
return cell;
}
- (void)donate{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=9ZXVHGA5AW5CG&lc=AU&item_name=GreenyDev&currency_code=AUD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted"]];
}
@end

@interface HeaderCell : PSTableCell <PreferencesTableCustomView> {
    UILabel *llLbl;
}

@end

@implementation HeaderCell

- (id)initWithSpecifier:(PSSpecifier *)specifier
{
        self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" specifier:specifier];
        if (self) {

                int width = [[UIScreen mainScreen] bounds].size.width;
                CGRect frame = CGRectMake(0, -15, width, 60);
 
                llLbl = [[UILabel alloc] initWithFrame:frame];
                [llLbl setLineBreakMode:UILineBreakModeWordWrap];
                [llLbl setNumberOfLines:1];
                [llLbl setText:@"NoMotion"];
                [llLbl setBackgroundColor:[UIColor clearColor]];
                [llLbl setTextAlignment:UITextAlignmentCenter];
                llLbl.font = [UIFont fontWithName:@"HelveticaNeue" size: 48];
                llLbl.textColor = kTintColor;

                [self addSubview:llLbl];
                [llLbl release];
        }
        return self;
}
- (CGFloat)preferredHeightForWidth:(CGFloat)arg1
{
    return 20.f;
}

@end

// vim:ft=objc
