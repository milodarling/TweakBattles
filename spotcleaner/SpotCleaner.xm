//
//  SpotCleaner.xm
//  SpotCleaner
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

#import "SpotCleaner.h"

BOOL kEnabled;

float kRepeatButtonAlpha;
float kShuffleButtonAlpha;
float kSkipNextButtonAlpha;
float kSkipPreviousBttonAlpha;
float kPlayPauseButtonAlpha;

float kTimeRemainingAlpha;
float kDurationSliderAlpha;
float kTimeTakenLabel;

float kSongDetailsAlpha;
float kSaveSongAlpha;
float kSongNameAlpha;
float kArtistNameAlpha;

/*%hook SPTNowPlayingCoverArtViewCell

- (void)layoutSubviews
{
	self.coverArtImageView.frame = CGRectMake(-40,-20,380,420);
	%orig;
}

%end
*/

%hook SPTNowPlayingBaseHeadUnitView

 - (void)addFixedConstraints
 {
 	%orig;
 	if(!kEnabled)
 		return;

 	self.rightAccessoryButton.alpha = kShuffleButtonAlpha; 		//Shuffle Button
	self.leftAccessoryButton.alpha = kRepeatButtonAlpha; 		//Repeat Button
	self.skipToNextButton.alpha = kSkipNextButtonAlpha; 			//Skip Next Button
	self.skipToPreviousButton.alpha = kSkipPreviousBttonAlpha; 		//Skip Previous Button
	self.playPauseButton.alpha = kPlayPauseButtonAlpha; 			//Play Pause Button
	%orig;
 }
 %end

%hook SPTNowPlayingDurationView
- (void)updateConstraints
{
	%orig;
 	if(!kEnabled)
 		return;

	self.timeRemainingLabel.alpha = kTimeRemainingAlpha;			//Time Remaining Label
	self.durationSlider.alpha = kDurationSliderAlpha;				//The track progress slider
	self.timeTakenLabel.alpha = kTimeTakenLabel;				//Track play time Label
}

%end

%hook SPTNowPlayingInformationView

- (void)addConstraints
{
	%orig;
 	if(!kEnabled)
 		return;

	self.labelButton.alpha = 1; //I actually don't know what this label is yet
	self.rightAccessoryButton.alpha = kSongDetailsAlpha; 		// Song Details Button
	self.leftAccessoryButton.alpha = kSaveSongAlpha; 		// Save Song Button
	self.titleLabel.alpha = kSongNameAlpha;					//Song Name Marquee
	self.artistLabel.alpha = kArtistNameAlpha; 				// Artist Name Label
}

%end

//Loads Preferences
static void loadPrefs() {

       NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.cpdigitaldarkroom.spotcleaner.plist"];
    if(prefs)
    {
        kEnabled = ([prefs objectForKey:@"isEnabled"] ? [[prefs objectForKey:@"isEnabled"] boolValue] : NO);
        kShuffleButtonAlpha = ([prefs objectForKey:@"userShuffleButtonAlpha"] ? [[prefs objectForKey:@"userShuffleButtonAlpha"] floatValue] : 1.0);
        kRepeatButtonAlpha = ([prefs objectForKey:@"userRepeatButtonAlpha"] ? [[prefs objectForKey:@"userRepeatButtonAlpha"] floatValue] : 1.0);
        kSkipNextButtonAlpha = ([prefs objectForKey:@"userSkipNextButtonAlpha"] ? [[prefs objectForKey:@"userSkipNextButtonAlpha"] floatValue] : 1.0);
		kSkipPreviousBttonAlpha = ([prefs objectForKey:@"userSkipPreviousButtonAlpha"] ? [[prefs objectForKey:@"userSkipPreviousButtonAlpha"] floatValue] : 1.0);
		kPlayPauseButtonAlpha = ([prefs objectForKey:@"userPlayPauseButtonAlpha"] ? [[prefs objectForKey:@"userPlayPauseButtonAlpha"] floatValue] : 1.0);

		kTimeRemainingAlpha = ([prefs objectForKey:@"userTimeRemainingAlpha"] ? [[prefs objectForKey:@"userTimeRemainingAlpha"] floatValue] : 1.0);
		kDurationSliderAlpha = ([prefs objectForKey:@"userDurationSliderAlpha"] ? [[prefs objectForKey:@"userDurationSliderAlpha"] floatValue] : 1.0);
		kTimeTakenLabel = ([prefs objectForKey:@"userTimeTakenAlpha"] ? [[prefs objectForKey:@"userTimeTakenAlpha"] floatValue] : 1.0);

		kSongDetailsAlpha = ([prefs objectForKey:@"userSongDetailsAlpha"] ? [[prefs objectForKey:@"userSongDetailsAlpha"] floatValue] : 1.0);
		kSaveSongAlpha = ([prefs objectForKey:@"userSaveSongAlpha"] ? [[prefs objectForKey:@"userSaveSongAlpha"] floatValue] : 1.0);
		kSongNameAlpha = ([prefs objectForKey:@"userSongNameAlpha"] ? [[prefs objectForKey:@"userSongNameAlpha"] floatValue] : 1.0);
		kArtistNameAlpha = ([prefs objectForKey:@"userArtistNameAlpha"] ? [[prefs objectForKey:@"userArtistNameAlpha"] floatValue] : 1.0);
    }
    [prefs release];
}

static void settingschanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
    loadPrefs();
}

%ctor{

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingschanged, CFSTR("com.cpdigitaldarkroom.spotcleaner/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}