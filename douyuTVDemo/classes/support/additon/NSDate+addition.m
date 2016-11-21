//
//  NSDate+addition.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/10.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "NSDate+addition.h"

@implementation NSDate (addition)
- (DateInformation)dateInformation{
    DateInformation info;
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp =
    [gregorian components:(NSCalendarUnitMonth | NSCalendarUnitMinute |
                           NSCalendarUnitYear | NSCalendarUnitDay |
                           NSCalendarUnitWeekday | NSCalendarUnitHour |
                           NSCalendarUnitSecond)
                 fromDate:self];
    info.day = [comp day];
    info.month = [comp month];
    info.year = [comp year];
    
    info.hour = [comp hour];
    info.minute = [comp minute];
    info.second = [comp second];
    
    info.weekday = [comp weekday];
    
    return info;
}
- (DateInformation)dateInformationWithTimeZone:(NSTimeZone *)timezone {
    DateInformation info;
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setTimeZone:timezone];
    NSDateComponents *comp =
    [gregorian components:(NSCalendarUnitMonth | NSCalendarUnitMinute |
                           NSCalendarUnitYear | NSCalendarUnitDay |
                           NSCalendarUnitWeekday | NSCalendarUnitHour |
                           NSCalendarUnitSecond)
                 fromDate:self];
    info.day = [comp day];
    info.month = [comp month];
    info.year = [comp year];
    
    info.hour = [comp hour];
    info.minute = [comp minute];
    info.second = [comp second];
    
    info.weekday = [comp weekday];
    
    return info;
}

+ (NSDate *)dateFromDateInformation:(DateInformation)info {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp =
    [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth)
                 fromDate:[NSDate date]];
    
    [comp setDay:info.day];
    [comp setMonth:info.month];
    [comp setYear:info.year];
    [comp setHour:info.hour];
    [comp setMinute:info.minute];
    [comp setSecond:info.second];
    //修改默认时区会影响时间的输出显示 目前为当前时区
    [comp setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [gregorian dateFromComponents:comp];
}
+ (NSDate *)dateFromDateInformation:(DateInformation)info
                           timeZone:(NSTimeZone *)timezone {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setTimeZone:timezone];
    NSDateComponents *comp =
    [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth)
                 fromDate:[NSDate date]];
    
    [comp setDay:info.day];
    [comp setMonth:info.month];
    [comp setYear:info.year];
    [comp setHour:info.hour];
    [comp setMinute:info.minute];
    [comp setSecond:info.second];
    [comp setTimeZone:timezone];
    
    return [gregorian dateFromComponents:comp];
}
+ (NSString *)dateInformationDescriptionWithInformation:(DateInformation)info {
    return [NSString stringWithFormat:@"%02li/%02li/%04li %02li:%02li:%02li",
            (long)info.month, (long)info.day,
            (long)info.year, (long)info.hour,
            (long)info.minute, (long)info.second];
}
+ (NSDate *)now{
    DateInformation inf = [[NSDate date] dateInformation];
    return [self dateFromDateInformation:inf];
}
+ (NSString *)nowStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
   return [dateFormatter stringFromDate:[NSDate date]];
}
+ (NSDate *)yesterDay {
    DateInformation inf = [[NSDate date] dateInformation];
    inf.day--;
    return [self dateFromDateInformation:inf];
}
+ (NSDate *)yesterday:(NSDate *)date{
    DateInformation inf = [date dateInformation];
    inf.day--;
    return [self dateFromDateInformation:inf];
    
}
+ (NSDate *)tomorrow{
    DateInformation inf = [[NSDate date] dateInformation];
    inf.day++;
    return [self dateFromDateInformation:inf];
}
+ (NSDate *)date:(NSDate *)date lessDay:(int)i{
    DateInformation inf = [[NSDate date] dateInformation];
    inf.day -= i;
    return [self dateFromDateInformation:inf];
}
+ (NSDate *)date:(NSDate *)date moreDay:(int)i{
    DateInformation inf = [[NSDate date] dateInformation];
    inf.day += i;
    return [self dateFromDateInformation:inf];
}
- (BOOL)isToday {
    return [self isSameDay:[NSDate date]];
}
- (BOOL)isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar
                                     components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                     fromDate:self];
    NSDateComponents *components2 = [calendar
                                     components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                     fromDate:anotherDate];
    return ([components1 year] == [components2 year] &&
            [components1 month] == [components2 month] &&
            [components1 day] == [components2 day]);
}

+ (NSDateComponents *)getCurrentCalendar{
    
    //当前时间
    NSDate *nowDate = [NSDate new];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    components = [calendar components: NSCalendarUnitYear |
                  
                  NSCalendarUnitMonth |
                  
                  NSCalendarUnitDay |
                  
                  NSCalendarUnitWeekday |
                  
                  NSCalendarUnitHour |
                  
                  NSCalendarUnitMinute |
                  
                  NSCalendarUnitSecond fromDate:nowDate];
    //获取当前时间的小时 NSInteger temp =  [components hour];
    return components;
}
+ (NSDateComponents *)getCurrentCalendar:(NSDate *)date{
    

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    components = [calendar components: NSCalendarUnitYear |
                  
                  NSCalendarUnitMonth |
                  
                  NSCalendarUnitDay |
                  
                  NSCalendarUnitWeekday |
                  
                  NSCalendarUnitHour |
                  
                  NSCalendarUnitMinute |
                  
                  NSCalendarUnitSecond fromDate:date];
    //获取当前时间的小时 NSInteger temp =  [components hour];
    return components;
}
+ (NSDateComponents *)getThelunarCalendar
{
    //当前时间
    NSDate *nowDate = [NSDate new];
    //中国日历 即农历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    components = [calendar components: NSCalendarUnitYear |
                  
                  NSCalendarUnitMonth |
                  
                  NSCalendarUnitDay |
                  
                  NSCalendarUnitWeekday |
                  
                  NSCalendarUnitHour |
                  
                  NSCalendarUnitMinute |
                  
                  NSCalendarUnitSecond fromDate:nowDate];
    //获取当前时间的小时 NSInteger temp =  [components hour];
    return components;
}
+ (NSString *)getThelunarDate{
    NSInteger year   = [[self getCurrentCalendar] year];
    NSInteger month  = [[self getThelunarCalendar] month];
    NSInteger day    = [[self getThelunarCalendar] day];
    NSInteger hour   = [[self getThelunarCalendar] hour];
    NSInteger minute = [[self getThelunarCalendar] minute];
    NSInteger second = [[self getThelunarCalendar] second];
    NSString * dateStr = [NSString stringWithFormat:@"%ld.%ld.%ld %ld:%ld:%ld",year,month,day,hour,minute,second];
    
    return dateStr;
}
+ (NSString *)WeekDay{
    int N;
    if ((int)([[self getCurrentCalendar] weekday]) ==1) {
        return [NSString stringWithFormat:@"周日"];
    }else{
        N = (int)([[self getCurrentCalendar] weekday]-1);
        NSString *weekStr;
        if (N ==1) {
            weekStr = @"一";
        }else if (N ==2){
            weekStr = @"二";
        }else if (N ==3){
            weekStr = @"三";
        }else if (N ==4){
            weekStr = @"四";
        }else if (N ==5){
            weekStr = @"五";
        }else if (N ==6){
            weekStr = @"六";
        }
        return [NSString stringWithFormat:@"周%@",weekStr];
    }

}
+ (NSString *)WeekDay:(NSDate *)date{
    int N;
    if ((int)([[self getCurrentCalendar:date] weekday]) ==1) {
        return [NSString stringWithFormat:@"周日"];
    }else{
        N = (int)([[self getCurrentCalendar] weekday]-1);
        NSString *weekStr;
        if (N ==1) {
            weekStr = @"一";
        }else if (N ==2){
            weekStr = @"二";
        }else if (N ==3){
            weekStr = @"三";
        }else if (N ==4){
            weekStr = @"四";
        }else if (N ==5){
            weekStr = @"五";
        }else if (N ==6){
            weekStr = @"六";
        }
        return [NSString stringWithFormat:@"周%@",weekStr];
    }

}
- (NSInteger)weekdayNum{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps =
    [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth |
                           NSCalendarUnitYear | NSCalendarUnitWeekday)
                 fromDate:self];
    NSInteger weekday = [comps weekday];
    return weekday;
}
- (NSString *)dayFromWeekday {
    switch ([self weekdayNum]) {
        case 1:
            return NSLocalizedStringFromTable(@"SUNDAY", @"BFKit", @"");
            break;
        case 2:
            return NSLocalizedStringFromTable(@"MONDAY", @"BFKit", @"");
            break;
        case 3:
            return NSLocalizedStringFromTable(@"TUERSDAY", @"BFKit", @"");
            break;
        case 4:
            return NSLocalizedStringFromTable(@"WEDNESDAY", @"BFKit", @"");
            break;
        case 5:
            return NSLocalizedStringFromTable(@"THURSDAY", @"BFKit", @"");
            break;
        case 6:
            return NSLocalizedStringFromTable(@"FRIDAY", @"BFKit", @"");
            break;
        case 7:
            return NSLocalizedStringFromTable(@"SATURDAY", @"BFKit", @"");
            break;
        default:
            break;
    }
    
    return @"";
}
- (NSInteger)monthsBetweenDate:(NSDate *)toDate{
    NSTimeInterval time = [self timeIntervalSinceDate:toDate];
    return (time / 60 / 60 );
}
- (NSInteger)daysBetweenDate:(NSDate *)toDate {
        NSTimeInterval time = [self timeIntervalSinceDate:toDate];
        return (time / 60 / 60 / 24);
}
- (NSString *)monthString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM"];
    return [dateFormatter stringFromDate:self];
}
- (NSString *)yearString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    return [dateFormatter stringFromDate:self];
}
+ (NSString *)monthStringWithMonthNumber:(NSInteger)month{
    switch (month) {
        case 1:
            return NSLocalizedStringFromTable(@"JANUARY", @"BFKit", @"");
            break;
        case 2:
            return NSLocalizedStringFromTable(@"FEBRUARY", @"BFKit", @"");
            break;
        case 3:
            return NSLocalizedStringFromTable(@"MARCH", @"BFKit", @"");
            break;
        case 4:
            return NSLocalizedStringFromTable(@"APRIL", @"BFKit", @"");
            break;
        case 5:
            return NSLocalizedStringFromTable(@"MAY", @"BFKit", @"");
            break;
        case 6:
            return NSLocalizedStringFromTable(@"JUNE", @"BFKit", @"");
            break;
        case 7:
            return NSLocalizedStringFromTable(@"JULY", @"BFKit", @"");
            break;
        case 8:
            return NSLocalizedStringFromTable(@"AUGUST", @"BFKit", @"");
            break;
        case 9:
            return NSLocalizedStringFromTable(@"SEPTEMBER", @"BFKit", @"");
            break;
        case 10:
            return NSLocalizedStringFromTable(@"OCTOBER", @"BFKit", @"");
            break;
        case 11:
            return NSLocalizedStringFromTable(@"NOVEMBER", @"BFKit", @"");
            break;
        case 12:
            return NSLocalizedStringFromTable(@"DECEMBER", @"BFKit", @"");
            break;
        default:
            return nil;
            break;
    }
}
- (NSString *)dateString:(NSString *)format{
    NSDateFormatter *timeFormatter = [NSDateFormatter new];
    [timeFormatter setDateStyle:NSDateFormatterFullStyle];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    [timeFormatter setLocale:locale];
    timeFormatter.dateFormat = format;
    return [timeFormatter stringFromDate:self];
}
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;

}
+(int)compareTime:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay
{
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDay];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: dateA];
    NSDate *date1 = [dateA  dateByAddingTimeInterval: frominterval];
    
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDay];
    NSInteger frominterval2 = [fromzone secondsFromGMTForDate: dateB];
    NSDate *date2 = [dateB  dateByAddingTimeInterval: frominterval2];
    
    
    NSComparisonResult result = [date1 compare:date2];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}
+ (NSString *)getDateFromDateStr:(NSString *)dateStr char:(char)c{
    @try {
        NSString *lastStr;
        int Dayindex ;
        for (int i = 0; i < dateStr.length; i ++) {
            if ([dateStr characterAtIndex:i] == 'c') {
                Dayindex = i;
            }
        }
    
        lastStr = [dateStr substringToIndex:Dayindex];
        int monthindex ;
        for (int i = 0; i < lastStr.length; i ++) {
            if ([dateStr characterAtIndex:i] == 'c') {
                monthindex = i;
            }
        }
        
        NSString *year = [lastStr substringToIndex:monthindex];
        NSString *month = [lastStr substringFromIndex:monthindex+1];
        
        return [NSString stringWithFormat:@"%@年%@月",year,month];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}
@end
