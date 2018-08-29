//
//  HomeNewView.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/29.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "HomeNewView.h"

#define cicleR (ZFScreenW/2.0 - 40)
#define cicleCenter CGPointMake(ZFScreenW*0.5, (ZFScreenH - 50 - 64)*0.5)

@interface HomeNewView()
@property (weak, nonatomic) IBOutlet UIButton *home_dianhuaBtn;
@property (weak, nonatomic) IBOutlet UIButton *home_duanxinBtn;
@property (weak, nonatomic) IBOutlet UIButton *home_DSPBtn;
@property (weak, nonatomic) IBOutlet UIButton *home_SXBtn;
@property (weak, nonatomic) IBOutlet UIButton *homeDXBtn;
@end
@implementation HomeNewView{
    NSArray *_btnArray;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}
-(void)initView{
    _btnArray  = @[_home_dianhuaBtn,_home_duanxinBtn,_home_DSPBtn,_home_SXBtn,_homeDXBtn].copy;
    for (NSInteger index = 0; index <  _btnArray.count; index ++) {
        UIButton *btn = _btnArray[index];
        btn.frame = CGRectMake(0, 0, 67, 67);
        btn.center = [self calcultAngle:index*72];
        [self addSubview:btn];
    }
}

-(CGPoint)calcultAngle:(NSInteger)angle{
    CGPoint point;
    CGFloat x = cicleCenter.x + cicleR * cos(angle * M_PI/180.0);
    CGFloat y = cicleCenter.y+ cicleR * sin(angle * M_PI/180.0);
    point = CGPointMake(x, y);
    return point;
}
@end
