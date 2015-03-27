//
//  PlayMemoViewController.m
//  Shnoozle
//
//  Created by Leo on 26/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import "PlayMemoVC.h"
#import "RecordMemoVC.h"
#import "HomeVC.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "SCLAlertView.h"

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

- (IBAction)uploadToParseClicked:(id)sender {
    PFObject *testObject = [PFObject objectWithClassName:@"AudioFiles"];
    
    //get the audio in NSData format
    NSData *audioData = [NSData dataWithContentsOfURL:memoURL];
    NSLog(@"audioData being sent.... = %@", audioData);
    
    //create audiofile as a property
    PFFile *audioFile = [PFFile fileWithName:@"audio.caf" data:audioData];
    testObject[@"audioFile"] = audioFile;
    
    //save
    [testObject saveInBackground];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    [alert showSuccess:self title:@"Done" subTitle:@"Finish playing the recording" closeButtonTitle:@"OK" duration:0.0f]; // Notice
}
@end
