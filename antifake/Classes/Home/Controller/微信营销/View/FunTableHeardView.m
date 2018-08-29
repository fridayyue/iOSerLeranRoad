//
//  FunTableHeardView.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/17.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "FunTableHeardView.h"

@implementation FunTableHeardView
-(instancetype)initWithType:(NSInteger)type{
    self = [super init];
    if (self) {
        NSString *nibName = @"FunTableHeardView";
        if (type == 2) {
            nibName = @"FunTableHeardview2";
        }
        self = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] firstObject];
    }
    return self;
}
@end
