//
//  DSPManger.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/3.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DSPManger.h"
#import "XTTimeDateManger.h"

static DSPManger *manger = nil;
static dispatch_once_t onceToken;

@implementation DSPManger
+(instancetype)shareManger{
    
    dispatch_once(&onceToken, ^{
        manger = [[DSPManger alloc] init];
        [manger initData];
    });
    return manger;
}
-(void)destroy{
    onceToken = 0;
    manger = nil;
}
-(void)initData{
    _pkey_value = [XTTimeDateManger currentTimeStr];
}
@end
