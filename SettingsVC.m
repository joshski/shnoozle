//
//  SettingsVC.m
//  Shnoozle
//
//  Created by Leo on 28/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import "SettingsVC.h"
#import <RESideMenu/RESideMenu.h>
#import <AVFoundation/AVFoundation.h>
@interface SettingsVC (){
    bool playing;
}
@property (nonatomic) MPMediaItem *mediaItem;
@property (weak, nonatomic) IBOutlet UILabel *songTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *songArtistLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UIButton *playPauseBtn;
@property (weak, nonatomic) IBOutlet UIView *alarmView;

@end

@implementation SettingsVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self labelStates];
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseSong)];
    [_alarmView addGestureRecognizer:tapGesture];

    float volume = [[NSUserDefaults standardUserDefaults]
                           floatForKey:@"AlarmVolume"];
    _slider.value=volume*100;
     playing = NO;
    [_playPauseBtn setBackgroundImage:[UIImage imageNamed:@"playBtn@2x.png"] forState:UIControlStateNormal];
    [self configureAVAudioSession];
}
- (IBAction)sliderValueChanged:(id)sender {
    float volume= _slider.value;
    self.player.volume = volume;

    [[NSUserDefaults standardUserDefaults] setFloat:volume forKey:@"AlarmVolume"];

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

    

    NSString *songPath =[NSString stringWithFormat:@"%@", [mpMediaItem valueForProperty:MPMediaItemPropertyAssetURL]];
    

    
    [[NSUserDefaults standardUserDefaults] setObject:songPath forKey:@"AlarmSound"];
    [[NSUserDefaults standardUserDefaults] setObject:songTitle forKey:@"AlarmSoundTitle"];
    [[NSUserDefaults standardUserDefaults] setObject:songArtist forKey:@"AlarmSoundArtist"];

    [self labelStates];
    [self PlayPause];

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

-(void)PlayPause{
    if (playing==NO) {
        [_playPauseBtn setBackgroundImage:[UIImage imageNamed:@"pause@2x.png"] forState:UIControlStateNormal];
        [self runPlayer];
        playing=YES;
    }
    else if(playing==YES){
        [_playPauseBtn setBackgroundImage:[UIImage imageNamed:@"playBtn@2x.png"] forState:UIControlStateNormal];
        [self.player pause];

        playing=NO;
    }
    
    
}

- (void)runPlayer
{
    
    NSString *songString = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"AlarmSound"];
    
    
    NSURL *url=[NSURL URLWithString:songString];
    if (songString == nil) {
        url=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/alarm1.wav", [[NSBundle mainBundle] resourcePath]]];
        
    }
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    float volume = [[NSUserDefaults standardUserDefaults]
                    floatForKey:@"AlarmVolume"];
    self.player.volume=volume;
    [self.player play];
}
- (IBAction)playPauseTapped:(id)sender {
    [self PlayPause];
    
}

- (IBAction)menuTapped:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
    
    

}

- (IBAction)pickerTapped:(id)sender {
    [self chooseSong];
}


- (void) configureAVAudioSession //To play through main iPhone Speakers
{
    //get your app's audioSession singleton object
    AVAudioSession* session = [AVAudioSession sharedInstance];
    
    //error handling
    BOOL success;
    NSError* error;
    
    //set the audioSession category.
    //Needs to be Record or PlayAndRecord to use audioRouteOverride:
    
    success = [session setCategory:AVAudioSessionCategoryPlayAndRecord
                             error:&error];
    
    if (!success)  NSLog(@"AVAudioSession error setting category:%@",error);
    
    //set the audioSession override
    success = [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker
                                         error:&error];
    if (!success)  NSLog(@"AVAudioSession error overrideOutputAudioPort:%@",error);
    
    //activate the audio session
    success = [session setActive:YES error:&error];
    if (!success) NSLog(@"AVAudioSession error activating: %@",error);
    else NSLog(@"audioSession active");
    
}

@end
