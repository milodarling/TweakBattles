#import <flipswitch/Flipswitch.h>

#define kScreenHeight 				[[UIScreen mainScreen] bounds].size.height
#define kScreenWidth 				[[UIScreen mainScreen] bounds].size.width
#define kOuterRingSize  ((kScreenWidth*2)-20)
#define kMiddleRingSize  (kScreenWidth+10)
#define kInnerRingSize  (kScreenWidth/2)

#define kBonBonBundle 				@"/Library/Application Support/BonBon/AndroidButtons.bundle"

@interface quickSwipeView : UIView
@property (nonatomic, assign) UIButton *settingsButton;
@property (nonatomic, assign) UIVisualEffectView *blurEffectView;
@property (nonatomic, assign) UIVisualEffectView *blurEffectView2;
@property (nonatomic, assign) UIVisualEffectView *blurEffectView3;
+(instancetype)sharedQuickSwipeView;
- (void)closeQuickSwipeView;
- (void)openQuickSwipeView;
@end