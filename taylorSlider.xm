#define IMAGE_PATH @"/Library/PreferenceBundles/TayRotator.bundle/TayRotator@2x.png"

%hook UISlider

-(id)initWithFrame:(CGRect)frame {

	self = %orig;

	if (self) {
		[self setThumbImage:[UIImage imageWithContentsOfFile:IMAGE_PATH] forState:UIControlStateNormal];
	}

	return self;
}

-(id)init {

	self = %orig;

	if (self) {
		[self setThumbImage:[UIImage imageWithContentsOfFile:IMAGE_PATH] forState:UIControlStateNormal];
	}

	return self;
}

-(id)initWithCoder:(NSCoder *)coder {

	self = %orig;

	if (self) {
		[self setThumbImage:[UIImage imageWithContentsOfFile:IMAGE_PATH] forState:UIControlStateNormal];
	}

	return self;
}

- (UIImage *)thumbImageForState:(UIControlState)state {

	UIImage *burgerImage = [UIImage imageWithContentsOfFile:IMAGE_PATH];

	if (burgerImage == nil) {
		return %orig;
	} 
	
	return burgerImage;
}

- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state {

	UIImage *burgerImage = [UIImage imageWithContentsOfFile:IMAGE_PATH];

	if (burgerImage == nil) {
		%orig(image,state);
	} else {
		%orig(burgerImage,state);
	}

}

%end
