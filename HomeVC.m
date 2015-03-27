#import "HomeVC.h"
#import "TimePickerVC.h"
#import "SCLAlertView.h"
#import <RESideMenu/RESideMenu.h>

@interface HomeVC (){
}
@end

@implementation HomeVC



@synthesize datePicker;
@synthesize selectedTimeLabel;
@synthesize titleLabel;
@synthesize alarmToggle;

- (void)viewDidLoad {
    [super viewDidLoad];
    [alarmToggle addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];

    if (selectedTimeLabel.text.length > 0) {
        [alarmToggle setOn:YES animated:YES];
        alarmToggle.enabled = true;
        
    }
    else {
        titleLabel.text=@"No Alarm Set";
        [alarmToggle setOn:NO animated:YES];
        alarmToggle.enabled = FALSE;
        
    }

    
    
}
- (IBAction)menuTapped:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];

}


- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    TimePickerVC *source = [segue sourceViewController];
    if (source.timeOfDay != nil) {
        selectedTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (unsigned long)source.timeOfDay.hours, (unsigned long)source.timeOfDay.minutePart];
        titleLabel.text=@"";
        [alarmToggle setOn:YES animated:YES];
        alarmToggle.enabled = true;
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showSuccess:self title:@"Alarm" subTitle:@"On" closeButtonTitle:@"Done" duration:0.0f]; // Notice


    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)changeSwitch:(id)sender{
    if([sender isOn]){
        
        selectedTimeLabel.textColor=[UIColor colorWithRed:132/255 green:255/255 blue:93/255 alpha:1];
    } else{

        selectedTimeLabel.textColor=[UIColor colorWithRed:255/255 green:132/255 blue:93/255 alpha:1];
    }
}

- (IBAction)switchTapped:(id)sender {
    [self changeSwitch:sender];
}

@end
