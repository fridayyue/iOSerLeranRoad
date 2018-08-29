//
//  NSString+CustomString.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/23.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "NSString+CustomString.h"

@implementation NSString (CustomString)
+(NSString *)floatFormatterString:(CGFloat)floatS{
    NSString *floatString = [NSString stringWithFormat:@"%.2lf",floatS];
    return floatString;
}
@end
