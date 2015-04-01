#import <UIKit/UIKit.h>
#import "TimeOfDay.h"

@interface TimePickerVC : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@property TimeOfDay *timeOfDay;

@end
