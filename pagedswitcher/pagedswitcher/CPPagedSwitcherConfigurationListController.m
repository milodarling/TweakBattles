#import "CPPagedSwitcherConfigurationListController.h"
#import "CPPagedSwitcherPreferences.h"

@implementation CPPagedSwitcherConfigurationListController

-(id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [super specifiersForPlistName:@"PagedSwitcherConfiguration"];
    }
    [self setTitle:[[CPPagedSwitcherLocalizer sharedLocalizer] localizedStringForKey:@"CONFIGURATION"]];
    return _specifiers;
}

- (void)loadView {
    [super loadView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(tweetSupport:)];
}

- (void)tweetSupport:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [composeController setInitialText:@"#PagedSwitcher is awesome!"];
        
        [self presentViewController:composeController animated:YES completion:nil];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            [composeController dismissViewControllerAnimated:YES completion:nil];
        };
        composeController.completionHandler = myBlock;
    }
}

@end