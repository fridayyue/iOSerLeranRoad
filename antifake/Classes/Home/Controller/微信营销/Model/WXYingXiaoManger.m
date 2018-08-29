//
//  WXYingXiaoManger.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/14.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "WXYingXiaoManger.h"
#import "XTTimeDateManger.h"

static WXYingXiaoManger *manger;
static dispatch_once_t onceToken;

@implementation WXYingXiaoManger
+(instancetype)shareManger{
    
    dispatch_once(&onceToken, ^{
        manger = [[WXYingXiaoManger alloc] init];
        [manger initData];
    });
    return manger;
}
-(void)initData{
    _wxFunArray = @[].mutableCopy;
    _wxOut = NO;
    _pkey_value = [XTTimeDateManger currentTimeStr];
}
-(void)destroy{
    onceToken = 0;
    manger = nil;
}
@end
