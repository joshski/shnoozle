#import <ParseUI/PFTextField.h>
#import "SignUpTest.h"
#import "KIFUITestActor.h"
#import "UIAccessibilityElement-KIFAdditions.h"
#import "KIFUITestActor+Placeholder.h"
#import "AppDelegate.h"

@implementation SignUpTest

- (void)testSuccessfulSignUp {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate resetApp];

    NSString *username = [[NSUUID UUID] UUIDString];
    NSString *pwd = @"Password123";
    NSString *email = [NSString stringWithFormat:@"%@@featurist.co.uk", username];

    [tester tapViewWithAccessibilityLabel:@"Sign Up"];
    [tester enterText:username intoTextFieldWithPlaceholder:@"Username"];
    [tester enterText:pwd intoTextFieldWithPlaceholder:@"Password"];
    [tester enterText:email intoTextFieldWithPlaceholder:@"Email"];
    [tester tapViewWithAccessibilityLabel:@"Sign Up"];

    [tester waitForViewWithAccessibilityLabel:@"No Alarm Set"];
}

@end
