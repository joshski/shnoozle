#import "FindFriendsViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>


@interface FindFriendsViewController ()

@end

@implementation FindFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)fbTapped:(id)sender {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location",@"user_friends"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                errorMessage = @"Uh oh. The user cancelled the Facebook login.";
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                errorMessage = [error localizedDescription];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                            message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
        }
        else {
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
            } else {
                NSLog(@"User with facebook logged in!");
            }
            
            NSLog(@"should now present users details view controller");
            
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    NSDictionary *userData = (NSDictionary *)result;
                    NSLog(@"facebook dictionary %@",userData);
                    NSString *name = userData[@"name"];
                    NSLog(@"first name ?? %@",name);
                    
                }
            }];
            
                        FBRequest* friendsRequest = [FBRequest requestForMyFriends];
            
                        [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
            
                                                                      NSDictionary* result,
                                                                      NSError *error) {
                            if(!error){
                                NSMutableArray *facebookUIDs = [NSMutableArray array];
                                NSArray* friends = [result objectForKey:@"data"];
                                NSLog(@"Found: %i friends", friends.count);
                                
                                if (friends.count < 1) {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook"
                                                                                    message:@"No one on your friends list is currently using snoozle"
                                                                                   delegate:nil
                                                                          cancelButtonTitle:nil
                                                                          otherButtonTitles:@"Ok", nil];
                                    [alert show];
                                }
                                // STUFFS
                                for (NSDictionary<FBGraphUser>* friend in friends) {
                                    [facebookUIDs addObject:friend.id];
                                }
            
            
                            }
                        }];
            
        }
    }];
    
}




@end
