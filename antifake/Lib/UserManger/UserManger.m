//
//  UserManger.m
//  antifake
//
//  Created by 岳腾飞 on 2018/5/28.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "UserManger.h"
#import "UserInfoMacros.h"
#import "AppDelegate.h"

static UserManger *manger;

@implementation UserManger
+(instancetype)shareManger{
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        if (manger == nil) {
            manger = [[UserManger alloc] init];
        }
    });
    return manger;
}
#pragma mark - SETGET
-(void)setLoginStatus:(BOOL)status{
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:User_LoginStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)getLgoinStatus{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:User_LoginStatus] boolValue];
}
-(void)setUserPhone:(NSString *)phone{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:User_phone];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)getUserPhone{
    return [[NSUserDefaults standardUserDefaults] objectForKey:User_phone];
}
-(void)setUserID:(NSString *)UserID{
    [[NSUserDefaults standardUserDefaults] setObject:UserID forKey:User_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)getUserID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:User_ID];
}
-(void)setMorenPhone:(NSString *)morenPhone{
    [[NSUserDefaults standardUserDefaults] setObject:morenPhone forKey:User_morenPhone];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)morenPhone{
    return [[NSUserDefaults standardUserDefaults] objectForKey:User_morenPhone];
}
-(void)setPassword:(NSString *)password{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:User_Password];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)password{
    return [[NSUserDefaults standardUserDefaults] objectForKey:User_Password];
}
-(void)setAmount:(NSString *)amount{
    [[NSUserDefaults standardUserDefaults] setObject:amount forKey:User_Transaction_amount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)amount{
     return [[NSUserDefaults standardUserDefaults] objectForKey:User_Transaction_amount];
}
#pragma mark - Method
-(void)userLogin:(LoginModel *)loginModel{
    [self setLoginStatus:YES];
    [self setUserPhone:loginModel.user_code];
    [self setUserID:loginModel.id];
    [self setAmount:loginModel.transaction_amount];
    self.password = loginModel.password;
}
-(void)userLogout{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:User_LoginStatus];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:User_ID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:User_morenPhone];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:User_Transaction_amount];
    
    AppDelegate *delegate = ShareAppDelegate;
    [delegate changeToLoginVC];
}
@end
