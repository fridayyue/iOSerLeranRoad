//
//  ZFFunctionButton.m
//  antifake
//
//  Created by Zach on 2018/2/18.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFFunctionButton.h"

@implementation ZFFunctionButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
//        self.titleLabel.textColor = [UIColor redColor];
//        self.titleLabel.textColor = ZFColor(142, 151, 161);
        
//        self.backgroundColor = ZFGrayColor(245);
//        self.title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, ZFScreenW-20, 20)];
//        self.title.font = [UIFont systemFontOfSize:14];
//        self.title.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:self.title];
        
    }
    return self;
}



- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    CGFloat margin = 15;
    
    CGFloat imageW = 35;
    CGFloat imageH = 35;
    CGFloat imageX = (self.width - imageW)/2;
    CGFloat imageY = margin;
    
    
    CGFloat titleX = 0;
    CGFloat titleY = imageY +imageH + 13;
    CGFloat titleW = self.width;
    CGFloat titleH = 20;
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    
//    CGFloat margin = 10;
//
//    // 调整图片的位置和尺寸
//    self.imageView.y = margin;
//    self.imageView.centerX = self.width * 0.5;
//
//    // 调整文字的位置和尺寸
//    self.titleLabel.x = 0;
//    self.titleLabel.y = self.imageView.height + margin;
//    self.titleLabel.width = self.width;
//    self.titleLabel.height = self.height - self.titleLabel.y;
//
//
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    //    ZFLog(@"=====%f=====%f=======%f======%f",self.titleLabel.centerX,self.titleLabel.y,self.titleLabel.width,self.titleLabel.height);
    
}

@end
