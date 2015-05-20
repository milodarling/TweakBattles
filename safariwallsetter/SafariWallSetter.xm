
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
%hook _WKElementAction

-(id)_initWithTitle:(id)arg1 actionHandler:(id)arg2 type:(long long)arg3
{
	//Instead of completly removing the Copy button we're simply going to change it's name.
	//This helps in having the image copied to the clipboard so we can save it. 

	if([arg1 isEqualToString:@"Copy"])
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