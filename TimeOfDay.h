#import <Foundation/Foundation.h>

@interface TimeOfDay : NSObject

@property (nonatomic, assign) NSUInteger hourPart;
@property (nonatomic, assign) NSUInteger minutePart;

+ (instancetype)timeOfDayFromDate:(NSDate*)date;

@end
