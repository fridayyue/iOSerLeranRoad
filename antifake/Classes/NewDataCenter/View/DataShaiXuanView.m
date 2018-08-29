//
//  DataShaiXuanView.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/17.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DataShaiXuanView.h"

@implementation DataShaiXuanView
-(instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        [self initView];
    }
    return self;
}
-(void)initView{
    
}
@end
