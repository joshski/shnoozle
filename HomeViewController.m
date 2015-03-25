#import "HomeViewController.h"
#import "TimePickerViewController.h"

@interface HomeViewController (){
    BOOL isOn;
}
@end

@implementation HomeViewController

@synthesize datePicker;
@synthesize selectedTimeLabel;
@synthesize titleLabel;
@synthesize alarmToggle;

- (void)viewDidLoad {
    [super viewDidLoad];
    CABasicAnimation *basic=[CABasicAnimation animationWithKeyPath:@"transform"];
    [basic setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.25, 1.25, 1.25)]];
    [basic setAutoreverses:YES];
    [basic setRepeatCount:MAXFLOAT];
    [basic setDuration:0.25];
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

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    TimePickerViewController *source = [segue sourceViewController];
    if (source.timeOfDay != nil) {
        selectedTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (unsigned long)source.timeOfDay.hours, (unsigned long)source.timeOfDay.minutePart];
        titleLabel.text=@"";
        [alarmToggle setOn:YES animated:YES];
        alarmToggle.enabled = true;


    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)changeSwitch:(id)sender{
    if([sender isOn]){
        NSLog(@"Alarm ON!!");
         isOn = true;
    } else{
        NSLog(@"Alarm OFF!!");
    }
}

- (IBAction)switchTapped:(id)sender {
    [self changeSwitch:sender];
}

@end
