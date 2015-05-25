#import <Preferences/Preferences.h>
@interface CPPagedSwitcherListController : PSListController
{
	UIStatusBarStyle prevStatusStyle;
}
-(id)specifiersForPlistName:(NSString *)plistName;
@end