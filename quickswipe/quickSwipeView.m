#import "quickSwipeView.h"
#import "QuickSwipe.h"
#import <objc/runtime.h>
#import <substrate.h>

extern CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

inline void launchAppAndDeconstructWithApp(NSString *app)
{
    CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(), CFSTR("com.cpdigitaldarkroom.quickswipe/deconstruct"), NULL, (__bridge CFDictionaryRef) @{
        @"key": app,
    }, true);
}

@implementation quickSwipeView

+(instancetype)sharedQuickSwipeView {
	static dispatch_once_t p = 0;

	__strong static id _sharedSelf = nil;

	dispatch_once(&p,^{
		_sharedSelf = [[self alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
	});

	return _sharedSelf;
}

- (UIImage *)filledImageFrom:(UIImage *)source withColor:(UIColor *)color{

    // begin a new image context, to draw our colored image onto with the right scale
    UIGraphicsBeginImageContextWithOptions(source.size, NO, [UIScreen mainScreen].scale);

    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();

    // set the fill color
    [color setFill];

    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, source.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, source.size.width, source.size.height);
    CGContextDrawImage(context, rect, source.CGImage);

    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);

    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    //return the color-burned image
    return coloredImg;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if (self) 
	{

		UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
		self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
			[self.blurEffectView setFrame:CGRectMake(0,kScreenHeight,0,0)];
			self.blurEffectView.layer.cornerRadius = kOuterRingSize/2;
			self.blurEffectView.layer.masksToBounds = YES;
			self.blurEffectView.layer.shadowOffset = CGSizeMake(10, -6);
			self.blurEffectView.layer.shadowRadius = 3;
			self.blurEffectView.layer.shadowOpacity = 0.7;

		SBApplication *facebookApp = [[objc_getClass("SBApplicationController") sharedInstance] applicationWithBundleIdentifier:@"com.facebook.Facebook"]; //[[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:com.apple.Music];
		SBIcon *facebookIcon = [[[objc_getClass("SBIconViewMap") homescreenMap] iconModel] applicationIconForBundleIdentifier:facebookApp.bundleIdentifier];// [[[%c(SBIconViewMap) homescreenMap] iconModel] applicationIconForBundleIdentifier:app.bundleIdentifier];
        	SBIconView *facebookIconView = [[objc_getClass("SBIconViewMap") homescreenMap] _iconViewForIcon:facebookIcon];// [[%c(SBIconViewMap) homescreenMap] _iconViewForIcon:icon];
        	facebookIconView.frame = CGRectMake((kMiddleRingSize/2)+160, 40, facebookIconView.frame.size.width-20, facebookIconView.frame.size.height-20);
        	[self.blurEffectView addSubview:facebookIconView];

        	SBApplication *spotifyApp = [[objc_getClass("SBApplicationController") sharedInstance] applicationWithBundleIdentifier:@"com.spotify.client"]; //[[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:com.apple.Music];
		SBIcon *spotifyIcon = [[[objc_getClass("SBIconViewMap") homescreenMap] iconModel] applicationIconForBundleIdentifier:spotifyApp.bundleIdentifier];// [[[%c(SBIconViewMap) homescreenMap] iconModel] applicationIconForBundleIdentifier:app.bundleIdentifier];
        	SBIconView *spotifyIconView = [[objc_getClass("SBIconViewMap") homescreenMap] _iconViewForIcon:spotifyIcon];// [[%c(SBIconViewMap) homescreenMap] _iconViewForIcon:icon];
		spotifyIconView.frame = CGRectMake((kMiddleRingSize/2)+240, 80, spotifyIconView.frame.size.width, spotifyIconView.frame.size.height);
        	[self.blurEffectView addSubview:spotifyIconView];

        	SBApplication *alienBlueApp = [[objc_getClass("SBApplicationController") sharedInstance] applicationWithBundleIdentifier:@"com.reddit.alienblue"]; //[[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:com.apple.Music];
		SBIcon *alienBlueIcon = [[[objc_getClass("SBIconViewMap") homescreenMap] iconModel] applicationIconForBundleIdentifier:alienBlueApp.bundleIdentifier];// [[[%c(SBIconViewMap) homescreenMap] iconModel] applicationIconForBundleIdentifier:app.bundleIdentifier];
        	SBIconView *alienBlueIconView = [[objc_getClass("SBIconViewMap") homescreenMap] _iconViewForIcon:alienBlueIcon];// [[%c(SBIconViewMap) homescreenMap] _iconViewForIcon:icon];
        	alienBlueIconView.frame = CGRectMake((kMiddleRingSize/2)+310, 130, alienBlueIconView.frame.size.width, alienBlueIconView.frame.size.height);
        	[self.blurEffectView addSubview:alienBlueIconView];

        	SBApplication *safariApp = [[objc_getClass("SBApplicationController") sharedInstance] applicationWithBundleIdentifier:@"com.apple.mobilesafari"]; //[[%c(SBApplicationController) sharedInstance] applicationWithBundleIdentifier:com.apple.Music];
		SBIcon *safariIcon = [[[objc_getClass("SBIconViewMap") homescreenMap] iconModel] applicationIconForBundleIdentifier:safariApp.bundleIdentifier];// [[[%c(SBIconViewMap) homescreenMap] iconModel] applicationIconForBundleIdentifier:app.bundleIdentifier];
        	SBIconView *safariIconView = [[objc_getClass("SBIconViewMap") homescreenMap] _iconViewForIcon:safariIcon];// [[%c(SBIconViewMap) homescreenMap] _iconViewForIcon:icon];
        	safariIconView.frame = CGRectMake((kMiddleRingSize/2)+350, 220, safariIconView.frame.size.width, safariIconView.frame.size.height);
        	[self.blurEffectView addSubview:safariIconView];


		UIBlurEffect *blurEffect2 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
		self.blurEffectView2 = [[UIVisualEffectView alloc] initWithEffect:blurEffect2];
			[self.blurEffectView2 setFrame:CGRectMake(0,kScreenHeight,0,0)];
			self.blurEffectView2.layer.cornerRadius = kMiddleRingSize/2;
			self.blurEffectView2.layer.masksToBounds = YES;
			self.blurEffectView2.layer.shadowOffset = CGSizeMake(10, -6);
			self.blurEffectView2.layer.shadowRadius = 3;
			self.blurEffectView2.layer.shadowOpacity = 0.7;

		UIBlurEffect *blurEffect3 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
		self.blurEffectView3 = [[UIVisualEffectView alloc] initWithEffect:blurEffect3];
			[self.blurEffectView3 setCenter:CGPointMake(0,kScreenHeight)];
			[self.blurEffectView3 setFrame:CGRectMake(0,kScreenHeight,0,0)];
			self.blurEffectView3.layer.cornerRadius = kInnerRingSize/2;
			self.blurEffectView3.layer.masksToBounds = YES;
			self.blurEffectView3.layer.shadowOffset = CGSizeMake(10, -6);
			self.blurEffectView3.layer.shadowRadius = 3;
			self.blurEffectView3.layer.shadowOpacity = 0.7;

		self.settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
		UIImage *settingsButtonImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle bundleWithPath:kBonBonBundle] pathForResource:@"settingsButton" ofType:@"png"]];
    		self.settingsButton.frame = CGRectMake((kInnerRingSize/2)+5, +20, settingsButtonImage.size.width, settingsButtonImage.size.height);
    		[self.settingsButton addTarget:self action:@selector(toogleSwitchWithID:) forControlEvents:UIControlEventTouchUpInside];
    	
		[self.settingsButton setImage:[self filledImageFrom:settingsButtonImage  withColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    		self.settingsButton.tag = 1;
    		[self.blurEffectView3 addSubview:self.settingsButton];

		[self addSubview:self.blurEffectView];
		[self addSubview:self.blurEffectView2];
		[self addSubview:self.blurEffectView3];

	}

	return self;
}

- (void)closeQuickSwipeView
{
	[UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) 
	{
		SBIconListView *currentIcons = [[objc_getClass("SBIconController") sharedInstance] currentRootIconList]; //[[%c(SBIconController) sharedInstance] currentRootIconList];
        currentIcons.alpha = 1.0;

		self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0];

		[self.blurEffectView setFrame:CGRectMake(0,kScreenHeight,0,0)];
		self.blurEffectView.layer.cornerRadius = kOuterRingSize/2;

		[self.blurEffectView2 setFrame:CGRectMake(0,kScreenHeight,0,0)];
		self.blurEffectView2.layer.cornerRadius = kMiddleRingSize/2;

		[self.blurEffectView3 setFrame:CGRectMake(0,kScreenHeight,0,0)];
		self.blurEffectView3.layer.cornerRadius = kInnerRingSize/2;
	} 
	completion:^(BOOL finished)
	{
    }];
    
}

- (void)openQuickSwipeView
{
	[UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) 
	{
		SBIconListView *currentIcons = [[objc_getClass("SBIconController") sharedInstance] currentRootIconList];
        currentIcons.alpha = 0.3;

		self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];

		[self.blurEffectView setFrame:CGRectMake(-(kOuterRingSize/2),kScreenHeight-(kOuterRingSize/2),kOuterRingSize,kOuterRingSize)];
		self.blurEffectView.layer.cornerRadius = kOuterRingSize/2;

		[self.blurEffectView2 setFrame:CGRectMake(-(kMiddleRingSize/2),kScreenHeight-(kMiddleRingSize/2),kMiddleRingSize,kMiddleRingSize)];
		self.blurEffectView2.layer.cornerRadius = kMiddleRingSize/2;

		[self.blurEffectView3 setFrame:CGRectMake(-(kInnerRingSize/2),kScreenHeight-(kInnerRingSize/2),kInnerRingSize,kInnerRingSize)];
		self.blurEffectView3.layer.cornerRadius = kInnerRingSize/2;
	} 
	completion:^(BOOL finished)
	{
    }];

}

- (void)toogleSwitchWithID:(id)sender
{
	//NSURL*url=[NSURL URLWithString:@"prefs:root=QuickSwipe"];
    //[[UIApplication sharedApplication] openURL:url];
     launchAppAndDeconstructWithApp(@"prefs:root=QuickSwipe");
}
@end
