//
//  PlayMemoViewController.m
//  Shnoozle
//
//  Created by Leo on 26/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import "PlayMemoVC.h"
#import "RecordMemoVC.h"


@interface PlayMemoVC ()

{
    AVAudioPlayer *player;
}

@end

@implementation PlayMemoVC


@synthesize memoURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"temp sound bla bla bla %@",memoURL);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playBtnClicked:(id)sender {
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:memoURL error:nil];
    [player setDelegate:self];
    [player play];
}


@end
