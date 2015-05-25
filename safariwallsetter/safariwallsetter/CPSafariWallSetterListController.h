#import <Preferences/Preferences.h>
@interface CPSafariWallSetterListController : PSListController
{
	UIStatusBarStyle prevStatusStyle;
}
-(id)specifiersForPlistName:(NSString *)plistName;
@end