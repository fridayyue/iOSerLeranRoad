//
//  BillModelControl.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillModelControl : NSObject
//http://flb.huarenpay.com/app/consumerList
+(void)getConsumerList:(NSDictionary*)paramtar
               success:(void(^)(NSArray *dataArry))success
               failure:(void(^)(NSError *error))failure;
@end
