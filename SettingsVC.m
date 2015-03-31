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
@property (weak, nonatomic) IBOutlet UILabel *songArtistLabel;


@end

@implementation SettingsVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self labelStates];
    
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
    NSString *songTitle=[mpMediaItem valueForProperty:MPMediaItemPropertyTitle];
    NSString *songArtist=[mpMediaItem valueForProperty:MPMediaItemPropertyArtist];

    self.songTitleLabel.text =songTitle;

    

    NSString *songPath =[NSString stringWithFormat:@"%@", [mpMediaItem valueForProperty:MPMediaItemPropertyAssetURL]];
    

    
    [[NSUserDefaults standardUserDefaults] setObject:songPath forKey:@"AlarmSound"];
    [[NSUserDefaults standardUserDefaults] setObject:songTitle forKey:@"AlarmSoundTitle"];
    [[NSUserDefaults standardUserDefaults] setObject:songArtist forKey:@"AlarmSoundArtist"];



    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)chooseSong
{
    MPMediaPickerController *picker =
    [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    picker.delegate = self;
    picker.allowsPickingMultipleItems = NO;
    picker.showsCloudItems = NO;
    picker.prompt = @"music picker";
    
    [self presentViewController:picker animated:YES completion: nil];
}
- (void)labelStates {
    //    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //    _chosenSongURL = [appDelegate chosenSongURL];
    NSString *songTitle = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"AlarmSoundTitle"];
    NSString *songArtist = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"AlarmSoundArtist"];
    
    if (songTitle.length < 1) {
        self.songTitleLabel.text = @"Default Tone";
        
    }
    else {
        self.songTitleLabel.text = songTitle;
        
    }
    if (songArtist.length < 1) {
        self.songArtistLabel.text =@"No Artist Info";
        
    }
    else {
        self.songArtistLabel.text = songArtist;
        
    }

}

- (IBAction)menuTapped:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
    
    

}

- (IBAction)pickerTapped:(id)sender {
    [self chooseSong];
}




@end
