//
//  SettingsVC.m
//  Shnoozle
//
//  Created by Leo on 28/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import "SettingsVC.h"
#import <RESideMenu/RESideMenu.h>
#import "AppDelegate.h"

@interface SettingsVC ()
@property (nonatomic) MPMediaItem *mediaItem;
@property (weak, nonatomic) IBOutlet UILabel *songTitleLabel;
@property (nonatomic, strong) NSURL *chosenSongURL;


@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    _chosenSongURL = [appDelegate chosenSongURL];
    
}

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker
  didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    MPMediaItem *mpMediaItem;
    
    self.mediaItem = nil;
    if (mediaItemCollection.items.count <= 0) {
    }
    
    mpMediaItem = mediaItemCollection.items[0];
    if ([[mpMediaItem valueForProperty:MPMediaItemPropertyIsCloudItem] boolValue]) {
        self.songTitleLabel.text = @"(sorry, not on the device)";
    }
    
    self.mediaItem = mpMediaItem;
    self.songTitleLabel.text = [mpMediaItem valueForProperty:MPMediaItemPropertyTitle];

    

    NSString *songString =[NSString stringWithFormat:@"%@", [mpMediaItem valueForProperty:MPMediaItemPropertyAssetURL]];
    NSURL *songUrl =[NSURL URLWithString:songString];
    
    NSLog(@"selected title: %@", self.songTitleLabel.text);
    NSLog(@"URL: %@", songString);
    
    
    [[NSUserDefaults standardUserDefaults] setObject:songString forKey:@"AlarmSound"];

NSLog(@"ALL DEFAUKTS IN SETTTINGSVC %@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)menuTapped:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
    
    

}

- (IBAction)chooseSong:(id)sender {
    MPMediaPickerController *picker =
    [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    picker.delegate = self;
    picker.allowsPickingMultipleItems = NO;
    picker.showsCloudItems = NO;
    picker.prompt = @"music picker";
    
    [self presentViewController:picker animated:YES completion: nil];
}

@end
