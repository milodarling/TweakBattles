#import <Preferences/Preferences.h>
@interface CPCloudToButtListController : PSListController
{
	UIStatusBarStyle prevStatusStyle;
}
-(id)specifiersForPlistName:(NSString *)plistName;
@end