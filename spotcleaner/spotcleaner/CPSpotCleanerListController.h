#import <Preferences/Preferences.h>
@interface CPSpotCleanerListController : PSListController
{
	UIStatusBarStyle prevStatusStyle;
}
-(id)specifiersForPlistName:(NSString *)plistName;
@end