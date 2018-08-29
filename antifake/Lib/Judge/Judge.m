//
//  Judge.m
//  DaiFuBao
//
//  Created by 岳腾飞 on 2018/4/27.
//  Copyright © 2018年 come.daifubao.com. All rights reserved.
//

#import "Judge.h"

@implementation Judge
+(BOOL)judgeIsNullId:(id)object
{
    if(object == nil)
    {
        return YES;
    }
    else if([object isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(BOOL)judgeDictionaryIsEmptyDictionary:(NSDictionary *)judgeDictionary{
    if (![judgeDictionary isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if (judgeDictionary.count <= 0) {
        return YES;
    }else{
        return NO;
    }
}
+(BOOL)judgeStringIsEmpty:(NSString *)judgeString{
    if (![judgeString isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (judgeString == nil || judgeString == NULL) {
        return YES;
    }
    if ([judgeString isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[judgeString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)judgePhoneNumber:(NSString *)judgeString {
    
    // 只判断1开头，11位数字
    NSString *phoneRegex = @"1[0-9]{10}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:judgeString];
    
}
+(BOOL)judgePWD:(NSString *)pwdString{
    if (!pwdString) {
        return NO;
    }
    pwdString = [Help cutStringWithWihtespaceAndNewLine:pwdString];
    if (pwdString.length < 6 || pwdString.length > 16) {
        return NO;
    }
    return YES;
}
@end
