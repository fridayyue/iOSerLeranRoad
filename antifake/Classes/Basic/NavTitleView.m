//
//  NavTitleView.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/16.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "NavTitleView.h"

@implementation NavTitleView
-(instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        [self initView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        self.frame = frame;
        [self initView];
    }
    return self;
}
-(void)initView{
    
}
@end
