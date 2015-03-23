

#import "ViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <FacebookSDK/FacebookSDK.h>
#import "UserDetailsTableViewController.h"



@interface ViewController ()

@end


@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [PFFacebookUtils initializeFacebook];

    
    PFLogInViewController *loginController = [[PFLogInViewController alloc]init];
    loginController.fields= PFLogInFieldsDefault | PFLogInFieldsFacebook | PFLogInFieldsTwitter;
    
    
    [self presentViewController:loginController animated:YES completion:nil];
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
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
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
        } else {
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
            } else {
                NSLog(@"User with facebook logged in!");
            }
            [self _presentUserDetailsViewControllerAnimated:YES];
        }
    }];
    
    [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}

- (void)_presentUserDetailsViewControllerAnimated:(BOOL)animated {
    UserDetailsTableViewController *detailsViewController = [[UserDetailsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:detailsViewController animated:animated];
}




@end
