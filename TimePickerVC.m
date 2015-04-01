#import "TimePickerVC.h"

@interface TimePickerVC (){
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation TimePickerVC

@synthesize timePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if (sender != self.saveButton) return;
   self.timeOfDay = [TimeOfDay timeOfDayFromDate: timePicker.date];
}


@end
