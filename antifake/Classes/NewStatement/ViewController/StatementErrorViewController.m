//
//  StatementErrorViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/10.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "StatementErrorViewController.h"

@interface StatementErrorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *remarkLB;

@end

@implementation StatementErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initView{
    self.title = @"查看失败原因";
    self.remarkLB.text = _remark;
}
@end
