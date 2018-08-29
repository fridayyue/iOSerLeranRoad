//
//  DataCenterViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/11.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DataCenterViewController.h"
#import "JingZhunKeHuViewController.h"


typedef NS_ENUM(NSInteger,ViewType) {
    jingzhunkehu = 100,
    shishikehu,
    bendianhuiyuan
};

@interface DataCenterViewController ()

@end

@implementation DataCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - MakeView
-(void)initView{
    self.title = @"数据中心";
    [self makeRightNavBtnTitle:@"设备"];
}
#pragma mark - Action
- (IBAction)actionForView:(UIButton *)sender {
    switch (sender.tag) {
        case jingzhunkehu:
        {
            JingZhunKeHuViewController *jingzhunVC = [[JingZhunKeHuViewController alloc] init];
            [self.navigationController pushViewController:jingzhunVC animated:YES];
        }
            break;
        case shishikehu:
        {
            
        }
            break;
        case bendianhuiyuan:
        {
            
        }
            break;
            
        default:
            break;
    }
}
-(void)actionForRightBtn:(id)sender{
    
}
@end
