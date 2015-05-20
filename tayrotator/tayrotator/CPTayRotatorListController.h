#import <Preferences/Preferences.h>
@interface CPTayRotatorListController : PSListController
{
	UIStatusBarStyle prevStatusStyle;
}
-(id)specifiersForPlistName:(NSString *)plistName;
@end