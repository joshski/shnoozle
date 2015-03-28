//
//  SettingsVC.m
//  Shnoozle
//
//  Created by Leo on 28/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import "SettingsVC.h"
#import <RESideMenu/RESideMenu.h>

@interface SettingsVC ()

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuTapped:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];

}



@end
