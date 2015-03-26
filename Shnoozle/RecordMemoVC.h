#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RecordMemoVC : UIViewController <AVAudioRecorderDelegate>
@property (weak, nonatomic) IBOutlet UIButton *logOutButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadToParse;
@property (weak, nonatomic) IBOutlet UIView *recordView;
@property (strong, nonatomic) NSURL *tempMemoURL;

@end
