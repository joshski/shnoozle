#import <KIF/UIAccessibilityElement-KIFAdditions.h>
#import "KIFUITestActor+Placeholder.h"

@implementation KIFUITestActor (Placeholder)

- (void)enterText:(NSString *)text intoTextFieldWithPlaceholder:(NSString *)placeholder {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([evaluatedObject isKindOfClass:[UITextField class]]) {
            NSLog(@"-> %@", evaluatedObject);
            UITextField *textField = (UITextField *)evaluatedObject;
            return [textField.placeholder isEqualToString:placeholder];
        }
        return NO;
    }];
    UIAccessibilityElement *element;
    UIView *view;
    [UIAccessibilityElement accessibilityElement:&element view:&view withElementMatchingPredicate:predicate tappable:NO error:NULL];
    [self tapAccessibilityElement:element inView:view];
    [self waitForTimeInterval:0.25];
    [self enterTextIntoCurrentFirstResponder:text fallbackView:view];
}

@end