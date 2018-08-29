//
//  MeModelControl.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "MeModelControl.h"

@implementation MeModelControl
+(void)getsmsCode:(id)paratmtar
          success:(void (^)(GetVocodeModel *))success
          failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_getSmsYzm paramaters:paratmtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            GetVocodeModel *gevcodeModel = [[GetVocodeModel alloc] initWithDictionary:respond error:nil];
            success(gevcodeModel);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)getPhoneList:(id)paramtar
            success:(void (^)(NSArray *))success
            failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_CallPhoneList paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            success([respond objectForKey:@"data"]);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        
    }];
}
+(void)addPhone:(id)paramtar
        success:(void (^)(NSDictionary *))success
        failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_addCallPhone paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            success([respond objectForKey:@"data"]);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        
    }];
}
+(void)delegatePhone:(id)paramtar
             success:(void (^)(NSDictionary *))success
             failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_delCallPhone paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            success([respond objectForKey:@"data"]);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        
    }];
}
@end
