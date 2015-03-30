#import "TimeOfDay.h"

@implementation TimeOfDay

@synthesize hours;
@synthesize minutes;

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:hours forKey:@"hours"];
    [encoder encodeInteger:minutes forKey:@"minutes"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    NSNumber *hoursFromDisk = [decoder decodeObjectForKey:@"hours"];
    NSNumber *minutesFromDisk = [decoder decodeObjectForKey:@"minutes"];
    NSUInteger *hoursFromDiskInt = (NSUInteger *)[hoursFromDisk integerValue];
    NSUInteger *minutesFromDiskInt = (NSUInteger *)[minutesFromDisk integerValue];

    return [TimeOfDay createFromHours:hoursFromDiskInt minutes:minutesFromDiskInt];
}

+ (instancetype)timeOfDayFromDate:(NSDate*)date {
    TimeOfDay *instance = [[TimeOfDay alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    instance.hours = [components hour];
    instance.minutes = [components minute];

    return instance;
}

+ (instancetype)createFromHours:(NSUInteger*)hours minutes:(NSUInteger*)minutes {
    TimeOfDay *instance = [[TimeOfDay alloc] init];
    instance.hours = &(*(hours));
    instance.minutes = &(*(minutes));
    return instance;
}
@end
