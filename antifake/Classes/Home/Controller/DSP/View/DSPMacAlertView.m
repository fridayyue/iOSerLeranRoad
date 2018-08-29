//
//  DSPMacAlertView.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/27.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DSPMacAlertView.h"

@interface DSPMacAlertView()
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@end

@implementation DSPMacAlertView{
    NSInteger _startNumber;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        [self initView];
    }
    return self;
}
-(void)initView{
    _startNumber = 1000;
}
- (IBAction)actionForSure:(UIButton *)sender {
    if (_numberBlock) {
        _numberBlock(_numberLB.text);
    }
    [self actionrForCancle:sender];
}
- (IBAction)actionForJian:(UIButton *)sender {
    if ([_numberLB.text integerValue] <= 1000) {
        [SVProgressHUD showErrorWithStatus:@"已经是最小数额了！"];
    }else{
        _numberLB.text = [NSString stringWithFormat:@"%ld",[_numberLB.text integerValue] - 100];
        
    }
}
- (IBAction)actionForJia:(UIButton *)sender {
    _numberLB.text = [NSString stringWithFormat:@"%ld",[_numberLB.text integerValue] + 100];
}
- (IBAction)actionrForCancle:(id)sender {
    if (self.superview) {
        [self removeFromSuperview];
    }
}
@end
