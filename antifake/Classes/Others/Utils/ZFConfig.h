//
//  ZFConfig.h
//  happymoney
//
//  Created by Zach on 2017/11/16.
//  Copyright © 2017年 AW. All rights reserved.
//

#import <Foundation/Foundation.h>


//#import <AlipaySDK/AlipaySDK.h>

@interface ZFConfig : NSObject

+ (ZFConfig *)sharedManager;

//- (void)payOrder:(NSString *)orderString callback:(CompletionBlock)completionBlock;
- (void)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation;


- (void)application:(UIApplication*)app
            openURL:(NSURL*)url
            options:(NSDictionary<NSString *,id> *)options;

@end
