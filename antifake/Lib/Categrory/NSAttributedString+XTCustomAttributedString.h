//
//  NSAttributedString+XTCustomAttributedString.h
//  StarCredit
//
//  Created by 岳腾飞 on 2018/6/21.
//  Copyright © 2018年 VCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (XTCustomAttributedString)
/**
 对富文本字符串进行改变颜色和大小，字符串中出现几次就会更改几次
 
 @param changeString 需要更改的字符串的全部
 @param pointString 需要更改的字符
 @param changeColor 更改字符的更改颜色
 @param changeSize 更改字符的更改大小
 @return 更改后的富文本字符
 */
+(NSMutableAttributedString *)changeAttributedStringStr:(NSString *)changeString pointString:(NSString *)pointString changeColor:(UIColor *)changeColor changeSize:(CGFloat)changeSize;

/**
 对富文本字符串进行改变颜色和大小，字符串中出现几次就会更改几次
 
 @param changeAttString 需要更改的富文本的全部
 @param pointString 需要更改的字符
 @param changeColor 更改字符的更改颜色
 @param changeSize 更改字符的更改大小
 @return 更改后的富文本字符
 */
+(NSMutableAttributedString *)changeAttributedStringAttStr:(NSAttributedString *)changeAttString pointString:(NSString *)pointString changeColor:(UIColor *)changeColor changeSize:(CGFloat)changeSize;
@end