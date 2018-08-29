//
//  StatementModelControl.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/4.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatementModelControl : NSObject
//http://flb.huarenpay.com/app/stat/smsList
+(void)smsList:(NSDictionary *)paramtar
       success:(void(^)(NSArray *array))success
       failure:(void(^)(NSError *error))failure;
//http://flb.huarenpay.com/app/stat/flashSmsList
+(void)flashSmsList:(NSDictionary *)paramtar
            success:(void(^)(NSArray *array))success
            failure:(void(^)(NSError *error))failure;
//http://flb.huarenpay.com/app/stat/callLogList
+(void)callLogList:(NSDictionary *)paramtar
           success:(void(^)(NSArray *array))success
           failure:(void(^)(NSError *error))failure;
@end
