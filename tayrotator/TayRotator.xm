//
//  TayRotator.xm
//  TayRotator
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



#import <sqlite3.h>

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

static BOOL kEnabled = YES;
static BOOL kShouldRotateSTU = YES;
static BOOL kShouldRotateWallpaper = YES;

static NSString *givemeSomeTaylorDreams(){
    NSMutableArray* files = [[[NSFileManager defaultManager]
                              contentsOfDirectoryAtPath:@"/Library/Application Support/TayRotator/wallpapers" error:nil] mutableCopy];

    for (int i = 0; i < files.count; i++) {
      NSString *file = [files objectAtIndex:i];
      file = [file stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
      [files replaceObjectAtIndex:i withObject:file];
    }

    NSString *returnValue =  [files objectAtIndex:arc4random()%[files count]];
    NSLog(@"returning image named:%@", returnValue);
    return returnValue;
}

static NSString *giveMeSomeTaylorLove() {

	sqlite3 *quoteDatabase = NULL;

	sqlite3_open("/Library/Application Support/TayRotator/quotes.db", &quoteDatabase);
	
	if (!quoteDatabase)
		return @"Error1";
	
	sqlite3_stmt *statement = NULL;
	
	sqlite3_prepare_v2(quoteDatabase, "select count(quote) from quotes;", -1, &statement, NULL);
	
	if (!statement) {
		sqlite3_close(quoteDatabase);
		return @"Error2";
	}

	int count = 0;
	
	while (sqlite3_step(statement) == SQLITE_ROW) {
		
		count = sqlite3_column_int(statement, 0);
		
	}
	
	int where = arc4random() % count;
	
	if (sqlite3_finalize(statement) != SQLITE_OK) {
		sqlite3_close(quoteDatabase);
		return @"Error3";
	}
	
	statement = NULL;
	
	sqlite3_prepare_v2(quoteDatabase, [[NSString stringWithFormat:@"select quote from quotes where id = %i;", where] UTF8String] , -1, &statement, NULL);
	
	if (!statement) {
		sqlite3_close(quoteDatabase);
		return @"Error4";
	}
	
	NSString *zQuote = nil;
	
	while (sqlite3_step(statement) == SQLITE_ROW) {
		
		zQuote = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
		
	}
	
	sqlite3_close(quoteDatabase);
	
	return zQuote ? : @"Error5";
}


%hook SBLockScreenView

- (void)setCustomSlideToUnlockText:(id)arg1 animated:(BOOL)arg2
{
	(kEnabled && kShouldRotateSTU) ? %orig(giveMeSomeTaylorLove(), arg2) : %orig;
}
%end

PLWallpaperMode wallpaperMode;

%hook SBLockScreenViewController

-(void)_handleDisplayTurnedOff
{
    %orig;
    if(!kEnabled)
    	return;

    if(kShouldRotateWallpaper){
    	UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"/Library/Application Support/TayRotator/wallpapers/%@.jpg", givemeSomeTaylorDreams()]];

		PLStaticWallpaperImageViewController *wallpaperViewController = [[[PLStaticWallpaperImageViewController alloc] initWithUIImage:image] autorelease];
        wallpaperViewController.saveWallpaperData = YES;

        uintptr_t address = (uintptr_t)&wallpaperMode;
        object_setInstanceVariable(wallpaperViewController, "_wallpaperMode", *(PLWallpaperMode **)address);
        
        [wallpaperViewController _savePhoto];
    }

}

%end


//Loads Preferences
static void loadPrefs() {

       NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.cpdigitaldarkroom.tayrotator.plist"];
    if(prefs)
    {
        kEnabled = ([prefs objectForKey:@"isEnabled"] ? [[prefs objectForKey:@"isEnabled"] boolValue] : kEnabled);
        kShouldRotateSTU = ([prefs objectForKey:@"shouldRotateSTU"] ? [[prefs objectForKey:@"shouldRotateSTU"] boolValue] : kShouldRotateSTU);
        kShouldRotateWallpaper = ([prefs objectForKey:@"shouldRotateWallpaper"] ? [[prefs objectForKey:@"shouldRotateWallpaper"] boolValue] : kShouldRotateWallpaper);
    }
    [prefs release];
}

static void settingschanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
    loadPrefs();
}

%ctor{

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingschanged, CFSTR("com.cpdigitaldarkroom.tayrotator/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}