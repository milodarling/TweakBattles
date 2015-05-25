//
//  CloudToButt.xm
//  CloudToButt
//
//  Created by Juan Carlos Perez on 5/18/15.
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

static BOOL kEnabled = YES;


// Here we'll hook into UILabels and changed all the cloud strings there to butts. We all love butts.
%hook UILabel

// There is probably a better way of doing this but eh, this is fast and works just as well. 
-(void)setText:(NSString *)arg1
{
	if(kEnabled){
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"iCloud" withString:@"iButt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"the cloud" withString:@"my butt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"Cloudy" withString:@"Butty" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"cloud" withString:@"butt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	}
	%orig(arg1);
}
%end


// Might as well change our icon names to butts, lots of butts on our homescreen are nice.
%hook SBApplication
-(void)setDisplayName:(id)arg1
{
	if(kEnabled){
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"cloud" withString:@"butt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	}
	%orig(arg1);
}
%end

// Be thorough and change all style of icons.
%hook SBBookmarkIcon
-(void) setDisplayName:(id)arg1
{
	if(kEnabled){
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"cloud" withString:@"butt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	}
	%orig(arg1);
}
%end

// Be thorough and change all style of icons.
%hook SBNewsstandFolder 
-(void) setDisplayName:(id)arg1
{
	if(kEnabled){
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"cloud" withString:@"butt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	}
	%orig(arg1);
}
%end

// Be thorough and change all style of icons.
%hook SBFolder 
-(void) setDisplayName:(id)arg1
{
	if(kEnabled){
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"cloud" withString:@"butt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	}
	%orig(arg1);
}
%end

%hook CKTranscriptLabelCell

-(void)setLabel:(UILabel *)arg1
{
	if(kEnabled){
		arg1.text = [arg1.text stringByReplacingOccurrencesOfString:@"iCloud" withString:@"iButt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1.text length])];
		arg1.text = [arg1.text stringByReplacingOccurrencesOfString:@"the cloud" withString:@"my butt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1.text length])];
		arg1.text = [arg1.text stringByReplacingOccurrencesOfString:@"Cloudy" withString:@"Butty" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1.text length])];
		arg1.text = [arg1.text stringByReplacingOccurrencesOfString:@"cloud" withString:@"butt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1.text length])];
	}
	%orig(arg1);
}

%end

%hook UITextView

-(void)setText:(NSString *)arg1
{
	if(kEnabled){
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"iCloud" withString:@"iButt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"the cloud" withString:@"my butt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"Cloudy" withString:@"Butty" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"cloud" withString:@"butt" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	}
	%orig(arg1);
}

%end

static void loadPrefs() {

       NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.cpdigitaldarkroom.cloudtobutt.plist"];
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

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingschanged, CFSTR("com.cpdigitaldarkroom.cloudtobutt/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}