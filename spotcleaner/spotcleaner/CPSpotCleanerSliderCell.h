#import <Preferences/Preferences.h>
#import <Preferences/PSSliderTableCell.h>
@interface CPSpotCleanerSliderCell : PSSliderTableCell <UIAlertViewDelegate, UITextFieldDelegate> {
  CGFloat minimumValue;
  CGFloat maximumValue;
}
-(void)presentPopup;
@end