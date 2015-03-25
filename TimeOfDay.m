#import "TimeOfDay.h"

@implementation TimeOfDay

@synthesize hours;
@synthesize minutePart;

+ (instancetype)timeOfDayFromDate:(NSDate*)date {
    TimeOfDay *instance = [[TimeOfDay alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    instance.hours = [components hour];
    instance.minutePart = [components minute];

    return instance;
}

@end
