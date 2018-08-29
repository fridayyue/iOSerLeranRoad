//
//  DSPModelControl.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/26.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DSPModelControl.h"

@implementation DSPModelControl
+(void)allQualicationState:(NSDictionary *)paramatr
                   success:(void (^)(DSPAllQualicationStateModel *))success
                   failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_allQualicationState paramaters:paramatr succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSDictionary *data = [respond objectForKey:@"data"];
            DSPAllQualicationStateModel *model = [[DSPAllQualicationStateModel alloc] initWithDictionary:data error:nil];
            success(model);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)getMacLists:(NSDictionary *)paramtar success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_macLists paramaters:paramtar succeed:^(id respond, NSInteger status) {
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
+(void)getDspMacList:(NSDictionary *)paramtar
             success:(void (^)(NSArray *))success
             failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_getDspMacList paramaters:paramtar succeed:^(id respond, NSInteger status) {
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
+(void)getMeiTilist:(NSDictionary *)paramtar
            success:(void (^)(NSArray *, NSInteger))success
            failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_searchMedia paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSArray *data = [respond objectForKey:@"data"];
            NSInteger total = [[respond objectForKey:@"totalCount"] integerValue];
            success(data,total);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}

+(void)getFindAdv:(NSDictionary *)paramtar
          success:(void (^)(NSArray *))success
          failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_findAdv paramaters:paramtar succeed:^(id respond, NSInteger status) {
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
+(void)dspMarket:(NSDictionary *)paramtar
         success:(void (^)(NSString *))success
         failure:(void (^)(NSString *))failure{
    [[NetWorking shareManger] postWithMethod:Net_dspMarket paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSString *data = [respond objectForKey:@"msg"];
            success(data);
        }else{
             NSString *data = [respond objectForKey:@"msg"];
            failure(data);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(@"");
    }];
}
@end
