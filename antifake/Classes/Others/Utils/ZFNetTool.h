//
//  ZFNetTool.h
//  iParent
//
//  Created by chengRui on 2017/5/22.
//  Copyright © 2017年 chengRui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>

@interface ZFNetTool : NSObject

+ (instancetype)shareNetTool;



- (void)POSWithURL:(NSString *)url parameters:(id)parameters success:(void (^)(id data))success failure:(void (^)(NSError *error))failure;

//- (void)POSWithURL:(nullable NSString *)url parameters:(nullable id)parameters success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

@end
