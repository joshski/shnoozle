#import "HomeVC.h"
#import "TimePickerVC.h"
#import "SCLAlertView.h"
#import <RESideMenu/RESideMenu.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>
#import "PlayMemoVC.h"
@interface HomeVC (){
    AVAudioRecorder *recorder;
    NSTimer *timer;
}
@end

@implementation HomeVC



@synthesize datePicker;
@synthesize selectedTimeLabel;
@synthesize titleLabel;
@synthesize alarmToggle;
@synthesize recordButton;
@synthesize recordView;
@synthesize tempMemoURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self recorderSettings];

    [alarmToggle addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];

    if (selectedTimeLabel.text.length > 0) {
        [alarmToggle setOn:YES animated:YES];
        alarmToggle.enabled = true;
        
    }
    else {
        titleLabel.text=@"No Alarm Set";
        [alarmToggle setOn:NO animated:YES];
        alarmToggle.enabled = FALSE;
        
    }

    
    
}
- (IBAction)menuTapped:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];

}


- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    TimePickerVC *source = [segue sourceViewController];
    if (source.timeOfDay != nil) {
        selectedTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (unsigned long)source.timeOfDay.hours, (unsigned long)source.timeOfDay.minutePart];
        titleLabel.text=@"";
        [alarmToggle setOn:YES animated:YES];
        alarmToggle.enabled = true;
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showSuccess:self title:@"Alarm" subTitle:@"On" closeButtonTitle:@"Done" duration:0.0f]; // Notice


    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)changeSwitch:(id)sender{
    if([sender isOn]){
        
        selectedTimeLabel.textColor=[UIColor colorWithRed:132/255 green:255/255 blue:93/255 alpha:1];
    } else{

        selectedTimeLabel.textColor=[UIColor colorWithRed:255/255 green:132/255 blue:93/255 alpha:1];
    }
}

- (IBAction)switchTapped:(id)sender {
    [self changeSwitch:sender];
}

- (IBAction)recordButtonUpOutside:(id)sender {
    [self performSegueWithIdentifier:@"playMemo" sender:self];
    NSLog(@"shouldTransitionToMemo");

//    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"playMemoVC"]]
//                                                 animated:YES];
    
}

- (IBAction)recordTouchUp:(id)sender {
    [recorder stop];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"tmpSound.caf"];
    
    self.tempMemoURL = [NSURL fileURLWithPath:soundFilePath];
    
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
    
    recorder = [[AVAudioRecorder alloc] initWithURL:tempMemoURL settings:recSettings error:nil];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    
    
    NSLog(@"stopped stopped");
    
    [recordView.layer removeAllAnimations];
    [recordView setBackgroundColor: [UIColor redColor]];
    [self recordButtonUpOutside:self];
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
- (void)animateColors {
    
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         [recordView setBackgroundColor: [UIColor whiteColor]];
                     }
                     completion:nil];
    
}




- (IBAction)recordTouchDown:(id)sender {
    
    [recorder recordForDuration:30];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(updateTime)
                                           userInfo:nil
                                            repeats:YES];
    NSLog(@"started started");
    
    [self animateColors];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PlayMemoVC *vc = segue.destinationViewController;
    vc.memoURL = tempMemoURL;
    
}


-(void)updateTime
{
    //Get the time left until the specified date
    NSInteger seconds = 30;
    
    
    //Update the label with the remaining time
}


@end
