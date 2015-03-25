//
//  AlarmItem.h
//  Shnoozle
//
//  Created by Leo on 25/03/2015.
//  Copyright (c) 2015 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmItem : NSObject

@property BOOL completed;
@property (readonly) NSDate *alarmDate;


@end
