//
//  NSString+ZFDir.m
//  happymoney
//
//  Created by Zach on 2017/11/7.
//  Copyright © 2017年 AW. All rights reserved.
//

#import "NSString+ZFDir.h"

@implementation NSString (ZFDir)


/**
 *  追加文档目录
 */
- (NSString *)appendDocumentDir
{
    return [self appendDir:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
}

/**
 *  追加缓存目录
 */
- (NSString *)appendCacheDir
{
    return [self appendDir:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]];
}

/**
 *  追加临时目录
 */
- (NSString *)appendTempDir
{
    return [self appendDir:NSTemporaryDirectory()];
}

/**
 *  将当前字符串拼接到指定目录后面
 *
 *  @param dir 指定目录
 *
 *  @return 拼接好的路径
 */
- (NSString *)appendDir:(NSString *)dir // docpath
{
    return [dir stringByAppendingPathComponent:self];
}

//- (NSString *)appendNewUserGuideKey {
//    return [self stringByAppendingString:yuba_kNewUserGuideStep];
//}
/**
 *  计算字符串尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



@end
