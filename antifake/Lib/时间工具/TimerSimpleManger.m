//
//  TimerSimpleManger.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/27.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "TimerSimpleManger.h"

@implementation TimerSimpleManger
+(NSString *)currentDateStr{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    return dateString;
}

@end
