//
//  UIImage+CustomSize.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/19.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "UIImage+CustomSize.h"

@implementation UIImage (CustomSize)
-(NSData *)compressQualityWithMaxLength:(NSInteger)maxLength{
    UIImage *imag = self;
//    if (CGSizeEqualToSize(self.size,CGSizeMake(800, 640)) ||
//        CGSizeEqualToSize(self.size,CGSizeMake(640, 800)) ||
//        CGSizeEqualToSize(self.size,CGSizeMake(800, 800))) {
//        imag = [self scaleToSize:CGSizeMake(800, 640)];
//    }

    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(imag, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(imag, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
}
-(UIImage*)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}
@end
