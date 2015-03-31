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
    MPMediaItem *i;
    
    self.mediaItem = nil;
    if (mediaItemCollection.items.count <= 0) {
        goto exit;
    }
    
    i = mediaItemCollection.items[0];
    if ([[i valueForProperty:MPMediaItemPropertyIsCloudItem] boolValue]) {
        self.songTitleLabel.text = @"(sorry, not on the device)";
        goto exit;
    }
    
    self.mediaItem = i;
    self.songTitleLabel.text = [i valueForProperty:MPMediaItemPropertyTitle];
    NSLog(@"selected title: %@", self.songTitleLabel.text);
    NSLog(@"URL: %@", [i valueForProperty:MPMediaItemPropertyAssetURL]);
    
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
