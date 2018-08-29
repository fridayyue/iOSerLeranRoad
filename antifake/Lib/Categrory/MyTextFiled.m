//
//  MyTextFiled.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "MyTextFiled.h"

@implementation MyTextFiled
-(void)deleteBackward{
    BOOL shouldDismiss = [self.text length] == 0;
    [super deleteBackward];
    if (shouldDismiss) {
        if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            [self.delegate textField:self shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@""];
        }
    }
}
@end
