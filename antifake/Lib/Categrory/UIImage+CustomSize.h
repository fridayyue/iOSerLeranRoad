//
//  UIImage+CustomSize.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/19.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CustomSize)

/**
 image压缩至指定大小
 */
-(NSData *)compressQualityWithMaxLength:(NSInteger)maxLength;

/**
 裁剪大小
 */
-(UIImage*)scaleToSize:(CGSize)size;
@end
