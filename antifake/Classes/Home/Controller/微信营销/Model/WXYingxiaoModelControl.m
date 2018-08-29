//
//  WXYingxiaoModelControl.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/17.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "WXYingxiaoModelControl.h"


@implementation WXYingxiaoModelControl
+(void)getFunSelectArray:(NSDictionary *)paramtar success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_wxFriendsHobbyList paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSMutableArray *muArray = @[].mutableCopy;
//            NSMutableArray *parentArray = @[].mutableCopy;
//            NSMutableArray *chrildArray = @[].mutableCopy;
            NSMutableArray *dataArray = [NSMutableArray arrayWithArray:[respond objectForKey:@"data"]];
            for (NSDictionary *dataDic in dataArray) {
                WXFunModel *model = [[WXFunModel alloc] initWithDictionary:dataDic error:nil];
                if (model.parent_id == 0) {
                    [muArray addObject:model];
                }
            }
            NSInteger count = muArray.count;
            for (NSInteger index = 0; index < count; index ++) {
                 WXFunModel *pModel = muArray[index];
                pModel.chrildArray = @[].mutableCopy;
                for (NSDictionary *dataDic in dataArray) {
                    WXFunModel *cModel = [[WXFunModel alloc] initWithDictionary:dataDic error:nil];
                    if (cModel.parent_id == pModel.id){
                        [pModel.chrildArray addObject:cModel];
                    }
                }
                [muArray replaceObjectAtIndex:index withObject:pModel];
            }
            success(muArray);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
+(void)getqueryFileList:(NSDictionary *)paramtar
                success:(void (^)(NSArray *))success
                failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_queryFileList paramaters:paramtar succeed:^(id respond, NSInteger status) {
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
+(void)uploadFile:(NSDictionary *)paramtar progress:(void (^)(NSProgress *))progressBlock success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_uploadFile paramaters:paramtar progress:progressBlock succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSString *data = [respond objectForKey:@"data"];
            success(data);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
         failure(error);
    }];
}
+(void)deleteFile:(NSDictionary *)paramtar success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
    [[NetWorking shareManger] postWithMethod:Net_deleteFile paramaters:paramtar succeed:^(id respond, NSInteger status) {
        if (status == 1) {
            NSString *data = [respond objectForKey:@"data"];
            success(data);
        }else{
            failure(nil);
        }
    } failure:^(NSError *error, NSInteger stauts) {
        failure(error);
    }];
}
@end
