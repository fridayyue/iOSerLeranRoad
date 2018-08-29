//
//  AppDelegate.m
//  antifake
//
//  Created by Zach on 2018/1/18.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "AppDelegate.h"


#import <SVProgressHUD.h>

/***** 阿里SDK ****/
//#import <AlipaySDK/AlipaySDK.h>
#import "ZFConfig.h"
#import <IQKeyboardManager.h>
#import <AvoidCrash.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self carshEffective];
    [self makeRootVC];
    [self makeHUD];
    [self registerIQKeyboardManager];
    return YES;
}
-(void)carshEffective{
    [AvoidCrash becomeEffective];
    [AvoidCrash makeAllEffective];
}
-(void)makeRootVC{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    _leadingVC = [[LeadingViewController alloc] init];
    self.window.rootViewController = _leadingVC;
}
-(void)changeRootVC{
    if ([[UserManger shareManger] getLgoinStatus]) {
        _rootTabbar = [[ZFTabBarController alloc] init];
        self.window.rootViewController = _rootTabbar;
    }else{
        _loginVC = [[ZFLoginViewController alloc] init];
        _loginRootNav = [[ZFNavigationController alloc] initWithRootViewController:_loginVC];;
        self.window.rootViewController = _loginRootNav;
    }
}
-(void)makeHUD{
    //设置提示框效果
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
}
-(void)registerIQKeyboardManager{
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
-(void)changeToTableRootVC{
    if (![self.window.rootViewController isKindOfClass:[ZFTabBarController class]]) {
        
        _rootTabbar = [[ZFTabBarController alloc] init];
        self.window.rootViewController = _rootTabbar;
        _loginVC = nil;
        _loginRootNav = nil;
        
        NSString *version = [UIDevice currentDevice].systemVersion;
        if (version.doubleValue >= 8.0) { // iOS系统版本 >= 8.0
            CATransition *anim = [CATransition animation];
            anim.type = @"rippleEffect";
            anim.duration = 1;
            [self.window.layer addAnimation:anim forKey:nil];
        }
    }
}
-(void)changeToLoginVC{
    if (![self.window.rootViewController isKindOfClass:[ZFNavigationController class]]) {
        _loginVC = [[ZFLoginViewController alloc] init];
        _loginRootNav = [[ZFNavigationController alloc] initWithRootViewController:_loginVC];;
        self.window.rootViewController = _loginRootNav;
        _rootTabbar = nil;
        NSString *version = [UIDevice currentDevice].systemVersion;
        if (version.doubleValue >= 8.0) { // iOS系统版本 >= 8.0
            CATransition *anim = [CATransition animation];
            anim.type = @"rippleEffect";
            anim.duration = 1;
            [self.window.layer addAnimation:anim forKey:nil];
        }
    }
}
#pragma mark - 支付宝进行回调

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        
        [[ZFConfig sharedManager] application:application
                                      openURL:url
                            sourceApplication:sourceApplication
                                   annotation:annotation];
        
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[ZFConfig sharedManager] application:app
                                      openURL:url
                                      options:options];
        
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
