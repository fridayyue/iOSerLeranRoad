//
//  ZFConfig.m
//  happymoney
//
//  Created by Zach on 2017/11/16.
//  Copyright © 2017年 AW. All rights reserved.
//

#import "ZFConfig.h"


@interface ZFConfig ()
{

//    CompletionBlock _completionBlock;

}
@end

@implementation ZFConfig


static ZFConfig *_config = nil;

+ (ZFConfig *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config = [[ZFConfig alloc] init];
    });
    return _config;

}




//// 调用支付宝
//- (void)payOrder:(NSString *)orderString callback:(CompletionBlock)completionBlock
//{
//    _completionBlock = completionBlock;
//
//    NSString *appScheme = @"comFLB";
//    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//        completionBlock(resultDic);
//    }];
//
//}


- (void)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{

//    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//        if (_completionBlock) {
//            _completionBlock(resultDic);
//            _completionBlock = nil;
//        }
//    }];


}


- (void)application:(UIApplication*)app
            openURL:(NSURL*)url
            options:(NSDictionary<NSString *,id> *)options
{
//    [[AlipaySDK defaultService] processOrderWithPaymentResult:url
//                                              standbyCallback:^(NSDictionary *resultDic) {
//                                                  if (_completionBlock) {
//                                                      _completionBlock(resultDic);
//                                                      _completionBlock = nil;
//                                                  }
//                                              }];
}

@end

