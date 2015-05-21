#import "quickSwipeView.h"
#import <libactivator/libactivator.h>

extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

static UIWindow *quickSwipeWindow;
BOOL alreadyShowingWindow;

@interface QuickSwipe : NSObject<LAListener>
@end

void deconstructAndLaunch(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSLog(@"Some Passed Data:%@", userInfo);
	NSDictionary *dict = (__bridge NSDictionary*)userInfo;
	if ([dict objectForKey:@"key"] != nil)
	{
		NSString *key = [dict objectForKey:@"key"];
		if([key isEqualToString:@"prefs:root=QuickSwipe"])
		{
			[[quickSwipeView sharedQuickSwipeView] closeQuickSwipeView];

			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				alreadyShowingWindow = NO;
    			[quickSwipeWindow removeFromSuperview];
				[quickSwipeWindow release];
				NSURL*url=[NSURL URLWithString:@"prefs:root=QuickSwipe"];
    			[[UIApplication sharedApplication] openURL:url];
			});
		}
	}
}


@implementation QuickSwipe

-(void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
	if(!alreadyShowingWindow)
	{
		alreadyShowingWindow = YES;
		quickSwipeWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        quickSwipeWindow.windowLevel = UIWindowLevelAlert + 2;
        [quickSwipeWindow setHidden:NO];
        [quickSwipeWindow setAlpha:1.0];
        [quickSwipeWindow setBackgroundColor:[UIColor clearColor]];

        [quickSwipeView sharedQuickSwipeView];
		[quickSwipeWindow addSubview:[quickSwipeView sharedQuickSwipeView]];
		[[quickSwipeView sharedQuickSwipeView] openQuickSwipeView];
		[quickSwipeWindow setUserInteractionEnabled:YES];
	}
	else
	{
		alreadyShowingWindow = NO;
		[[quickSwipeView sharedQuickSwipeView] closeQuickSwipeView];

		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    		[quickSwipeWindow removeFromSuperview];
			[quickSwipeWindow release];
		});

		/*[UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void) 
		{

		} 
		completion:^(BOOL finished)
		{
			[quickSwipeWindow removeFromSuperview];
			[quickSwipeWindow release];
    	}];*/
		
	}
	[event setHandled:YES];
}

+(void)load {

	//CFNotificationCenterAddObserver(CFNotificationCenterGetDistributedCenter(), (__bridge const void *)(self), (CFNotificationCallback)deconstructAndLaunch, (CFStringRef)@"com.cpdigitaldarkroom.quickswipe/deconstruct", NULL, CFNotificationSuspensionBehaviorDrop);

	NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"com.cpdigitaldarkroom.quickswipe"];
	[p release];
}

- (NSArray *)activator:(LAActivator *)activator requiresExclusiveAssignmentGroupsForListenerName:(NSString *)listenerName {
    return [NSArray array];
}
@end

/*static void launchSettings(CFNotificationCenterRef center, void *observer,CFStringRef name, const void *object, CFDictionaryRef userInfo) {
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
   	[quickSwipeWindow removeFromSuperview];
	[quickSwipeWindow release];
	});
}*/


%ctor
{
	CFNotificationCenterAddObserver(CFNotificationCenterGetDistributedCenter(), NULL, deconstructAndLaunch, CFSTR("com.cpdigitaldarkroom.quickswipe/deconstruct"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	//CFNotificationCenterAddObserver(CFNotificationCenterGetDistributedCenter(), (__bridge const void *)(self), (CFNotificationCallback)deconstructAndLaunch, (CFStringRef)@"com.cpdigitaldarkroom.quickswipe/deconstruct", NULL, CFNotificationSuspensionBehaviorDrop);
}