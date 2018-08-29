//
//  HomeModelControl.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/13.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeDataModel.h"
#import "UpdateModel.h"

@interface HomeModelControl : NSObject

+(void)getHomeData:(NSDictionary *)paramtar
           success:(void(^)(HomeDataModel *homeDataModel))success
           failure:(void(^)(NSError *error))failure;
+(void)getUpdatInfo:(NSDictionary *)paramtar
            success:(void(^)(UpdateModel *updateModel))success
            failure:(void(^)(NSError *error))failure;
+(void)gethMaodieList:(NSDictionary *)paramtar
              success:(void(^)(NSArray *list))success
              failure:(void(^)(NSError *error))failure;
@end
