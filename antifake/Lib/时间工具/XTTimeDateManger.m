//
//  XTTimeDateManger.m
//  StarCredit
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 VCredit. All rights reserved.
//

#import "XTTimeDateManger.h"

@implementation XTTimeDateManger
+(NSString *)currentDateStr{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    return dateString;
}
+(NSString *)distanceCurrentDateStr:(NSInteger)second{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *before = [currentDate dateByAddingTimeInterval:second];
    NSString *dateString = [dateFormatter stringFromDate:before];//将时间转化成字符串
    return dateString;
}
+(NSString *)distanceSigDate:(NSDate *)date second:(NSInteger)second{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *before = [date dateByAddingTimeInterval:second];
    NSString *dateString = [dateFormatter stringFromDate:before];//将时间转化成字符串
    return dateString;
}
+(NSString *)distanceDate:(NSDate *)date second:(NSInteger)second{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *before = [date dateByAddingTimeInterval:second];
    NSString *dateString = [dateFormatter stringFromDate:before];//将时间转化成字符串
    return dateString;
}
+(NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
+(NSString *)getDateStringWithTimeStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;

}

+(NSString *)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}
+ (NSDateComponents *)pleaseInsertStarTime:(NSString *)time1 andInsertEndTime:(NSString *)time2{
    // 1.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
    // 2.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 3.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    // 4.输出结果
    return cmps;
//    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
}
+(NSString *)fomatterTime:(NSString *)fomtter date:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fomtter];
    return [formatter stringFromDate:date];
}
+(NSString *)fomatterTime:(NSString *)fomtter dateString:(NSString *)dateString{
    NSDateFormatter *oldFormatter = [[NSDateFormatter alloc] init];
    [oldFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    [newFormatter setDateFormat:fomtter];
    return [newFormatter stringFromDate:[oldFormatter dateFromString:dateString]];
}
+(NSDate *)stringToDate:(NSString *)timeString formatter:(NSString *)formatter{
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    [newFormatter setDateFormat:formatter];
    NSDate *date = [newFormatter dateFromString:timeString];
    return date;
}
+(NSDate *)stringToDate:(NSString *)timeString
           oldFormatter:(NSString *)oldFormatterStr
           newFormatter:(NSString *)newFormatterStr{
    NSDateFormatter *oldFormatter = [[NSDateFormatter alloc] init];
    [oldFormatter setDateFormat:oldFormatterStr];
    [oldFormatter setLocale:[NSLocale currentLocale]];
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    [newFormatter setDateFormat:newFormatterStr];
    [newFormatter setLocale:[NSLocale currentLocale]];
    NSString *formaterString = [newFormatter stringFromDate:[oldFormatter dateFromString:timeString]];
    return [newFormatter dateFromString:formaterString];
}
+(NSString *)timeStringToCalander:(NSString *)timeString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:[dateFormatter dateFromString:timeString]];
    NSString *dateCalender = [NSString stringWithFormat:@"%ld年%ld月%ld日",dateComponent.year,dateComponent.month,dateComponent.day];
    return dateCalender;
}
@end
