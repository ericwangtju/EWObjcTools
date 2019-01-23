//
//  NSDate+EWSugar.h
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/18.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSDate (EWSugar)

#pragma mark - 单例
/// 创建一个dateFormatter单例对象
+ (nonnull NSDateFormatter *)ew_sharedDateFormatter;

/// 创建一个calender单例对象
+ (nonnull NSCalendar *)ew_sharedCalendar;


#pragma mark - Component Properties
/// 年份
@property (nonatomic, readonly) NSInteger year;
/// 月份
@property (nonatomic, readonly) NSInteger month;
/// 天数
@property (nonatomic, readonly) NSInteger day;
/// 小时
@property (nonatomic, readonly) NSInteger hour;
/// 分钟
@property (nonatomic, readonly) NSInteger minute;
/// 秒数
@property (nonatomic, readonly) NSInteger second;
/// 纳秒
@property (nonatomic, readonly) NSInteger nanosecond;
/// 星期单位。范围为1-7 依赖于用户的手机设置
@property (nonatomic, readonly) NSInteger weekday;
/// 以7天为单位，范围为1-5 （1-7号为第1个7天，8-14号为第2个7天...）
@property (nonatomic, readonly) NSInteger weekdayOrdinal;
/// 月包含的周数。最多为6个周
@property (nonatomic, readonly) NSInteger weekOfMonth;
/// 年包含的周数。最多为53个周
@property (nonatomic, readonly) NSInteger weekOfYear;

@property (nonatomic, readonly) NSInteger yearForWeekOfYear;
@property (nonatomic, readonly) NSInteger quarter;
/// 是否是闰月
@property (nonatomic, readonly) BOOL isLeapMonth;
/// 是否是闰年
@property (nonatomic, readonly) BOOL isLeapYear;
/// 当前手机时间是否为今天
@property (nonatomic, readonly) BOOL isToday;
/// 当前手机时间是否为昨天
@property (nonatomic, readonly) BOOL isYesterday;
/// 当前手机时间是否为前天
@property (nonatomic, readonly) BOOL isDayBeforeYesterday;

#pragma mark - Date modify
/**
 返回指定年数之后的日期
 */
- (nullable NSDate *)dateByAddingYears:(NSInteger)years;

/**
 返回指定月数之后的日期
 */
- (nullable NSDate *)dateByAddingMonths:(NSInteger)months;

/**
 返回指定周数之后的日期
 */
- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks;

/**
 返回指定天数之后的日期
 */
- (nullable NSDate *)dateByAddingDays:(NSInteger)days;

/**
 返回指定小时数之后的日期
 */
- (nullable NSDate *)dateByAddingHours:(NSInteger)hours;

/**
 返回指定分钟数之后的日期
 */
- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes;

/**
 返回指定秒数之后的日期
 */
- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds;


#pragma mark - Date Format
/**
 返回一个date指定格式的字符串 e.g. @"yyyy-MM-dd HH:mm:ss"
 */
- (nullable NSString *)stringWithFormat:(NSString *)format;

/**
 将date转为指定格式,指定市区,指定地域的时间字符串
 */
- (nullable NSString *)stringWithFormat:(NSString *)format
timeZone:(nullable NSTimeZone *)timeZone
locale:(nullable NSLocale *)locale;

/**
 将date转为ISO8601格式字符串
 e.g. "2010-07-09T16:13:30+12:00"
 */
- (nullable NSString *)stringWithISOFormat;

/**
 将一个字符串转为成为指定格式的nsdate
 如果转化失败返回为nil
 
 */
+ (nullable NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;

/**
 将一个字符串转为成为指定格式,指定市区,指定地域的nsdate
 如果转化失败返回为nil
 */
+ (nullable NSDate *)dateWithString:(NSString *)dateString
format:(NSString *)format
timeZone:(nullable NSTimeZone *)timeZone
locale:(nullable NSLocale *)locale;

/**
 将一个符合ISO8601字符串转为成为nsdate
 如果转化失败返回为nil
 */
+ (nullable NSDate *)dateWithISOFormatString:(NSString *)dateString;


/**
 根据传入的时间戳转为时间
 @param  timePoint 时间戳
 @return 指定的时间格式
 */
+ (nonnull NSString *)getDataFromTimePoint:(nonnull NSString *)timePoint;

/**
 判断时间戳是否为当天,昨天,一周内,年月日
 @param timeInterval 时间戳
 @return 相应字符串
 */
+ (NSString *)ew_timeStringWithTimeInterval:(NSString *)timeInterval;

/**
 根据时间字符串判断是否为当天,昨天,一周内,年月日

 @param timeString 时间字符串
 @return 相应字符串
 */
+ (NSString *)ew_timeStringWithTimeString:(NSString *)timeString;

/// 根据日期获取星期几
+ (NSString*)getWeekDayWithdate:(NSDate*)inputDate;

/**
 *  根据传入的时间计算
 *  返回的是刚刚，几分钟前，几小时前，几天前，几月前，几年前
 */
+ (NSString *)ew_formatInfoFromDate:(NSDate *)date;

/**
 *  根据传入的时间计算
 *  返回的是刚刚，几分钟前，几小时前，几天前，之后的统统返回为年月日
 */
+ (NSString *)ew_formatDateFromDate:(NSDate *)date;

/**
 * 获取当前时间的时间戳
 * @return 当前时间的时间戳
 */
+(NSInteger)getNowTimestamp;


+ (NSDate *)getLocalDate;


+ (NSString *)getQuarterBeginAndEndWith:(NSDate *)currentDate;

+ (NSString *)getWeekBeginAndEndWith:(NSDate *)newDate;

+ (NSString *)getMonthBeginAndEndWith:(NSDate *)newDate;

+ (NSString *)getYearBeginWith:(NSDate *)newDate;


@end

NS_ASSUME_NONNULL_END
