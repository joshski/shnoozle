#import <UIKit/UIKit.h>
#import "TimeOfDay.h"
#import <RESideMenu/RESideMenu.h>
#import "EKVideoController.h"
#import "MZTimerLabel.h"


@interface HomeVC : EKVideoController <RESideMenuDelegate,MZTimerLabelDelegate>
@property (strong, nonatomic) IBOutlet UILabel *selectedTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *alarmToggle;
@property (weak, nonatomic) IBOutlet UIView *recordView;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (strong, nonatomic) NSURL *tempMemoURL;
@property (strong, nonatomic) IBOutlet UIButton *MenuButton;
@property (strong, nonatomic) TimeOfDay *savedAlarmTime;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@end
