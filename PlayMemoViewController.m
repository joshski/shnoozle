//
//  PlayMemoViewController.m
//  Shnoozle
//
//  Created by Leo on 26/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import "PlayMemoViewController.h"
#import "RecordPlayViewController.h"


@interface PlayMemoViewController ()

@property (strong, nonatomic)  RecordPlayViewController *recordVC;

@end

@implementation PlayMemoViewController


@synthesize memoURL;
@synthesize recordVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"temp sound bla bla bla %@",memoURL);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
