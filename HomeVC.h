//
//  AlarmViewController.h
//  Shnoozle
//
//  Created by Leo on 25/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTHamburgerButton.h>


@interface HomeVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *selectedTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *alarmToggle;
@property (weak, nonatomic) IBOutlet UIView *recordView;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (strong, nonatomic) NSURL *tempMemoURL;
@property (strong, nonatomic) IBOutlet JTHamburgerButton *hamburgerMenuButton;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;



@end
