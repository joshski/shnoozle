//
//  TimePickerViewController.h
//  Shnoozle
//
//  Created by Leo on 25/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmItem.h"


@interface TimePickerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@property AlarmItem *alarmTime;

@end
