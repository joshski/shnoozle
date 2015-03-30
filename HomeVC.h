#import <UIKit/UIKit.h>
#import <JTHamburgerButton.h>
#import "TimeOfDay.h"
#import <RESideMenu/RESideMenu.h>


@interface HomeVC : UIViewController <RESideMenuDelegate, AVAudioRecorderDelegate>
@property (strong, nonatomic) IBOutlet UILabel *selectedTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *alarmToggle;
@property (weak, nonatomic) IBOutlet UIView *recordView;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (strong, nonatomic) NSURL *tempMemoURL;
@property (strong, nonatomic) IBOutlet JTHamburgerButton *hamburgerMenuButton;
@property (strong, nonatomic) TimeOfDay *savedAlarmTime;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@end
