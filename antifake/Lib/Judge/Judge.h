//
//  Judge.h
//  DaiFuBao
//
//  Created by 岳腾飞 on 2018/4/27.
//  Copyright © 2018年 come.daifubao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Judge : NSObject
/**
 判断对象为空对象
 
 @param object 输入对象
 @return 对象是否为空
 */
+(BOOL)judgeIsNullId:(id)object;
/**
 判断字典对象是否为字典或者是否为空
 
 @param judgeDictionary 被判断的输入的dic
 @return YES,不是字典类型或者为空字典,NO，是字典类型，不为空
 */
+(BOOL)judgeDictionaryIsEmptyDictionary:(NSDictionary *)judgeDictionary;

/**
 判断字符串为空字符串或者是否为字符串类型
 
 @param judgeString 判断的字符串
 @return YES：为空字符串或者类型不为字符串，NO：是字符串类型并不为空
 */
+(BOOL)judgeStringIsEmpty:(NSString *)judgeString;


/**
 判断字符串是不是手机号码
 
 @param judgeString 判断的字符串
 @return YES：是手机号码，NO：不是手机号码
 */
+ (BOOL)judgePhoneNumber:(NSString *)judgeString;

/**
 判断密码
 */
+(BOOL)judgePWD:(NSString *)pwdString;
@end
