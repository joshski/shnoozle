//
//  UITest.m
//  Shnoozle
//
//  Created by Leo on 02/04/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import "UITest.h"
#import "KIFUITestActor.h"

@implementation UITest


- (void)beforeAll {
    [tester tapViewWithAccessibilityLabel:@"Alarm Label"];
    
    [tester setOn:YES forSwitchWithAccessibilityLabel:@"Alarm Switch"];
    
   
}
@end
