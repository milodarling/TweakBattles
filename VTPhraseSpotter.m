@interface VTPhraseSpotter
{
NSArray* _triggerPhrases;
}
@end


%hook VTPhraseSpotter
-(void)_checkSiriIsActive

{
 %orig;
 NSArray *phraseArray = MSHookIvar<NSArray*>(self, "_triggerPhrases");
 NSLog(@"Phrase Spotter Active, Phrases %@", phraseArray);
}

+(void)initialize
{
%orig;
 NSArray *phraseArray = MSHookIvar<NSArray*>(self, "_triggerPhrases");
 NSLog(@"Phrase Spotter Active, Phrases %@", phraseArray);
 }
-(id)initWithHardwareSampleRate:(double)arg1
{
 NSArray *phraseArray = MSHookIvar<NSArray*>(self, "_triggerPhrases");
 NSLog(@"Phrase Spotter Active, Phrases %@", phraseArray);
 return %orig;
 }
-(id)analyze:(AudioBuffer*)arg1
{

 NSArray *phraseArray = MSHookIvar<NSArray*>(self, "_triggerPhrases");
 NSLog(@"Phrase Spotter Active, Phrases %@", phraseArray);
  return %orig;
 }

-(void)dealloc
{
%orig;
 NSArray *phraseArray = MSHookIvar<NSArray*>(self, "_triggerPhrases");
 NSLog(@"Phrase Spotter Active, Phrases %@", phraseArray);
 }
-(id)init
{
%orig;
 NSArray *phraseArray = MSHookIvar<NSArray*>(self, "_triggerPhrases");
 NSLog(@"Phrase Spotter Active, Phrases %@", phraseArray);
 }

-(void)_commonInit
{
%orig;
 NSArray *phraseArray = MSHookIvar<NSArray*>(self, "_triggerPhrases");
 NSLog(@"Phrase Spotter Active, Phrases %@", phraseArray);
 }
 

-(void)_listenForSuggestedThreshold
{
%orig;
 NSArray *phraseArray = MSHookIvar<NSArray*>(self, "_triggerPhrases");
 NSLog(@"Phrase Spotter Active, Phrases %@", phraseArray);
 }

-(id)_analyzeEvents:(const ndresult*)arg1
{

 NSArray *phraseArray = MSHookIvar<NSArray*>(self, "_triggerPhrases");
 NSLog(@"Phrase Spotter Active, Phrases %@", phraseArray);
 return %orig;
 }
-(void)_analyzeReset;
-(id)_analyzeMakeResult:(const ndresult*)arg1 isNearMiss:(BOOL)arg2 isSecondChance:(BOOL)arg3 effectiveThreshold:(double)arg4 ;
-(void)_logMetaData:(id)arg1
{
 NSArray *phraseArray = MSHookIvar<NSArray*>(self, "_triggerPhrases");
 NSLog(@"Phrase Spotter Active, Phrases %@", phraseArray);
  %orig;
 }

-(id)initWithConfig:(id)arg1 resourcePath:(id)arg2 triggerThreshold:(double)arg3
{
 NSArray *phraseArray = MSHookIvar<NSArray*>(self, "_triggerPhrases");
 NSLog(@"Phrase Spotter Active, Phrases %@", phraseArray);
  return %orig;
  }


%end
