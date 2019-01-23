//
//  NSDate+EWSugar.m
//  EWSugarDemo
//
//  Created by Eric Wang on 2015/12/18.
//  Copyright © 2015年 Eric Wang. All rights reserved.
//

#import "NSDate+EWSugar.h"
#import "EWCategoriesMacro.h"
#import <time.h>
#import "UtilsMacros.h"

static NSString *kNSDateHelperFormatFullDateWithTime    = @"MMM d, yyyy h:mm a";
static NSString *kNSDateHelperFormatFullDate            = @"MMM d, yyyy";
static NSString *kNSDateHelperFormatShortDateWithTime   = @"MMM d h:mm a";
static NSString *kNSDateHelperFormatShortDate           = @"MMM d";
static NSString *kNSDateHelperFormatWeekday             = @"EEEE";
static NSString *kNSDateHelperFormatWeekdayWithTime     = @"EEEE h:mm a";
static NSString *kNSDateHelperFormatTime                = @"h:mm a";
static NSString *kNSDateHelperFormatTimeWithPrefix      = @"'at' h:mm a";
static NSString *kNSDateHelperFormatSQLDate             = @"yyyy-MM-dd";
static NSString *kNSDateHelperFormatSQLTime             = @"HH:mm:ss";
static NSString *kNSDateHelperFormatSQLDateWithTime     = @"yyyy-MM-dd HH:mm:ss";
EWSYNTH_DUMMY_CLASS(NSDate_EWSugar)
@implementation NSDate (EWSugar)
#pragma mark - 单例
+ (NSDateFormatter *)ew_sharedDateFormatter {
  static NSDateFormatter *dateFormatter;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
  });
  
  return dateFormatter;
}

+ (NSCalendar *)ew_sharedCalendar {
  static NSCalendar *calendar;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    calendar = [NSCalendar currentCalendar];
  });
  
  return calendar;
}


- (NSInteger)year {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)isLeapMonth {
  return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)isLeapYear {
  NSUInteger year = self.year;
  return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)isToday {
  if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
  return [NSDate new].day == self.day;
}

- (BOOL)isYesterday {
  NSDate *added = [self dateByAddingDays:1];
  return [added isToday];
}

- (BOOL)isDayBeforeYesterday {
  NSDate *added = [self dateByAddingDays:2];
  return [added isToday];
}

- (NSDate *)dateByAddingYears:(NSInteger)years {
  NSCalendar *calendar =  [NSCalendar currentCalendar];
  NSDateComponents *components = [[NSDateComponents alloc] init];
  [components setYear:years];
  return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components = [[NSDateComponents alloc] init];
  [components setMonth:months];
  return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components = [[NSDateComponents alloc] init];
  [components setWeekOfYear:weeks];
  return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
  NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
  return newDate;
}

- (NSDate *)dateByAddingHours:(NSInteger)hours {
  NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 3600 * hours;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
  return newDate;
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes {
  NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 60 * minutes;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
  return newDate;
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds {
  NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + seconds;
  NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
  return newDate;
}

- (NSString *)stringWithFormat:(NSString *)format {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:format];
  [formatter setLocale:[NSLocale currentLocale]];
  return [formatter stringFromDate:self];
}

- (NSString *)stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:format];
  if (timeZone) [formatter setTimeZone:timeZone];
  if (locale) [formatter setLocale:locale];
  return [formatter stringFromDate:self];
}

- (NSString *)stringWithISOFormat {
  static NSDateFormatter *formatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
  });
  return [formatter stringFromDate:self];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:format];
  return [formatter dateFromString:dateString];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:format];
  if (timeZone) [formatter setTimeZone:timeZone];
  if (locale) [formatter setLocale:locale];
  return [formatter dateFromString:dateString];
}

+ (NSDate *)dateWithISOFormatString:(NSString *)dateString {
  static NSDateFormatter *formatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
  });
  return [formatter dateFromString:dateString];
}


/// 计算时间戳
+ (NSString *)getDataFromTimePoint:(NSString *)timePoint {
  
  if ([timePoint isEqual:[NSNull null]]) {
    
    return @"";
  }
  
  [[self ew_sharedDateFormatter] setDateFormat:@"YYYYMMddHHmmss"];
  
  NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timePoint integerValue] / 1000];
  
  return [[self ew_sharedDateFormatter] stringFromDate:confromTimesp];
}


+ (NSString *)ew_timeStringWithTimeString:(NSString *)timeString {
  
  //    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval.longLongValue/1000]; //此处根据项目需求,选择是否除以1000 , 如果时间戳精确到秒则去掉1000
  
  NSDateFormatter *formatter = [NSDate ew_sharedDateFormatter];
  NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
  [formatter setTimeZone:timeZone];
  //    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
  [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  
  NSDate *date = [formatter dateFromString:timeString];
  
  NSTimeInterval timeInterval = [date timeIntervalSinceNow];
  timeInterval = -timeInterval;
  
  NSInteger res = [self compareOneDay:[NSDate date] withAnotherDay:date];
  if (res == -1) {
    return @"刚刚";
  }
  
  //今天
  if (date.isToday) {
    NSInteger temp = 0;
    NSString *result = nil;
    if (timeInterval < 60) {
      result = @"刚刚";
      return result;
    }else if((temp = timeInterval/60) <60){
      result = [NSString stringWithFormat:@"%zd分钟前",temp];
      return result;
    }else {
      temp = timeInterval / 60 / 24;
      result = [NSString stringWithFormat:@"%zd小时之前",temp];
      return result;
//      formatter.dateFormat = @"HH:mm";
//      return [formatter stringFromDate:date];
    }
  }else if ([date isYesterday]) {
    formatter.dateFormat = @"昨天HH:mm";
    return [formatter stringFromDate:date];
  }else if ([date isDayBeforeYesterday]) {
    formatter.dateFormat = @"前天HH:mm";
    return [formatter stringFromDate:date];
  }else {
    if ([date isThisYear]) {
      formatter.dateFormat = @"MM-dd HH:mm";
      return [formatter stringFromDate:date];
    }else {
      formatter.dateFormat = @"yyyy-MM-dd HH:mm";
      return [formatter stringFromDate:date];
    }
  }
  return nil;
}



+ (NSString *)ew_timeStringWithTimeInterval:(NSString *)timeInterval {
  
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval.longLongValue/1000]; //此处根据项目需求,选择是否除以1000 , 如果时间戳精确到秒则去掉1000
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
  
  //今天
  if ([date isToday]) {
    
    formatter.dateFormat = @"HH:mm";
    
    return [formatter stringFromDate:date];
  }else{
    
    //昨天
    if (date.isYesterday) {
      
      formatter.dateFormat = @"昨天HH:mm";
      return [formatter stringFromDate:date];
      
      //一周内 [date weekdayStringFromDate]
    }else if ([date isSameWeek]){
      
      formatter.dateFormat = [NSString stringWithFormat:@"%@%@",[date weekdayStringFromDate],@"HH:mm"];
      return [formatter stringFromDate:date];
      
      //直接显示年月日
    }else{
      
      formatter.dateFormat = @"yy-MM-dd  HH:mm";
      return [formatter stringFromDate:date];
    }
  }
  return nil;
}


//是否在同一周
- (BOOL)isSameWeek
{
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  int unit = NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear ;
  
  //1.获得当前时间的 年月日
  NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
  
  //2.获得self
  NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
  
  return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}


//根据日期求星期几
- (NSString *)weekdayStringFromDate{
  
  NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
  
  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  
  NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
  
  [calendar setTimeZone: timeZone];
  
  NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
  
  NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
  
  return [weekdays objectAtIndex:theComponents.weekday];
  
}




//是否为今天
/*
 - (BOOL)isToday
 {
 //now: 2015-09-05 11:23:00
 //self 调用这个方法的对象本身
 
 NSCalendar *calendar = [NSCalendar currentCalendar];
 int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
 
 //1.获得当前时间的 年月日
 NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
 
 //2.获得self
 NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
 
 return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
 }
 */

- (BOOL)isThisYear
{
  //now: 2015-09-05 11:23:00
  //self 调用这个方法的对象本身
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
  
  //1.获得当前时间的 年月日
  NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
  
  //2.获得self
  NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
  
  return (selfCmps.year == nowCmps.year);
}



//是否为昨天
/*
 - (BOOL)isYesterday
 {
 //2014-05-01
 NSDate *nowDate = [[NSDate date] dateWithYMD];
 
 //2014-04-30
 NSDate *selfDate = [self dateWithYMD];
 
 //获得nowDate和selfDate的差距
 NSCalendar *calendar = [NSCalendar currentCalendar];
 NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
 
 return cmps.day == 1;
 }
 */

//格式化
- (NSDate *)dateWithYMD
{
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"yyyy-MM-dd";
  NSString *selfStr = [fmt stringFromDate:self];
  return [fmt dateFromString:selfStr];
}

//通过日期求星期
+(NSString*)getWeekDayWithdate:(NSDate*)inputDate
{
  NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:inputDate];
  
  NSInteger yearInt   = [comps year];
  NSInteger monthInt  = [comps month];
  NSInteger dayInt    = [comps day];
  int c = 20;//世纪
  int y = (int)yearInt -1;//年
  int d = (int)dayInt;
  int m = (int)monthInt;
  int w =(y+(y/4)+(c/4)-2*c+(26*(m+1)/10)+d-1)%7;
  NSString *weekDay = @"";
  switch (w) {
    case 0: weekDay = @"周日";    break;
    case 1: weekDay = @"周一";    break;
    case 2: weekDay = @"周二";    break;
    case 3: weekDay = @"周三";    break;
    case 4: weekDay = @"周四";    break;
    case 5: weekDay = @"周五";    break;
    case 6: weekDay = @"周六";    break;
    default:break;
  }
  return weekDay;
}


+ (NSString *)ew_formatInfoFromDate:(NSDate *)date {
  NSString *returnString = @"";
  NSTimeInterval time = fabs([[NSDate date] timeIntervalSinceDate:date]);
  if(time < 60)
    returnString = @"刚刚";
  else if(time >=60 && time < 3600)
    returnString = [NSString stringWithFormat:@"%.0f分钟前",time/60];
  else if(time >= 3600 && time < 3600 * 24)
    returnString = [NSString stringWithFormat:@"%.0f小时前",time/(60 * 60)];
  else if(time >= 3600 * 24 && time < 3600 * 24 * 30)
    returnString = [NSString stringWithFormat:@"%.0f天前",time/(60 * 60 * 24)];
  else if(time >= 3600 * 24 * 30 && time < 3600 * 24 * 30 * 12)
    returnString = [NSString stringWithFormat:@"%.0f月前",time/(60 * 60 * 24 * 30)];
  else if(time >= 3600 * 24 * 30 * 12)
    returnString = [NSString stringWithFormat:@"%.0f年前",time/(60 * 60 * 24 * 30 * 12)];
  return returnString;
}

+ (NSString *)ew_formatDateFromDate:(NSDate *)date {
  NSString *returnString = @"";
  NSTimeInterval time = fabs([[NSDate date] timeIntervalSinceDate:date]);
  if(time < 60)
    returnString = @"刚刚";
  else if(time >=60 && time < 3600)
    returnString = [NSString stringWithFormat:@"%.0f分钟前",time/60];
  else if(time >= 3600 && time < 3600 * 24)
    returnString = [NSString stringWithFormat:@"%.0f小时前",time/(60 * 60)];
  else if(time >= 3600 * 24 && time < 3600 * 24 * 3)
    returnString = [NSString stringWithFormat:@"%.0f天前",time/(60 * 60 * 24)];
  else {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    returnString = [formatter stringFromDate:date];
  }
  return returnString;
}

//获取当前时间戳
+(NSInteger)getNowTimestamp{
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  
  [formatter setDateStyle:NSDateFormatterMediumStyle];
  
  [formatter setTimeStyle:NSDateFormatterShortStyle];
  
  [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
  
  //设置时区,这个对于时间的处理有时很重要
  
  NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
  
  [formatter setTimeZone:timeZone];
  
  NSDate *datenow = [NSDate date];//现在时间
  
  EWLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
  
  NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
  
  EWLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
  
  return timeSp;
  
}


+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
  NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
  NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
  NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
  NSComparisonResult result = [dateA compare:dateB];
  //  EWLog(@"oneDay : %@, anotherDay : %@", oneDay, anotherDay);
  if (result == NSOrderedDescending) {
    //在指定时间前面 过了指定时间 过期
    return 1;
  }
  else if (result == NSOrderedAscending){
    //没过指定时间 没过期
    return -1;
  }
  //刚好时间一样.
  return 0;
  
}


+(NSDate *)getLocalDate {
  NSDate *date = [NSDate date];
  NSTimeZone *zone = [NSTimeZone systemTimeZone];
  NSInteger interval = [zone secondsFromGMTForDate: date];
  NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
  return localeDate;
}


/// 获取参数时间的所在季度
+ (NSString *)getQuarterBeginAndEndWith:(NSDate *)currentDate{
  
  NSDate *nowDate = (currentDate != nil) ? currentDate : [NSDate date];
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
  NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
  
  /**获取当前的月份*/
  
  NSInteger curentMonth = [comp month];
  
  NSString * currentYear = [NSString stringWithFormat:@"%ld",[comp year]];
  
  NSString * beginTime = [self getQuarterStartDateWithYear:currentYear currentMonth:curentMonth];
  
  NSString * endTime = [self getQuarterEndDateWithYear:currentYear currentMonth:curentMonth];
  
  NSString * str = [NSString stringWithFormat:@"季度开始时间 == %@  季度结束时间 == %@",beginTime,endTime];
  
  EWLog(@"%@",str);
  return beginTime;
  
}



//获得某季度的开始日期
+ (NSString *)getQuarterStartDateWithYear:(NSString *)paraYear currentMonth:(NSInteger)currentMonth {
  NSString * beginTime = @"";
  
  if (currentMonth < 4) {
    beginTime = [paraYear stringByAppendingString:@"-01-01"];
  } else if (currentMonth >= 4 && currentMonth < 7) {
    beginTime = [paraYear stringByAppendingString:@"-04-01"];
  } else if (currentMonth >= 7 && currentMonth < 10) {
    beginTime = [paraYear stringByAppendingString:@"-07-01"];
  } else if (currentMonth >= 10 && currentMonth < 12) {
    beginTime = [paraYear stringByAppendingString:@"-10-01"];
  }
  return beginTime;
}



//获得某季度的结束日期
+ (NSString *)getQuarterEndDateWithYear:(NSString *)paraYear currentMonth:(NSInteger)currentMonth {
  NSString * endTime = @"";
  if (currentMonth < 4) {
    endTime = [paraYear stringByAppendingString:@"-03-31"];
  } else if (currentMonth >= 4 && currentMonth < 7) {
    endTime = [paraYear stringByAppendingString:@"-06-30"];
  } else if (currentMonth >= 7 && currentMonth < 10) {
    endTime = [paraYear stringByAppendingString:@"-09-30"];
  } else if (currentMonth >= 10 && currentMonth < 12) {
    endTime = [paraYear stringByAppendingString:@"-12-31"];
  }
  return endTime;
}


// 获取本周的起始时间
+ (NSString *)getWeekBeginAndEndWith:(NSDate *)newDate{
  NSDate *nowDate = (newDate != nil) ? newDate : [NSDate date];
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
  NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
  
  // 获取今天是周几
  
  NSInteger weekDay = [comp weekday];
  
  /**获取当前几个月*/
  
  NSInteger monthDay = [comp month];
  
  EWLog(@"%ld",monthDay);
  
  
  
  // 获取几天是几号
  
  NSInteger day = [comp day];
  
  EWLog(@"%ld----%ld",weekDay,day);
  
  
  
  // 计算当前日期和本周的星期一和星期天相差天数
  
  long firstDiff,lastDiff;
  
  //    weekDay = 1;
  
  if (weekDay == 1)
    
  {
    
    firstDiff = -6;
    
    lastDiff = 0;
    
  }
  
  else
    
  {
    
    firstDiff = [calendar firstWeekday] - weekDay + 1;
    
    lastDiff = 8 - weekDay;
    
  }
  
  EWLog(@"firstDiff: %ld   lastDiff: %ld",firstDiff,lastDiff);
  
  
  
  // 在当前日期(去掉时分秒)基础上加上差的天数
  
  NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
  
  [firstDayComp setDay:day + firstDiff];
  
  NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
  
  
  
  NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:nowDate];
  
  [lastDayComp setDay:day + lastDiff];
  
  NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];

  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  
  [formatter setDateFormat:@"yyyy-MM-dd"];
  
  NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
  
  NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
  
  EWLog(@"%@=======%@",firstDay,lastDay);

  NSString *dateStr = [NSString stringWithFormat:@"%@-%@",firstDay,lastDay];
  
  EWLog(@"%@",dateStr);
  return firstDay;
}


// 获取本月的时间
+ (NSString *)getMonthBeginAndEndWith:(NSDate *)newDate{
  
  if (newDate == nil) {
    
    newDate = [NSDate date];
 
  }
  
  double interval = 0;
  
  NSDate *beginDate = nil;
  
  NSDate *endDate = nil;
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
  [calendar setFirstWeekday:2];
  
  //设定周一为周首日
  
  BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate]; //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
  
  if (ok) {
    
    endDate = [beginDate dateByAddingTimeInterval:interval-1];
    
    
    
  }else {
    
    return @"";
    
    
    
  }
  
  NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
  
  [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
  
  NSString *beginString = [myDateFormatter stringFromDate:beginDate];
  
  NSString *endString = [myDateFormatter stringFromDate:endDate];
  
  NSString *s = [NSString stringWithFormat:@"%@-%@",beginString,endString];
  
  EWLog(@"%@",s);
  
  return beginString;
  
}


+ (NSString *)getYearBeginWith:(NSDate *)newDate{
  if (newDate == nil) {
    newDate = [NSDate date];
  }
  NSString *currentYear = [NSString stringWithFormat:@"%zd",newDate.year];
  NSString * beginTime = [self getQuarterStartDateWithYear:currentYear currentMonth:newDate.month];
  return beginTime;
  
}
@end
