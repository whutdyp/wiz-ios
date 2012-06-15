//
//  NSDate+WizTools.m
//  Wiz
//
//  Created by 朝 董 on 12-4-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSDate+WizTools.h"
#import "NSDate-Utilities.h"

@implementation NSDate (WizTools)
- (NSString*) stringYearAndMounth
{
    NSString* dateToLocalString = [self stringSql];
    if (nil == dateToLocalString || dateToLocalString.length <7) {
        return nil;
    }
    NSRange range = NSMakeRange(0, 7);
   return [dateToLocalString substringWithRange:range];
}

- (NSDate*) dateIgnoreMillisecond
{
    int64_t interval = [self timeIntervalSinceReferenceDate];
    return  [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}
- (NSString*) stringLocal
{
    
	static  NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSLocale *locale = [NSLocale currentLocale];
        [dateFormatter setLocale:locale];
    });
    return [dateFormatter stringFromDate:self];
}
-(NSString*) stringSql
{
    static NSDateFormatter* formatter= nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSString* dateString = [formatter stringFromDate:self];
	return dateString ;
//    static  NSCalendar* cal = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    });
//	unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//	NSDateComponents* com = [cal components:unitFlags fromDate:self];
//	int year = [com year];
//	int month = [com month];
//	int day = [com day];
//	int hour = [com hour];
//	int minute = [com minute];
//	int second = [com second];
//	//
//	NSString* str = [NSString stringWithFormat:@"%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, minute, second];
//	return str;
}
@end
