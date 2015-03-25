#import "HomeViewController.h"
#import "TimePickerViewController.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

@synthesize datePicker;
@synthesize selectedTimeLabel;
@synthesize titleLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    CABasicAnimation *basic=[CABasicAnimation animationWithKeyPath:@"transform"];
    [basic setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.25, 1.25, 1.25)]];
    [basic setAutoreverses:YES];
    [basic setRepeatCount:MAXFLOAT];
    [basic setDuration:0.25];
    
    if (selectedTimeLabel.text.length > 0) {
        titleLabel.text=@"";
    }
    
    
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    TimePickerViewController *source = [segue sourceViewController];
    if (source.timeOfDay != nil) {
        selectedTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (unsigned long)source.timeOfDay.hours, (unsigned long)source.timeOfDay.minutePart];
        titleLabel.text=@"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
