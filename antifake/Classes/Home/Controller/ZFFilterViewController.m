//
//  ZFFilterViewController.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFFilterViewController.h"

@interface ZFFilterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *allButton;

@property (weak, nonatomic) IBOutlet UIButton *allButtonTwo;
@end

@implementation ZFFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allButton.selected = YES;
    self.allButtonTwo.selected = YES;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"筛选";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
