//
//  AlarmViewController.m
//  Shnoozle
//
//  Created by Leo on 25/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import "HomeViewController.h"
#import "AlarmItem.h"

@interface HomeViewController ()

@property NSMutableArray *alarmItems;

@end



@implementation HomeViewController

@synthesize datePicker;
@synthesize selectedDate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    self.alarmItems =[[NSMutableArray alloc]init];
    [self loadInitialData];
    

}
- (void)loadInitialData {
    AlarmItem *item1 = [[AlarmItem alloc] init];
    item1.alarmDate = @"Buy milk";
    [self.alarmItems addObject:item1];
    AlarmItem *item2 = [[AlarmItem alloc] init];
    item2.alarmDate = @"Buy eggs";
    [self.alarmItems addObject:item2];
    AlarmItem *item3 = [[AlarmItem alloc] init];
    item3.alarmDate = @"Read a book";
    [self.alarmItems addObject:item3];
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



@end
