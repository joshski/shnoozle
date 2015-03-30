#import <Foundation/Foundation.h>

@interface TimeOfDay : NSObject <NSCoding>

@property (nonatomic, assign) NSUInteger *hours;
@property (nonatomic, assign) NSUInteger *minutes;

+ (instancetype)timeOfDayFromDate:(NSDate*)date;
+ (instancetype)createFromHours:(NSUInteger*)hours minutes:(NSUInteger*)minutes;

@end
