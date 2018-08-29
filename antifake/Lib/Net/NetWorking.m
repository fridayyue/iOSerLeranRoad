//
//  NetWorking.m
//  DaiFuBao
//
//  Created by Liu Hui on 2018/5/14.
//  Copyright © 2018年 come.daifubao.com. All rights reserved.
//

#import "NetWorking.h"
#import <AFNetworking.h>
#import "NetBasicModel.h"
#import "NetLog.h"

static NetWorking *netWorking;

@implementation NetWorking
+(instancetype)shareManger{
    static dispatch_once_t netToken;
    dispatch_once(&netToken, ^{
        netWorking = [[NetWorking alloc] init];
    });
    return netWorking;
}
-(void)postWithMethod:(NSString *)methodString paramaters:(id)parameters succeed:(void (^)(id, NSInteger))succeed failure:(void (^)(NSError *, NSInteger))failure{
//    [self postWithMethod:methodString hostURL:Net_Host paramaters:parameters isEncoding:YES waitTimeInterval:60 succeed:succeed failure:failure];
    [self postWithMethod:methodString hostURL:Net_Host paramaters:parameters isEncoding:YES waitTimeInterval:60 progress:nil succeed:succeed failure:failure];
}
-(void)postWithMethod:(NSString *)methodString paramaters:(id)parameters progress:(void (^)(NSProgress *))progressBlock succeed:(void (^)(id, NSInteger))succeed failure:(void (^)(NSError *, NSInteger))failure{
    [self postWithMethod:methodString hostURL:Net_Host paramaters:parameters isEncoding:YES waitTimeInterval:60 progress:progressBlock succeed:succeed failure:failure];
}
-(void)postWithMethod:(NSString *)methodString hostURL:(NSString *)hostURL paramaters:(id)parameters isEncoding:(BOOL)isEncoding waitTimeInterval:(NSTimeInterval)waitTime progress:(void (^)(NSProgress *))progressBlock succeed:(void (^)(id, NSInteger))succeed failure:(void (^)(NSError *, NSInteger))failure{
    NetLog *log = [[NetLog alloc] init];
    log.logModel = [[NetLogModel alloc] init];
    log.logModel.requestUrl = [self managePostUrl:hostURL method:methodString];
    log.logModel.parameters = [self mangerParamters:parameters];
    log.logModel.requestStarTime = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    __block typeof(log)blockLog = log;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[self managePostUrl:hostURL method:methodString] parameters:[self mangerParamters:parameters] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress);

        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* responesDic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        blockLog.logModel.respondData = responesDic;
        blockLog.logModel.endRequestTime = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
        if ([[responesDic objectForKey:@"flag"] integerValue] == 1) {
            succeed(responesDic,1);
        }else if([[responesDic objectForKey:@"flag"] integerValue] == 0){
            if ([Judge judgeStringIsEmpty:[responesDic objectForKey:@"msg"]]) {
                [SVProgressHUD showErrorWithStatus:@"错误！"];
            }else{
                [SVProgressHUD showErrorWithStatus:[responesDic objectForKey:@"msg"]];
            }
            
            failure(nil,0);
        }else{
            failure(nil,-1000);
        }
        [blockLog logNet];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,-1);
        blockLog.logModel.endRequestTime = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
        [blockLog logNet];
    }];
}
-(NSString *)managePostUrl:(NSString *)hostString method:(NSString *)method{
    return [hostString stringByAppendingString:method];
}
-(NSDictionary *)mangerParamters:(NSDictionary *)paratmtar{
    if ([Judge judgeDictionaryIsEmptyDictionary:paratmtar]) {
        return @{};
    }
    return paratmtar;
}
@end
