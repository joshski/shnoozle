

#import "LoginVC.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>
#import "RecordMemoVC.h"
#import "SCLAlertView.h"

@interface LoginVC ()

@end


@implementation LoginVC




- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self userSignedIn];
    
}

- (void)userSignedIn {
    
    if (![PFUser currentUser]) { // No user logged in
        [PFFacebookUtils initializeFacebook];
        
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        logInViewController.fields= PFLogInFieldsDefault | PFLogInFieldsFacebook ;
        
        [logInViewController.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zzz.png"]]];
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    else {
        [self transferToNext];
    }
}


- (void)FBRequest:(PFUser *)user error:(NSError *)error {
    
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location",@"user_friends"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!error) {
            [self transferToNext];
        }
        
        [self FBRequest:user error:error];
    }];
    
    if (!user) {
        NSString *errorMessage = nil;
        if (!error) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
            errorMessage = @"Uh oh. The user cancelled the Facebook login.";
        } else {
            NSLog(@"Uh oh. An error occurred: %@", error);
            errorMessage = [error localizedDescription];
        }
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showError:self title:@"Log In Error" subTitle:errorMessage closeButtonTitle:@"Done" duration:0.0f]; // Notice
    }
    
    else {
        if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
        } else {
            NSLog(@"User with facebook logged in!");
        }
        
        [self transferToNext];
        

    }
}

-(void)requestFBdetails{
    //            FBRequest *request = [FBRequest requestForMe];
    //            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
    //                if (!error) {
    //                    NSDictionary *userData = (NSDictionary *)result;
    //                    NSLog(@"facebook dictionary %@",userData);
    //                    NSString *name = userData[@"name"];
    //                    NSLog(@"first name ?? %@",name);
    //
    //
    //                }
    //        }];
    
    //            FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    //
    //            [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
    //
    //                                                          NSDictionary* result,
    //                                                          NSError *error) {
    //                if(!error){
    //                    NSMutableArray *facebookUIDs = [NSMutableArray array];
    //                    NSArray* friends = [result objectForKey:@"data"];
    //                    NSLog(@"Found: %i friends", friends.count);
    //                    // STUFFS
    //                    for (NSDictionary<FBGraphUser>* friend in friends) {
    //                        [facebookUIDs addObject:friend.id];
    //                    }
    //
    //
    //                }
    //            }];
}

-(void)transferToNext{
    [self dismissModalViewControllerAnimated:YES];
    [self _presentHomeViewControllerAnimated:YES];
    
    
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self transferToNext];
    NSLog(@"BLA");
    
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user{
    [self transferToNext];

}

- (void)_presentHomeViewControllerAnimated:(BOOL)animated {

    
    [self performSegueWithIdentifier:@"transitionToHomeController" sender:self];

    
    
}


@end
