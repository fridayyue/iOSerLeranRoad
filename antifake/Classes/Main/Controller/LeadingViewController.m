//
//  LeadingViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/10.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "LeadingViewController.h"
#import <AVKit/AVKit.h>
#import "AppDelegate.h"

@interface LeadingViewController ()
@property(nonatomic,strong)UIButton* skipBtn;
@property(nonatomic,strong)AVPlayer *player;

@end

@implementation LeadingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initView{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LeadingStart" ofType:@"mp4"];
    _player = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:path]];
    AVPlayerItem * playerIteam = _player.currentItem;
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    playerLayer.frame = CGRectMake(0, 0, ZFScreenW, ZFScreenH);
    [self.view.layer addSublayer:playerLayer];
    [_player play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerIteam];
    
    _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = 110;
    CGFloat height = 45;
    _skipBtn.frame = CGRectMake(ZFScreenW - width -10, 10, width, height);
    [_skipBtn setTitle:@"点击跳过" forState:UIControlStateNormal];
    [_skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _skipBtn.backgroundColor = [UIColor clearColor];
    _skipBtn.layer.cornerRadius = height/2.0;
    _skipBtn.layer.borderWidth = 1;
    _skipBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [_skipBtn addTarget:self action:@selector(playbackFinished:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_skipBtn];
}
- (void)playbackFinished:(NSNotification *)notice {
    CLog(@"播放完成");
    [_player pause];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    AppDelegate *delegate = ShareAppDelegate;
    [delegate changeRootVC];
}
@end
