#import <Kiwi/Kiwi.h>
#import "TimeOfDay.h"

SPEC_BEGIN(TimeOfDaySpec)

describe(@"TimeOfDay", ^{
    
    describe(@"Conversion from NSDate", ^{
        
        __block NSDateFormatter *formatter;
        
        beforeEach(^{
            formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"];
            [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
        });
        
        it(@"extracts the hours and minutes from an NSDate", ^{
            
            NSDate *date = [formatter dateFromString:@"2012-08-21T02:07:17.320Z"];
            
            TimeOfDay *timeOfDay = [TimeOfDay timeOfDayFromDate: date];
            [[theValue(timeOfDay.hourPart) should] equal: theValue(2)];
            [[theValue(timeOfDay.minutePart) should] equal: theValue(7)];
            
        });
        
        it(@"extracts the hours and minutes from an NSDate", ^{
            
            NSDate *date = [formatter dateFromString:@"1972-08-21T01:05:17.320Z"];
            
            TimeOfDay *timeOfDay = [TimeOfDay timeOfDayFromDate: date];
            [[theValue(timeOfDay.hourPart) should] equal: theValue(1)];
            [[theValue(timeOfDay.minutePart) should] equal: theValue(5)];
            
        });
    
    });
    
});

SPEC_END
