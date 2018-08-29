//
//  Help.h
//  DaiFuBao
//
//  Created by 岳腾飞 on 2018/4/29.
//  Copyright © 2018年 come.daifubao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Help : NSObject


/**
 date转String

 @param date date
 @param scal 规则
 @return 根据规则返回String
 */
+(NSString *)dateToString:(NSDate *)date scale:(NSString *)scal;

/**
 返回去除空格和换行的字符串
 */
+ (NSString *)cutStringWithWihtespaceAndNewLine:(NSString *)sourceStr;

/**
 *  MD5加密, 32位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower32Bate:(NSString *)str;

/**
 *  MD5加密, 32位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 *  MD5加密, 16位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower16Bate:(NSString *)str;

/**
 *  MD5加密, 16位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
/**
 获取设备的IDFA
 
 @return IDFA
 */
+(NSString *)getDeviceIDFA;
+(NSString *)phoneNumberSecret:(NSString *)phone;
@end
