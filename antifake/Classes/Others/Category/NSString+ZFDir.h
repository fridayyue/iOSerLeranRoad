//
//  NSString+ZFDir.h
//  happymoney
//
//  Created by Zach on 2017/11/7.
//  Copyright © 2017年 AW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZFDir)


/**
 *  追加文档目录
 */
- (NSString *)appendDocumentDir;

/**
 *  追加缓存目录
 */
- (NSString *)appendCacheDir;

/**
 *  追加临时目录
 */
- (NSString *)appendTempDir;

/**
 *  给账号追加新用户引导完成步骤 key 值
 */
- (NSString *)appendNewUserGuideKey;
/**
 *  计算字符串尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;




@end
