//
//  SafariWallSetter.xm
//  SafariWallSetter
//
//  Created by Juan Carlos Perez on 5/19/15.
//  Copyright (c) 2015 CP Digital Darkroom. All rights reserved.
//
//	TweakBattles
//	https://www.tweakbattles.com
//
//	Thank you everyone who supported this round of TweakBattles, it couldn't have been done without you.
//	
//	Adam M  
//	Andrew Redden  
//	brcleverdon  
//	Bruno Silva  
//	Chairboy  
//	cj81499  
//	Conn  
//	dasfalk  
//	Jason McPherson  
//	JayFreemanBlows  
//	Jon Ware  
//	Julio Salazar  
//	KaseTheAce  
//	Kennedy  
//	Magicka  
//	Mahmood Ma  
//	Matteo Piccina  
//	OVOAustin  
//	pixxaddict  
//	redzrex  
//	Rozersedge  
//	Shadow Games  
//	TwoDaySlate  
//	uroboro
//
//	Spacial Thank to Josh Gibson for his diamond support. Dude you went far beyond what anybody expected.
//	You're an awesome guy and don't ever hesitate to contact me for anything.

//	Now, On to the tweak


typedef NS_ENUM(NSUInteger, PLWallpaperMode) {
	PLWallpaperModeBoth,
	PLWallpaperModeHomeScreen,
	PLWallpaperModeLockScreen
};

@interface PLWallpaperImageViewController : UIViewController {

	int _wallpaperMode;
	BOOL _saveWallpaperData;

}

@property (assign,nonatomic) BOOL saveWallpaperData;
@property PLWallpaperMode wallpaperMode;
-(id)initWithUIImage:(id)arg1 ;
-(void)_savePhoto;
@end


@interface PLStaticWallpaperImageViewController : PLWallpaperImageViewController
@end

@interface _WKElementAction : NSObject
@property (nonatomic, copy) NSString * title; 
-(id)_initWithTitle:(id)arg1 actionHandler:(id)arg2 type:(long long)arg3 ;
@end

PLWallpaperMode wallpaperMode;
static BOOL kEnabled = YES;

%hook _WKElementAction

-(id)_initWithTitle:(id)arg1 actionHandler:(id)arg2 type:(long long)arg3
{
	//Instead of completly removing the Copy button we're simply going to change it's name.
	//This helps in having the image copied to the clipboard so we can save it. 

	if([arg1 isEqualToString:@"Copy"] && kEnabled)
	{
		arg1 = @"Set As Wallpaper";

	}
	return %orig(arg1, arg2, arg3);
}

-(void)_runActionWithElementInfo:(id)arg1 view:(id)arg2
{
	if([self.title isEqualToString:@"Set As Wallpaper"]){
		%orig;
		
		// Let it wait a bit before trying to do this. For some reason if I didn't add this it wouldn't set the wallpaper
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{

			//Get our image from the clipboard
			UIImage *image = [UIPasteboard generalPasteboard].image;


			PLStaticWallpaperImageViewController *wallpaperViewController = [[[PLStaticWallpaperImageViewController alloc] initWithUIImage:image] autorelease];
        	wallpaperViewController.saveWallpaperData = YES;

        	uintptr_t address = (uintptr_t)&wallpaperMode;
        	object_setInstanceVariable(wallpaperViewController, "_wallpaperMode", *(PLWallpaperMode **)address);
        
        	[wallpaperViewController _savePhoto];
        });

	} else //If its not the set wallpaper button do whatever it was it was supposed to do.
	{
		%orig; 
	}
}
%end

static void loadPrefs() {

       NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.cpdigitaldarkroom.safariwallsetter.plist"];
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

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingschanged, CFSTR("com.cpdigitaldarkroom.safariwallsetter/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}