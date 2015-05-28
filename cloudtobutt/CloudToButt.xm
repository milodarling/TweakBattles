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

static NSString *buttify(NSString *text) {
	NSString *result = [text stringByReplacingOccurrencesOfString:@"the cloud" withString:@"my butt"];
	result = [result stringByReplacingOccurrencesOfString:@"the Cloud" withString:@"my Butt"];
	result = [result stringByReplacingOccurrencesOfString:@"The Cloud" withString:@"My Butt"];
	result = [result stringByReplacingOccurrencesOfString:@"The cloud" withString:@"My butt"];
	result = [result stringByReplacingOccurrencesOfString:@"THE CLOUD" withString:@"MY BUTT"];
	return result;
}


// Here we'll hook into UILabels and changed all the cloud strings there to butts. We all love butts.
%hook UILabel

// There is probably a better way of doing this but eh, this is fast and works just as well. 
-(void)setText:(NSString *)arg1
{
	%orig(buttify(arg1));
}
%end


// Might as well change our icon names to butts, lots of butts on our homescreen are nice.
%hook SBApplication
-(void)setDisplayName:(id)arg1
{
	%orig(buttify(arg1));
}
%end

// Be thorough and change all style of icons.
%hook SBBookmarkIcon
-(void) setDisplayName:(id)arg1
{
	%orig(buttify(arg1));
}
%end

// Be thorough and change all style of icons.
%hook SBNewsstandFolder 
-(void) setDisplayName:(id)arg1
{
	%orig(buttify(arg1));
}
%end

// Be thorough and change all style of icons.
%hook SBFolder 
-(void) setDisplayName:(id)arg1
{
	%orig(buttify(arg1));
}
%end

%hook CKTranscriptLabelCell

-(void)setLabel:(UILabel *)arg1
{
	[arg1 setText:buttify(arg1.text)];
	%orig(arg1);
}

%end

%hook UITextView

-(void)setText:(NSString *)arg1
{
	%orig(buttify(arg1));
}

%end