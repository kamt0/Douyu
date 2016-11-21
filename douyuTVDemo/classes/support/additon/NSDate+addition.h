//
//  NSDate+addition.h
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/10.
//  Copyright © 2016年 kamto. All rights reserved.
//
//[NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0900"]]; // 只能够修改该程序的defaultTimeZone，不能修改系统的，更不能修改其他程序的
#import <Foundation/Foundation.h>

@interface NSDate (addition)
struct DateInformation {
    NSInteger day;
    NSInteger month;
    NSInteger year;
    
    NSInteger weekday;
    
    NSInteger minute;
    NSInteger hour;
    NSInteger second;
};
typedef struct DateInformation DateInformation;
/**
 *  返回一个DateInformation的结构体
 *
 *  @return
 */
- (DateInformation)dateInformation;
/**
 *  返回一个DateInformation的结构体
 *
 *  @param timezone 时区
 *
 *  @return 
 */
- (DateInformation)dateInformationWithTimeZone:(NSTimeZone *)timezone;
/**
 *  根据日期结构体返回date
 *
 *  @param info 日期结构体
 *
 *  @return  yyyy-MM-dd HH-mm-ss
 */
+ (NSDate *)dateFromDateInformation:(DateInformation)info;
/**
 *  根据日期结构体和时区返回date
 *
 *  @param info     日期结构体
 *  @param timezone 时区
 *
 *  @return yyyy-MM-dd HH-mm-ss
 */
+ (NSDate *)dateFromDateInformation:(DateInformation)info
                           timeZone:(NSTimeZone *)timezone;
/**
 *根据日期结构体打印日期
 *
 *  @param info   日期结构体
 *
 *  @return  MM/dd/yyyy HH:mm:ss
 */
+ (NSString *)dateInformationDescriptionWithInformation:(DateInformation)info;
/**
 *  当前日期 时区为中国时区
 *
 *  @return 
 */
/////////////////////////////昨天、今天、明天///////////////////////////
+ (NSDate *)now;
/**
 *  当天日期字符串
 *
 *  @return
 */
+ (NSString *)nowStr;
/**
 *  昨天日期
 *
 *  @return
 */
+ (NSDate *)yesterDay;
/**
 *  某日期的昨天
 *
 *  @param date
 *
 *  @return
 */
+ (NSDate *)yesterday:(NSDate *)date;
/**
 *  明天
 *
 *  @return
 */
+ (NSDate *)tomorrow;
/**
 *  少某日期几天
 *
 *  @param lessDay 目标日期
 *  @param i       天数
 *
 *  @return
 */
+ (NSDate *)date:(NSDate *)date lessDay:(int)i;
/**
 *   多某日期几天
 *
 *  @param date 目标日期
 *  @param i    天数
 *
 *  @return
 */
+ (NSDate *)date:(NSDate *)date moreDay:(int)i;
/**
 *  是否是当天
 *
 *  @return
 */
- (BOOL)isToday;
/**
 *  是否是同一天
 *
 *  @param anotherDate
 *
 *  @return
 */
- (BOOL)isSameDay:(NSDate *)anotherDate;
///////////////////////////日历信息///////////////////////////
/**
 *  当前日历信息
 *
 *  @return
 */
+ (NSDateComponents *)getCurrentCalendar;
/**
 *  某日期的日历信息
 *
 *  @param date
 *
 *  @return
 */
+ (NSDateComponents *)getCurrentCalendar:(NSDate *)date;
/**
 *  中国日历即农历
 *
 *  @return
 */
+ (NSDateComponents *)getThelunarCalendar;
/**
 *  当天农历日期
 *
 *  @return yyyy-MM-mm HH-mm-ss
 */
+ (NSString *)getThelunarDate;

///////////////////////////日历信息///////////////////////////

////////////////////////////星期///////////////////////////
/**
 *  当天星期
 *
 *  @return 周几
 */
+ (NSString *)WeekDay;
/**
 *  某日期的星期天数
 *
 *  @param date
 *
 *  @return    周几
 */
+ (NSString *)WeekDay:(NSData *)date;
/**
 *  当前周几
 *
 *  @return
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)dayFromWeekday;
////////////////////////////星期///////////////////////////
/**
 *  距离月份数
 *
 *  @param date
 *
 *  @return
 */
- (NSInteger)monthsBetweenDate:(NSDate *)toDate;
/**
 *  距离天数
 *
 *  @param toDate
 *
 *  @return
 */
- (NSInteger)daysBetweenDate:(NSDate *)toDate;
/**
 *  月份字符串
 *
 *  @return MM 如果返回的是几月的话可自行修改返回值
 */
- (NSString *)monthString;
/**
 *  年份字符串
 *
 *  @return
 */
- (NSString *)yearString;
/**
 *  月份字符串
 *
 *  @param month
 *
 *  @return 
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 */
+ (NSString *)monthStringWithMonthNumber:(NSInteger)month;
/**
 *  日期的字符串形式
 *
 *  @param format 格式 yyyy-MM-dd HH-mm-ss
 *
 *  @return
 */
- (NSString *)dateString:(NSString *)format;
/**
 *  比较两个date的大小
 *
 *  @param oneDay
 *  @param anotherDay
 *
 *  @return 1 -1 0
 */
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
/**
 *  比较两个date的大小
 *
 *  @param oneDay
 *  @param anotherDay
 *
 *  @return 1 -1 0
 */
+(int)compareTime:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay;
///////////////////////////修改日期格式 ///////////////////////////////////
/**
 *  根据日期字符串中特定的一个字符 改格式
 *
 *  @param dateStr 日期字符串
 *  @param c       字符
 *
 *  @return exmple 2016-5-10 那么c为‘-’，返回2016年5月
 */
+ (NSString *)getDateFromDateStr:(NSString *)dateStr char:(char)c;

@end
