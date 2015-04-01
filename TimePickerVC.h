#import <UIKit/UIKit.h>
#import "TimeOfDay.h"
#import "EKVideoController.h"

@interface TimePickerVC : EKVideoController

@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@property TimeOfDay *timeOfDay;

@end
