

#import "LogInViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>
#import "RecordPlayViewController.h"
#import "UserDetailsViewController.h"

@interface LogInViewController ()

@end


@implementation LogInViewController




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
//        UIAlertView *loggedInAlert =[[UIAlertView alloc] initWithTitle:@"Logged In" message:@"Log me out?" delegate:nil cancelButtonTitle:@"Log me out!" otherButtonTitles:nil, nil];
//        
//        [loggedInAlert show];
//        [PFUser logOut];
//        [self viewDidAppear:YES];
        [self _presentUserDetailsViewControllerAnimated:YES];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)parse {
    PFUser *user = [PFUser user];
    //    user.username = usernameInput.text;
    //    user.password = passwordInput.text;
    //    user.email = @"email@example.com";
    //
    //    // other fields can be set if you want to save more information
    //    user[@"phone"] = @"650-555-0000";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
        }
    }];
}
- (IBAction)createUser:(id)sender {
    [self parse];
    
}

- (IBAction)loginButtonTouchHandler:(id)sender  {
    
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location",@"user_friends"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_activityIndicator stopAnimating]; // Hide loading indicator
        
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
    }];
    
    [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissModalViewControllerAnimated:YES];
     [self _presentUserDetailsViewControllerAnimated:YES];
    
    [self loginButtonTouchHandler:self];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user{
    [self dismissModalViewControllerAnimated:YES];
    [self _presentUserDetailsViewControllerAnimated:YES];
    
    [self loginButtonTouchHandler:self];
}

- (void)_presentUserDetailsViewControllerAnimated:(BOOL)animated {
//    UserDetailsViewController *detailsViewController = [[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
//    [self.navigationController pushViewController:detailsViewController animated:animated];
    
    [self performSegueWithIdentifier:@"transitionToMainController" sender:self];
    
    
}


@end
