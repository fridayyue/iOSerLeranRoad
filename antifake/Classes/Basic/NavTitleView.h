//
//  NavTitleView.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/16.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavTitleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIImageView *titleIM;
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property(nonatomic, assign) CGSize intrinsicContentSize;
@end
