//
//  ImagePreView.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/20.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ImagePreView.h"
#import "AppDelegate.h"
#import "UIImage+CustomSize.h"
#import "UIAlertView+Block.h"

@implementation ImagePreView
-(instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    }
    return self;
}
-(void)show{
    self.frame = CGRectMake(0, 0,ZFScreenW, ZFScreenH);
    AppDelegate *delegate = ShareAppDelegate;
    [delegate.window addSubview:self];
    if (self.previewImage.size.width > ZFScreenW) {
        _previewImage = [_previewImage scaleToSize:CGSizeMake(ZFScreenW, ZFScreenW * _previewImage.size.height / _previewImage.size.width)];
    }
    if (self.previewImage.size.height > (ZFScreenH - 60)){
        _previewImage = [_previewImage scaleToSize:CGSizeMake((ZFScreenH - 60)*_previewImage.size.width/_previewImage.size.height, (ZFScreenH - 60))];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:_previewImage];
    imageView.frame = CGRectMake(0, 0, ZFScreenW, ZFScreenH - 60);
    imageView.center = _showView.center;
    [_showView addSubview:imageView];
}
- (IBAction)actionForBack:(UIButton *)sender {
    if (self.superview) {
        [self removeFromSuperview];
    }
}
- (IBAction)actionForDelegate:(id)sender {
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1 && _deleBlcok) {
            _deleBlcok();
            [self actionForBack:nil];
        }
    } title:@"" message:@"确认删除该图片吗" cancelButtonName:@"取消" otherButtonTitles:@"确认", nil];
}
@end
