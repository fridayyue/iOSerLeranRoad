//
//  ZFMeHeaderView.m
//  happymoney
//
//  Created by chengRui on 2017/10/10.
//  Copyright © 2017年 AW. All rights reserved.
//

#import "ZFMeHeaderView.h"

@interface ZFMeHeaderView ()


@end

@implementation ZFMeHeaderView


- (void)awakeFromNib
{
    
    [super awakeFromNib];
    

    
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];

}


+ (instancetype)headerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}



@end
