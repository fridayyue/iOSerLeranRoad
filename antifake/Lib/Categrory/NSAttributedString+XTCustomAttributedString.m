//
//  NSAttributedString+XTCustomAttributedString.m
//  StarCredit
//
//  Created by 岳腾飞 on 2018/6/21.
//  Copyright © 2018年 VCredit. All rights reserved.
//

#import "NSAttributedString+XTCustomAttributedString.h"

@implementation NSAttributedString (XTCustomAttributedString)
+(NSMutableAttributedString *)changeAttributedStringStr:(NSString *)changeString pointString:(NSString *)pointString changeColor:(UIColor *)changeColor changeSize:(CGFloat)changeSize{
    if ([Judge judgeStringIsEmpty:changeString]) {
        return nil;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:changeString];
    while ([changeString rangeOfString:pointString].location != NSNotFound)
        
    {
        NSRange  range  = [changeString rangeOfString:pointString];
        [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:changeSize] range:range];
        if (changeColor) {
            [attributedText addAttribute:NSForegroundColorAttributeName value:changeColor range:range];
        }
        changeString = [changeString stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:@"X"];
        
    }
    return attributedText;
}
+(NSMutableAttributedString *)changeAttributedStringAttStr:(NSAttributedString *)changeAttString pointString:(NSString *)pointString changeColor:(UIColor *)changeColor changeSize:(CGFloat)changeSize{
    if (changeAttString.length<=0) {
        return nil;
    }
    NSMutableAttributedString *attributedText = changeAttString.mutableCopy;
    NSString *changeString = changeAttString.string;
    while ([changeString rangeOfString:pointString].location != NSNotFound)
        
    {
        NSRange  range  = [changeString rangeOfString:pointString];
        [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:changeSize] range:range];
        if (changeColor) {
            [attributedText addAttribute:NSForegroundColorAttributeName value:changeColor range:range];
        }
        changeString = [changeString stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:@"X"];
        
    }
    return attributedText;
    
}
@end
