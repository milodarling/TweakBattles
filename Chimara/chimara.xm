@interface SBLockScreenView
@property (nonatomic,readonly) UIScrollView * scrollView;    
@end

@interface MPUNowPlayingIndicatorView : UIControl
@end

@interface MusicNowPlayingIndicatorView :MPUNowPlayingIndicatorView
@end

%hook SBLockScreenView

- (void)addGrabberViews
{
%orig;
  MusicNowPlayingIndicatorView *quicklaunch = [[NSClassFromString(@"MusicNowPlayingIndicatorView") alloc] init];
	[quicklaunch setFrame:CGRectMake(320,50,50,50)];
	[self.scrollView addSubview:quicklaunch];
}

%end
