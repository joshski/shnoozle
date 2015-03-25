//
//  AlarmViewController.m
//  Shnoozle
//
//  Created by Leo on 25/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import "AddAlarmViewController.h"

@interface AddAlarmViewController ()

@end



@implementation AddAlarmViewController

@synthesize datePicker;
@synthesize selectedDate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];

}

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    self.selectedDate.text = strDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
