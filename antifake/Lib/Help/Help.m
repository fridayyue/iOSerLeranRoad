//
//  Help.m
//  DaiFuBao
//
//  Created by 岳腾飞 on 2018/4/29.
//  Copyright © 2018年 come.daifubao.com. All rights reserved.
//

#import "Help.h"
#import <CommonCrypto/CommonCrypto.h>
#import <AdSupport/AdSupport.h>

@implementation Help
+(NSString *)dateToString:(NSDate *)date scale:(NSString *)scal{
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:scal];
    //NSDate转NSString
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
//返回去除空格和换行的字符串
+ (NSString *)cutStringWithWihtespaceAndNewLine:(NSString *)sourceStr
{
    return [sourceStr stringByReplacingOccurrencesOfString:@" " withString:@""];
}
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
+(NSString *)getDeviceIDFA{
    return [[NSString alloc] initWithString:[[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString]];
}
+(NSString *)phoneNumberSecret:(NSString *)phone{
    NSString *secret = @"";
    if (phone.length >= 7) {
        secret = [phone stringByReplacingOccurrencesOfString:[phone substringWithRange:NSMakeRange(3, 4)] withString:@"****"];
    }else{
        secret = @"****";
    }
    return secret;
}
@end
