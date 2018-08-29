//
//  FindAVAlertView.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/1.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindAVModel.h"

typedef void (^FindBlock)(FindAVModel *model);
@interface FindAVAlertView : UIView
@property(nonatomic,copy)FindBlock findBlock;

-(instancetype)initWithFrame:(CGRect)frame listArray:(NSArray *)listArray;
@end
