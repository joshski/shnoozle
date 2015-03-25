//
//  AlarmViewController.m
//  Shnoozle
//
//  Created by Leo on 25/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import "HomeViewController.h"
#import "AlarmItem.h"
#import "TimePickerViewController.h"

@interface HomeViewController ()

@property NSMutableArray *alarmItems;

@end



@implementation HomeViewController

@synthesize datePicker;
@synthesize selectedDate;

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    TimePickerViewController *source = [segue sourceViewController];
    AlarmItem *item = source.alarmTime;
    if (item != nil) {
        selectedDate.text = item;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
