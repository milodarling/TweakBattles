#import "CPQuickSwipeListController.h"
#import "CPQuickSwipePreferences.h"

#define tweakSettingsPath @"/User/Library/Preferences/com.cpdigitaldarkroom.quickswipe.plist"


@implementation CPQuickSwipeListController

- (id)specifiersForPlistName:(NSString *)plistName {
    NSArray *specs = [[self loadSpecifiersFromPlistName:plistName target:self] retain];
    return [[CPQuickSwipeLocalizer sharedLocalizer] localizedSpecifiersForSpecifiers:specs];
}

-(id) readPreferenceValue:(PSSpecifier*)specifier {
    NSDictionary *tweakSettings = [NSDictionary dictionaryWithContentsOfFile:tweakSettingsPath];
    if (!tweakSettings[specifier.properties[@"key"]]) {
        return specifier.properties[@"default"];
    }
    return tweakSettings[specifier.properties[@"key"]];
}
 
-(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:tweakSettingsPath]];
    [defaults setObject:value forKey:specifier.properties[@"key"]];
    [defaults writeToFile:tweakSettingsPath atomically:YES];
    CFStringRef tweakPost = (CFStringRef)specifier.properties[@"PostNotification"];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), tweakPost, NULL, NULL, YES);
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if (iOS8) {
        self.navigationController.navigationController.navigationBar.tintColor = MAIN_TINTCOLOR;
    } else {
        self.navigationController.navigationBar.tintColor = MAIN_TINTCOLOR;
    }

    [UISwitch appearanceWhenContainedIn:self.class, nil].onTintColor = SWITCH_TINTCOLOR;
    [UISegmentedControl appearanceWhenContainedIn:self.class, nil].tintColor = MAIN_TINTCOLOR;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if (iOS8) {
        self.navigationController.navigationController.navigationBar.tintColor = nil;
    } else {
        self.navigationController.navigationBar.tintColor = nil;
    }
}

- (PSTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PSTableCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    ((UILabel *)cell.titleLabel).textColor = LABEL_TINTCOLOR;
    return cell;
}

@end