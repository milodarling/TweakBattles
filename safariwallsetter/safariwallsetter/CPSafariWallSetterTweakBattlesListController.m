#import "CPSafariWallSetterTweakBattlesListController.h"
#import "CPSafariWallSetterPreferences.h"

@implementation CPSafariWallSetterTweakBattlesListController

-(id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [super specifiersForPlistName:@"SafariWallSetterTweakBattles"];
    }
    [self setTitle:[[CPSafariWallSetterLocalizer sharedLocalizer] localizedStringForKey:@"TweakBattles"]];
    return _specifiers;
}

- (void)loadView {
    [super loadView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(tweetSupport:)];
}

- (void)tweetSupport:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [composeController setInitialText:@"#SafariWallSetter makes settings a wallpaper easy from Safari, thanks @CPDigDarkroom"];
        
        [self presentViewController:composeController animated:YES completion:nil];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            [composeController dismissViewControllerAnimated:YES completion:nil];
        };
        composeController.completionHandler = myBlock;
    }
}

- (void)openCloud2Butt {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.cpdigitaldarkroom.cloud2butt"]];
}
- (void)openSafariWallSetter {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.cpdigitaldarkroom.safariwallsetter"]];
}
- (void)openTayRotator {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.cpdigitaldarkroom.tayrotator"]];
}
- (void)openPagedSwitcher {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.cpdigitaldarkroom.pagedswitcher"]];
}
- (void)openSpotCleaner {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.cpdigitaldarkroom.spotcleaner"]];
}

@end