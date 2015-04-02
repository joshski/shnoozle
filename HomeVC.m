#import "HomeVC.h"
#import "TimePickerVC.h"
#import "SCLAlertView.h"
#import <RESideMenu/RESideMenu.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>
#import "PlayMemoVC.h"
#import "LeftMenuVC.h"
#import "RERootVC.h"
#import <Parse/Parse.h>

@interface HomeVC (){
    AVAudioRecorder *recorder;
    NSTimer *timer;
    SCLAlertView *alert;
    BOOL *date;
    AVAudioPlayer *memoPlayer;
    NSTimeInterval intervalToAlarm;
    int currMinute;
    int currSeconds;
    MZTimerLabel *countdown;
    BOOL alarmOn ;
    BOOL switchOn;


}

@property (strong, nonatomic) TimeOfDay *timeOfDay;
@property (nonatomic) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UIView *playView;
@property (weak, nonatomic) IBOutlet UIButton *sendToParseButton;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;

@end

@implementation HomeVC


@synthesize datePicker;
@synthesize titleLabel;
@synthesize alarmToggle;
@synthesize recordButton;
@synthesize recordView;
@synthesize tempMemoURL;
@synthesize MenuButton;
@synthesize savedAlarmTime;



- (void)viewDidLoad {
    [super viewDidLoad];
    countdown = [[MZTimerLabel alloc] initWithLabel:self.countDownLabel andTimerType:MZTimerLabelTypeTimer];

    [countdown resetTimerAfterFinish];
    countdown.delegate = self;
    [self recorderSettings];
    [alarmToggle addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    [self updateAlarmTime];
    [self isTimeLabelEmpty];
    [self cornerRadius];
  
    switchOn= [[NSUserDefaults standardUserDefaults] boolForKey:@"AlarmSwitchOn"];
    
    if (switchOn) {
        [countdown setCountDownTime:intervalToAlarm];

    }

        else {
        [countdown setCountDownTime:0];

    }
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        [self isSavedSwitchOn];
   });
 
    
    self.videoPath     = [[NSBundle mainBundle] pathForResource:@"cloud" ofType:@"mp4"];
    self.repeat        = YES;
    self.videoSpeed    = 1.0f;

}




-(void)cornerRadius {
    self.recordView.layer.cornerRadius = 80;
    self.playView.layer.cornerRadius=80;
    self.sendToParseButton.layer.cornerRadius=10;
}
- (void)updateAlarmTime {
    NSUInteger *savedAlarmHour = (NSUInteger*)[[NSUserDefaults standardUserDefaults] integerForKey:@"AlarmHour"];
    NSUInteger *savedAlarmMinute = (NSUInteger*)[[NSUserDefaults standardUserDefaults] integerForKey:@"AlarmMinute"];
    savedAlarmTime = [TimeOfDay createFromHours:savedAlarmHour minutes:savedAlarmMinute];
    _selectedTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (unsigned long)savedAlarmTime.hours, (unsigned long)savedAlarmTime.minutes];
}
- (void)isTimeLabelEmpty {
    if (savedAlarmTime.minutes != NULL) {
        [alarmToggle setOn:YES animated:YES];
        alarmToggle.enabled = true;
        titleLabel.text=@"";
        
        alarmOn=true;

    }
    else {
        titleLabel.text=@"No Alarm Set";
        [alarmToggle setOn:NO animated:YES];
        alarmToggle.enabled = FALSE;
        _selectedTimeLabel.text=@"";
        alarmOn=false;

    }
}







- (BOOL)date:(NSDate *)date hour:(NSInteger)h minute:(NSInteger)m {
    
    NSCalendar *calendar = [[NSCalendar alloc] init];
    
    NSDateComponents *componets = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute )fromDate:[NSDate date]];
    if ([componets hour ] == h && [componets minute] == m) {
        
        return YES;
    }
    return NO;
}



-(void)saveUsersName {
    if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        FBRequest *request = [FBRequest requestForMe];
        [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSDictionary *userData = (NSDictionary *)result;
                NSString *name = userData[@"name"];
                [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
            }
        }];
    }
    if ([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]]) {
        PFQuery *usernameQuery = [PFQuery queryWithClassName:@"_User"];
        PFObject *user = [usernameQuery getFirstObject];
        [user fetchIfNeeded];
        PFUser *currentUser = [user objectForKey:@"username"];
        NSLog(@"username: %@",currentUser.username); // not null
    }
}


-(void)alarm {

        _selectedTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (unsigned long)savedAlarmTime.hours, (unsigned long)savedAlarmTime.minutes];
        [self isTimeLabelEmpty];
        [self updateAlarmTime];
        [alarmToggle setOn:YES animated:YES];
        alarmToggle.enabled = true;
        titleLabel.text=@"";

    
        NSDate *now = [NSDate date];
        
        NSDateComponents *comps = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:now];
        
        
        [comps setMinute:(unsigned long)savedAlarmTime.minutes];
        [comps setHour:(unsigned long)savedAlarmTime.hours];
        
        NSDate *newDatefromComp = [[NSCalendar currentCalendar] dateFromComponents:comps];
        
        if ([now compare:newDatefromComp] == NSOrderedDescending ) {
            NSDate *tomorrowAlarm = [now dateByAddingTimeInterval:60*60*24*1];
            NSDateComponents *tomorrowAlarmComps = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:tomorrowAlarm];
            NSInteger month = [tomorrowAlarmComps month];
            NSInteger day = [tomorrowAlarmComps day];
            NSInteger year = [tomorrowAlarmComps year];
            
            [comps setDay:day];
            [comps setMonth:month];
            [comps setYear:year];
            
            SCLAlertView *alarmOnAlertTom = [[SCLAlertView alloc] init];
            [alarmOnAlertTom showSuccess:self title:@"Alarm" subTitle:[NSString stringWithFormat:@"Alarm set for tomorrow %1$@",_selectedTimeLabel.text] closeButtonTitle:@"Done" duration:0.0f]; // Notice
            alarmOn=true;
            
            
        }
        else {
            SCLAlertView *alarmOnAlertTo = [[SCLAlertView alloc] init];
            
            [alarmOnAlertTo showSuccess:self title:@"Alarm" subTitle:[NSString stringWithFormat:@"Alarm set for %1$@",_selectedTimeLabel.text] closeButtonTitle:@"Done" duration:0.0f]; // Notice
            alarmOn=true;
            
            
        }
        NSDate *fireTime = [[NSCalendar currentCalendar] dateFromComponents:comps];
        
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = fireTime;
        localNotification.alertBody = @"Wake Now Up!!";
        localNotification.alertAction = @"Show me the item";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        localNotification.soundName=@"alarm1.wav";

    }
    
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        intervalToAlarm = [fireTime timeIntervalSinceDate:now ];
    
        [NSTimer scheduledTimerWithTimeInterval:intervalToAlarm
                                         target:self selector:@selector(foregroundAlarmSound:) userInfo:nil repeats:NO];
        
        [countdown setCountDownTime:intervalToAlarm];
        
        [countdown start];

}
-(void)updateCountDown
{
    //Get the time left until the specified date
    NSInteger ti = intervalToAlarm;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600) % 24;
    
    //Update the label with the remaining time
    self.countDownLabel.text = [NSString stringWithFormat:@"%02li hrs %02li min %02li sec",  (long)hours, (long)minutes, (long)seconds];
}

-(void)foregroundAlarmSound:(NSTimer *)timer{
    [self runPlayer];
    SCLAlertView *foregroundAlarmAlert = [[SCLAlertView alloc] init];
  
    [foregroundAlarmAlert addButton:@"Snooze" actionBlock:^(void) {
        
        NSTimeInterval snoozeInterval = 900;
        [NSTimer scheduledTimerWithTimeInterval:snoozeInterval
                                         target:self selector:@selector(foregroundAlarmSound:) userInfo:nil repeats:NO];
        [countdown setCountDownTime:snoozeInterval];
        [countdown start];

        [self stopPlayer];
        alarmOn=true;


    }];

    [foregroundAlarmAlert alertIsDismissed:^{
        
        [self alarm];
        [self stopPlayer];
        alarmOn=true;


    }];
    NSTimeInterval songDuration=self.player.duration;
    [foregroundAlarmAlert showSuccess:self title:@"Alarm!!" subTitle:@"Wake Up" closeButtonTitle:@"Ok" duration:songDuration];

}

- (void)runPlayer
{
    NSString *songString = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"AlarmSound"];
    
    NSURL *url=[NSURL URLWithString:songString];
    if (url == nil ) {
        url=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/alarm1.wav", [[NSBundle mainBundle] resourcePath]]];
    }
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    float volume = [[NSUserDefaults standardUserDefaults]
                    floatForKey:@"AlarmVolume"];
    self.player.volume=volume;
    [self.player play];
}
- (void)stopPlayer
{
    [self.player stop];
    self.player = nil;
}

-(void)isSavedSwitchOn{
    
    if (switchOn) {
        [alarmToggle setOn:YES animated:YES];
        [self alarm];
        _selectedTimeLabel.textColor=[UIColor colorWithRed:132/255 green:255/255 blue:93/255 alpha:1];

    }
    else {
        [alarmToggle setOn:NO animated:YES];
        _selectedTimeLabel.textColor=[UIColor colorWithRed:255/255 green:132/255 blue:93/255 alpha:1];
        [timer invalidate];
        timer = nil;
        
        [countdown setCountDownTime:0];
        


    }
    if ((switchOn=nil)) {
        switchOn=NO;
    }
    
}

- (void)changeSwitch:(id)sender{
    [countdown reset];

   
    if([sender isOn])
        
    {
        switchOn=true;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"AlarmSwitchOn"];
        [self isSavedSwitchOn];

    }
    
    else
        
    {

        switchOn=false;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"AlarmSwitchOn"];
        [self isSavedSwitchOn];
        



    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier  isEqual:@"playMemo"]){
        PlayMemoVC *vc = segue.destinationViewController;
        vc.memoURL = tempMemoURL;
    }
}


- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController {
    
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
    
    
    [UIView animateWithDuration:0.25
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




- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    TimePickerVC *source = [segue sourceViewController];
  
    if (source.timeOfDay != nil) {
        _timeOfDay = source.timeOfDay;
        
        [[NSUserDefaults standardUserDefaults] setInteger:(unsigned long)source.timeOfDay.hours forKey:@"AlarmHour"];
        [[NSUserDefaults standardUserDefaults] setInteger:(unsigned long)source.timeOfDay.minutes forKey:@"AlarmMinute"];
        
        [countdown reset];
        
        [self alarm];
        
        
    }
}

- (IBAction)switchTapped:(id)sender {
    [self changeSwitch:sender];
}

- (IBAction)recordButtonUpOutside:(id)sender {
    [self showMemoView];

}
- (IBAction)playCloseTapped:(id)sender {
    [self showRecordView];
 
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
   
    [recordView.layer removeAllAnimations];
    [recordView setBackgroundColor: [UIColor colorWithRed:255/255 green:16/255 blue:26/255 alpha:0.5]];
    [self recordButtonUpOutside:self];
}

-(void)showMemoView {
    recordView.hidden=true;
    
    [UIView transitionWithView:self.recordView
                      duration:0.25
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        _playView.hidden=false;
                        _sendToParseButton.hidden=false;
                        [UIView transitionWithView:self.playView
                                          duration:0.5
                                           options:UIViewAnimationOptionTransitionFlipFromLeft
                                        animations:^{
                                            
                                            
                                        }
                                        completion:nil];
                        [UIView transitionWithView:self.sendToParseButton
                                          duration:0.5
                                           options:UIViewAnimationOptionTransitionFlipFromBottom
                                        animations:^{
                                            
                                            
                                        }
                                        completion:nil];
                    }
                    completion:nil];
    
}


-(void)showRecordView {
    _playView.hidden=true;
    _sendToParseButton.hidden=true;
    [UIView transitionWithView:self.playView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        recordView.hidden=false;
                        [UIView transitionWithView:self.recordView
                                          duration:0.25
                                           options:UIViewAnimationOptionTransitionCrossDissolve
                                        animations:^{
                                            
                                            
                                        }
                                        completion:nil];
                        
                    }
                    completion:nil];
    [UIView transitionWithView:self.sendToParseButton
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        
                        
                    }
                    completion:nil];
    
}

- (IBAction)sendToParse:(id)sender {
    PFObject *testObject = [PFObject objectWithClassName:@"AudioFiles"];
    
    //get the audio in NSData format
    NSData *audioData = [NSData dataWithContentsOfURL:tempMemoURL];
    NSLog(@"audioData being sent.... = %@", audioData);
    
    //create audiofile as a property
    PFFile *audioFile = [PFFile fileWithName:@"audio.caf" data:audioData];
    testObject[@"audioFile"] = audioFile;
    
    //save
    [testObject saveInBackground];
    
    
    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        SCLAlertView *uploadAlert=[[SCLAlertView alloc]init];

        if (!error) {
            
            [uploadAlert showSuccess:self title:@"Success" subTitle:@"Memo has been uploaded to parse" closeButtonTitle:@"OK" duration:0.0f];
            [self showRecordView];
            
        } else {
            [uploadAlert showError:self title:@"Error" subTitle:@"Error Sending" closeButtonTitle:@"OK" duration:0.0f];
            
            
        }
        
    }];
}

- (IBAction)didCloseButtonTouch:(UIButton *)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];

}



- (IBAction)recordTouchDown:(id)sender {
    [self animateColors];

    [recorder recordForDuration:30];
  
    
}


- (IBAction)playButtonTapped:(id)sender {
  
    memoPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:tempMemoURL error:nil];
    [memoPlayer play];
}

@end
