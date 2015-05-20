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

%end
