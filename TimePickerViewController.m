#import "TimePickerViewController.h"

@interface TimePickerViewController (){
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation TimePickerViewController

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
