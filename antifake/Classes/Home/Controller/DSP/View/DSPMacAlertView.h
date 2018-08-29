//
//  DSPMacAlertView.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/27.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MacBlock)(NSString *number);

@interface DSPMacAlertView : UIView
@property(nonatomic,copy)MacBlock numberBlock;

@end
