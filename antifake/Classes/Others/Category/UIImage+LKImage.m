//
//  UIImage+LKImage.m
//  Wallet
//
//  Created by MR.DL on 2017/9/21.
//  Copyright © 2017年 LK. All rights reserved.
//

#import "UIImage+LKImage.h"

@implementation UIImage (LKImage)

- (UIImage *)scaleToWidth:(CGFloat)width{
    //如果横屏拍摄的情况
    if (self.size.width > self.size.height) {
        width = width * 2;
    }
    
    if (width > self.size.width) {
        return  self;
    }
    
    CGFloat height = (width / self.size.width) * self.size.height;
    
    CGRect  rect = CGRectMake(0, 0, width, height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self drawInRect:rect];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
