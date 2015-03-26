

#import "RecordPlayViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SCLAlertView.h"
#import "PlayMemoViewController.h"
@interface RecordPlayViewController (){
    AVAudioRecorder *recorder;
    NSTimer *timer;

}

@end

@implementation RecordPlayViewController


@synthesize recordButton;
@synthesize recordView;

@synthesize tempSoundStorage;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self recorderSettings];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)recorderSettings {
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord
             withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
                   error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
}



- (IBAction)uploadToParseClicked:(id)sender {
    PFObject *testObject = [PFObject objectWithClassName:@"AudioFiles"];
    
    //get the audio in NSData format
    NSData *audioData = [NSData dataWithContentsOfURL:tempSoundStorage];
    NSLog(@"audioData = %@", audioData);
    
    //create audiofile as a property
    PFFile *audioFile = [PFFile fileWithName:@"audio.caf" data:audioData];
    testObject[@"audioFile"] = audioFile;
    
    //save
    [testObject saveInBackground];
}




- (IBAction)recordTouchDown:(id)sender {

    [recorder recordForDuration:30];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(updateTime)
                                           userInfo:nil
                                            repeats:YES];
    NSLog(@"started started");

}
-(void)updateTime
{
    //Get the time left until the specified date
    NSInteger seconds = 30;

    
    //Update the label with the remaining time
    self.timerLabel.text = [NSString stringWithFormat:@"%02li sec",(long)seconds];
}


- (IBAction)recordTouchUp:(id)sender {
    [recorder stop];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"tmpSound.caf"];
    
    self.tempSoundStorage = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recSettings = [NSDictionary
                                 dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:AVAudioQualityMin],
                                 AVEncoderAudioQualityKey,
                                 [NSNumber numberWithInt:16],
                                 AVEncoderBitRateKey,
                                 [NSNumber numberWithInt: 2],
                                 AVNumberOfChannelsKey,
                                 [NSNumber numberWithFloat:44100.0],
                                 AVSampleRateKey,
                                 nil];
    
    recorder = [[AVAudioRecorder alloc] initWithURL:tempSoundStorage settings:recSettings error:nil];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    
    NSLog(@"%@",tempSoundStorage);

    
    NSLog(@"stopped stopped");
    
//    SCLAlertView *alert = [[SCLAlertView alloc] init];
//    
//    [alert showSuccess:self title:@"Voice Memo" subTitle:@"Finished" closeButtonTitle:@"Done" duration:0.0f]; // Notice
    
    [self performSegueWithIdentifier:@"playMemo" sender:self];

}



- (IBAction)logOutClicked:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"logOutClicked" sender:self];


}
- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    [recordButton setTitle:@"Record" forState:UIControlStateNormal];
    
}
- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{

    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    [alert showSuccess:self title:@"Done" subTitle:@"Finish playing the recording" closeButtonTitle:@"OK" duration:0.0f]; // Notice
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PlayMemoViewController *vc = segue.destinationViewController;
    vc.memoURL = tempSoundStorage;
}


@end
