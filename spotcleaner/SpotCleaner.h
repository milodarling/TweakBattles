@interface SPTNowPlayingButton : UIButton
@end

@interface SPTNowPlayingBaseHeadUnitView : UIView
@property(retain, nonatomic) SPTNowPlayingButton *rightAccessoryButton; // @synthesize rightAccessoryButton=_rightAccessoryButton;
@property(retain, nonatomic) SPTNowPlayingButton *leftAccessoryButton; // @synthesize leftAccessoryButton=_leftAccessoryButton;
@property(retain, nonatomic) SPTNowPlayingButton *skipToNextButton; // @synthesize skipToNextButton=_skipToNextButton;
@property(retain, nonatomic) SPTNowPlayingButton *skipToPreviousButton; // @synthesize skipToPreviousButton=_skipToPreviousButton;
@property(retain, nonatomic) SPTNowPlayingButton *playPauseButton;
@end

@interface SPTNowPlayingSlider : UISlider
@end

@interface SPTNowPlayingDurationView : UIView
@property(retain, nonatomic) UILabel *timeRemainingLabel;
@property(retain, nonatomic) SPTNowPlayingSlider *durationSlider;
@property(retain, nonatomic) UILabel *timeTakenLabel;
@end

@interface SPTNowPlayingMarqueeLabel : UILabel
@end

@interface SPTNowPlayingInformationView : UIView
@property(readonly, nonatomic) SPTNowPlayingMarqueeLabel *artistLabel;
@property(readonly, nonatomic) SPTNowPlayingMarqueeLabel *titleLabel;
@property(retain, nonatomic) UIButton *labelButton;
@property(retain, nonatomic) UIButton *rightAccessoryButton;
@property(retain, nonatomic) UIButton *leftAccessoryButton; 
@end

@interface SPTNowPlayingCoverArtView : UIView 
@end

@interface SPTNowPlayingCoverArtViewCell : UIView
@property(retain, nonatomic) UIImageView *coverArtImageView;
@property(retain, nonatomic) UIImageView *placeholderImageView;

@end