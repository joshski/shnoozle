#import "TimePickerVC.h"

@interface TimePickerVC (){
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation TimePickerVC

@synthesize timePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoPath     = [[NSBundle mainBundle] pathForResource:@"clouds" ofType:@"mp4"];
    self.repeat        = YES;
    self.videoSpeed    = 1.0f;
    [self play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if (sender != self.saveButton) return;
   self.timeOfDay = [TimeOfDay timeOfDayFromDate: timePicker.date];
}


@end
