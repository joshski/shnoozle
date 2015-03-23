

#import "ViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface ViewController ()

@end


@implementation ViewController





- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
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



@end
