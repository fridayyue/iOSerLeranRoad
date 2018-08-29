//
//  HomeModelControl.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/13.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "HomeModelControl.h"

@implementation HomeModelControl
+(void)getHomeData:(NSDictionary *)paramtar
           success:(void (^)(HomeDataModel *))success
           failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_statData paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSDictionary *data = [respond objectForKey:@"data"];
            HomeDataModel *homeDataModel = [[HomeDataModel alloc] initWithDictionary:data error:nil];
            success(homeDataModel);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)getUpdatInfo:(NSDictionary *)paramtar
            success:(void (^)(UpdateModel *))success
            failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_appVersionsIos paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSDictionary *data = [respond objectForKey:@"data"];
             UpdateModel *updateModel = [[UpdateModel alloc] initWithDictionary:data error:nil];
            success(updateModel);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)gethMaodieList:(NSDictionary *)paramtar
              success:(void (^)(NSArray *))success
              failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_maodieList paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSArray *data = [respond objectForKey:@"data"];
            success(data);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
@end
