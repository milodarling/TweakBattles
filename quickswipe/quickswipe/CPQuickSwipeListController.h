#import <Preferences/Preferences.h>
@interface CPQuickSwipeListController : PSListController
{
	UIStatusBarStyle prevStatusStyle;
}
-(id)specifiersForPlistName:(NSString *)plistName;
@end