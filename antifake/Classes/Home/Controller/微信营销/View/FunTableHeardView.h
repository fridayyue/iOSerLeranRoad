//
//  FunTableHeardView.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/17.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunTableHeardView : UIView
-(instancetype)initWithType:(NSInteger)type;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *seationBtn;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;

@end
