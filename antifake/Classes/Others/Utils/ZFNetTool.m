//
//  ZFNetTool.m
//  iParent
//
//  Created by chengRui on 2017/5/22.
//  Copyright © 2017年 chengRui. All rights reserved.
//

// 公司测试地址
//#define BasicURL  @"http://116.62.130.43:7756/api/"


// 最新地址  http://nbth.67money.com/
//#define BasicURL  @"http://118.31.229.172:7756/"



#import "ZFNetTool.h"

#import <AFNetworking.h>

#import <MJExtension.h>

@implementation ZFNetTool



+ (AFHTTPSessionManager *)sharedHTTPSession{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 20;
//        [manager.requestSerializer  setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return manager;
}


+ (AFURLSessionManager *)sharedURLSession{
    static AFURLSessionManager *urlsession = nil;
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        urlsession = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return urlsession;
}



+ (ZFNetTool *)shareNetTool
{
    static ZFNetTool *tool = nil;
    static dispatch_once_t onceToken3;
    dispatch_once(&onceToken3, ^{
        tool = [[self alloc] init];
    });
    return tool;
    
}




- (void)POSWithURL:(NSString *)url parameters:(id)parameters success:(void (^)(id data))success failure:(void (^)(NSError *error))failure
{

    // 设置URL
    NSString *URL = [NSString stringWithFormat:@"%@%@",BasicURL,url];
    ZFLog(@"请求URL==============%@",URL);
    
    [[ZFNetTool sharedHTTPSession] POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (success) {
            
            success(responseObject);
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        
        
    }];
    
    
}

- (void)Download
{
    

}






@end
