//
//  XTTimeDateManger.h
//  StarCredit
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 VCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerSimpleManger.h"

/**
 datefomtter: yyyy-MM-dd HH:mm:ss
 */
@interface XTTimeDateManger : NSObject

/**
 获取当前时间
 */
+(NSString *)currentDateStr;
/**
 获取距离当前时间 x秒
 */
+(NSString *)distanceCurrentDateStr:(NSInteger)second;
/**
 获取距离指定时间 x秒
 */
+(NSString *)distanceDate:(NSDate*)date second:(NSInteger)second;
+(NSString *)distanceSigDate:(NSDate *)date second:(NSInteger)second;
/**
 获取当前时间戳 精确到毫秒
 */
+ (NSString *)currentTimeStr;

/**
时间戳转时间,时间戳精确到毫秒(13位)
 */
+ (NSString *)getDateStringWithTimeStr:(NSString *)str;

/**
 字符串转时间戳 如：2017-4-10 17:15:10
 */
+ (NSString *)getTimeStrWithString:(NSString *)str;

/**
 计算时间差
 NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
 */
+ (NSDateComponents *)pleaseInsertStarTime:(NSString *)time1 andInsertEndTime:(NSString *)time2;

/**
 序列化时间
@"yyyy-MM-dd HH:mm:ss"
 */
+(NSString *)fomatterTime:(NSString *)fomtter date:(NSDate *)date;
+(NSString *)fomatterTime:(NSString *)fomtter dateString:(NSString *)dateString;

/**
 字符串时间转date
 */
+(NSDate *)stringToDate:(NSString *)timeString
           oldFormatter:(NSString *)oldFormatterStr
           newFormatter:(NSString *)newFormatterStr;

/**
 2018-6-20 转化为 2018年6月20日
 */
+(NSString *)timeStringToCalander:(NSString *)timeString;
@end
