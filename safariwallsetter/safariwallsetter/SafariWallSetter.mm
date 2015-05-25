#import "CPSafariWallSetterLogoTableCell.h"
#import "CPSafariWallSetterCustomHeaderView.h"
#import "CPSafariWallSetterPreferences.h"
#import <MobileGestalt/MobileGestalt.h>

@interface SafariWallSetterListController: CPSafariWallSetterListController <MFMailComposeViewControllerDelegate>{
}
@end

@implementation SafariWallSetterListController
-(id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [super specifiersForPlistName:@"SafariWallSetter"];
    }
    return _specifiers;
}

- (void)loadView {
    [super loadView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(tweetSupport:)];
}

-(void)viewDidLoad {
    UIImage *icon = [[UIImage alloc] initWithContentsOfFile:HEADER_ICON];
    icon = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:icon];
    self.navigationItem.titleView = iconView;
    self.navigationItem.titleView.alpha = 0;

    [super viewDidLoad];

    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(increaseAlpha)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)increaseAlpha {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.navigationItem.titleView.alpha = 1;
                }completion:nil];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return (UIView *)[[CPSafariWallSetterCustomHeaderView alloc] init];
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return (UIView *)[[CPSafariWallSetterLogoTableCell alloc] init];
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 140.f;
    }
    return (CGFloat)-1;
}

- (void)emailCP {
    MFMailComposeViewController *emailCP = [[MFMailComposeViewController alloc] init];
    [emailCP setSubject:@"SafariWallSetter Support"];
    [emailCP setToRecipients:[NSArray arrayWithObjects:@"CP Digital Darkroom <tweaks@cpdigitaldarkroom.support>", nil]];

    NSString *product = nil, *version = nil, *build = nil;

    
        product = (NSString *)MGCopyAnswer(kMGProductType);
        version = (NSString *)MGCopyAnswer(kMGProductVersion);
        build = (NSString *)MGCopyAnswer(kMGBuildVersion);

    [emailCP setMessageBody:[NSString stringWithFormat:@"\n\nCurrent Device: %@, iOS %@ (%@)", product, version, build] isHTML:NO];

    [emailCP addAttachmentData:[NSData dataWithContentsOfFile:@"/var/mobile//Library/Preferences/com.cpdigitaldarkroom.safariwallsetter.plist"] mimeType:@"application/xml" fileName:@"SafariWallSetterPrefs.plist"];
    system("/usr/bin/dpkg -l >/tmp/dpkgl.log");
    [emailCP addAttachmentData:[NSData dataWithContentsOfFile:@"/tmp/dpkgl.log"] mimeType:@"text/plain" fileName:@"dpkgl.txt"];
    [self.navigationController presentViewController:emailCP animated:YES completion:nil];
    emailCP.mailComposeDelegate = self;
    [emailCP release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end