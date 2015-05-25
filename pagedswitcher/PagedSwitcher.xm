//
//  PagedSwitcher.xm
//  PagedSwitcher
//
//  Created by Juan Carlos Perez on 5/20/15.
//  Copyright (c) 2015 CP Digital Darkroom. All rights reserved.
//
//  TweakBattles
//  https://www.tweakbattles.com
//
//  Thank you everyone who supported this round of TweakBattles, it couldn't have been done without you.
//  
//  Adam M  
//  Andrew Redden  
//  brcleverdon  
//  Bruno Silva  
//  Chairboy  
//  cj81499  
//  Conn  
//  dasfalk  
//  Jason McPherson  
//  JayFreemanBlows  
//  Jon Ware  
//  Julio Salazar  
//  KaseTheAce  
//  Kennedy  
//  Magicka  
//  Mahmood Ma  
//  Matteo Piccina  
//  OVOAustin  
//  pixxaddict  
//  redzrex  
//  Rozersedge  
//  Shadow Games  
//  TwoDaySlate  
//  uroboro
//
//  Spacial Thank to Josh Gibson for his diamond support. Dude you went far beyond what anybody expected.
//  You're an awesome guy and don't ever hesitate to contact me for anything.

//  Now, On to the tweak

@interface SBAppSwitcherScrollView : UIScrollView
@end

@interface SBAppSwitcherPageViewController
{
	SBAppSwitcherScrollView* _scrollView;
}
@end 

static BOOL kEnabled = YES;

%hook SBAppSwitcherPageViewController
-(void)loadView
{
	%orig;
	if(!kEnabled)
		return;
		
	SBAppSwitcherScrollView *slowPagedScrollView = MSHookIvar<SBAppSwitcherScrollView*>(self, "_scrollView");
	[slowPagedScrollView setPagingEnabled:YES];
}

%end

static void loadPrefs() {

       NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.cpdigitaldarkroom.pagedswitcher.plist"];
    if(prefs)
    {
        kEnabled = ([prefs objectForKey:@"isEnabled"] ? [[prefs objectForKey:@"isEnabled"] boolValue] : kEnabled);
    }
    [prefs release];
}

static void settingschanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
    loadPrefs();
}

%ctor{

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingschanged, CFSTR("com.cpdigitaldarkroom.pagedswitcher/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}