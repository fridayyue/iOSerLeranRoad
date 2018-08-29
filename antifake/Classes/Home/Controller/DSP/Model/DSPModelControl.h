//
//  DSPModelControl.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/26.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPAllQualicationStateModel.h"

@interface DSPModelControl : NSObject
//http://flb.huarenpay.com/app/allQualicationState
+(void)allQualicationState:(NSDictionary *)paramatr
                    success:(void (^)(DSPAllQualicationStateModel *allQualicationStateModel))success
                   failure:(void (^)(NSError *error))failure;
+(void)getMacLists:(NSDictionary *)paramtar
           success:(void(^)(NSArray *array))success
           failure:(void(^)(NSError *error))failure;

+(void)getDspMacList:(NSDictionary *)paramtar
             success:(void(^)(NSArray *array))success
             failure:(void(^)(NSError *error))failure;

+(void)getMeiTilist:(NSDictionary *)paramtar
            success:(void(^)(NSArray *array ,NSInteger total))success
            failure:(void(^)(NSError *error))failure;

+(void)getFindAdv:(NSDictionary *)paramtar
          success:(void(^)(NSArray *array))success
          failure:(void(^)(NSError *error))failure;
//http://flb.huarenpay.com/app/dspMarket
+(void)dspMarket:(NSDictionary *)paramtar
         success:(void(^)(NSString *msg))success
         failure:(void(^)(NSString *msg))failure;
@end
