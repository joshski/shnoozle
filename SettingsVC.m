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
@property (nonatomic) MPMediaItem *mediaItem;
@property (weak, nonatomic) IBOutlet UILabel *songTitleLabel;


@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    NSString *songUrl =[mpMediaItem valueForProperty:MPMediaItemPropertyAssetURL];
    NSLog(@"selected title: %@", self.songTitleLabel.text);
    NSLog(@"URL: %@", songUrl);
    
exit:
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
