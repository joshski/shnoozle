

#import "RecordMemoVC.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SCLAlertView.h"
#import "PlayMemoVC.h"
@interface RecordMemoVC (){

}

@end

@implementation RecordMemoVC


@synthesize recordButton;
@synthesize recordView;

@synthesize tempMemoURL;


- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self recorderSettings];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
