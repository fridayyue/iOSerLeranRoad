//
//  DXModelControl.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/23.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXModelControl : NSObject
+(void)getChooseTelData:(NSDictionary*)paramtar
                success:(void(^)(NSArray *dataArry))success
                failure:(void(^)(NSError *error))failure;

+(void)getQuerySmsTemplate:(NSDictionary *)paramtar
                   success:(void(^)(NSArray *dataArry))success
                   failure:(void(^)(NSError *error))failure;

+(void)getDelSmsTemplate:(NSDictionary *)paramtar
                 success:(void(^)(NSString *str))success
                 failure:(void(^)(NSError *error))failure;

+(void)submitSmsTemplate:(NSDictionary *)paramtar
                 success:(void(^)(NSString *str))success
                 failure:(void(^)(NSError *error))failure;

+(void)sms:(NSDictionary *)paramtar
   success:(void(^)(NSString *str))success
   failure:(void(^)(NSError *error))failure;

+(void)submitFlashSmsTemplate:(NSDictionary *)paramtar
                      success:(void(^)(NSString *str))success
                      failure:(void(^)(NSError *error))failure;

+(void)getSignList:(NSDictionary *)paramtar
           success:(void(^)(NSArray *dataArry))success
           failure:(void(^)(NSError *error))failure;

+(void)submitSign:(NSDictionary *)paramtar
          success:(void(^)(NSString *str))success
          failure:(void(^)(NSError *error ,NSString *errorString))failure;
@end
