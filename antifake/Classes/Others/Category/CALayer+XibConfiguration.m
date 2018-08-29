//
//  CALayer+XibConfiguration.m
//  94Bank
//
//  Created by 统领 on 16/6/15.
//  Copyright © 2016年 统领. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color

{
    
    self.borderColor = color.CGColor;
    
}

-(UIColor*)borderUIColor

{
    
    return [UIColor colorWithCGColor:self.borderColor];
    
}

@end
