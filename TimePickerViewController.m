#import "TimePickerViewController.h"

@interface TimePickerViewController (){
    NSString *selectedTime;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end



@implementation TimePickerViewController

@synthesize timePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self datePickerChanged:timePicker];
    [self.timePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *strTime = [dateFormatter stringFromDate:datePicker.date];
    selectedTime = strTime;
    NSLog(@"%@",strTime);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if (sender != self.saveButton) return;
    
    if (selectedTime.length > 0) {
        self.alarmTime = [[AlarmItem alloc] init];
        self.alarmTime = selectedTime;
    }
}

@end
