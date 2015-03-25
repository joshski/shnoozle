#import "HomeViewController.h"
#import "TimePickerViewController.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

@synthesize datePicker;
@synthesize selectedTimeLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    TimePickerViewController *source = [segue sourceViewController];
    if (source.timeOfDay != nil) {
        selectedTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (unsigned long)source.timeOfDay.hours, (unsigned long)source.timeOfDay.minutePart];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
