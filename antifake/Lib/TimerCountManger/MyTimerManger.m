//
//  MyTimerManger.m
//  bank94
//
//  Created by Liu Hui on 2018/3/21.
//  Copyright © 2018年 com.hongzhe.tldy. All rights reserved.
//

#import "MyTimerManger.h"

static MyTimerManger *timerManger;

@implementation MyTimerManger

+(instancetype)Sharemanger{
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        if (timerManger == nil) {
            timerManger = [[self alloc] init];
            [timerManger initTimer];
        }
    });
    return timerManger;
}
-(void)initTimer{
    //初始化一个Invocation对象
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(timerWorking) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_countDownTimer forMode:NSRunLoopCommonModes];
    [self stopTimer];
    _countTime = 0;
    CLog(@"MyTimerManger Timer Creat");
}
-(void)startTimerWorkingWithTimeCount:(NSInteger)timeCont resource:(NSString *)resource{
    /*
                            -->0 继续
            --同源 --倒计时
                            --<=0 重开
     -- 来源
            --非 重开
     */
    if ([_lastResource isEqualToString:resource] && _countTime > 0 ) {
        CLog(@"MyTimerManger Timer GOON Least Time: %ld",(long)_countTime);
    }else{
        CLog(@"MyTimerManger Timer Restart");
        _countTime = timeCont;
        _countDownTimer.fireDate = [NSDate distantPast];
    }
    _lastResource = resource;
    CLog(@"MyTimerManger Timer Resource:%@",resource);
}
-(void)timerWorking{
//    CLog(@"MyTimerManger Timer Working Time:%ld",(long)_countTime);
    if (_countTime <= 0) {
        [self stopTimer];
        if (_myTimerDelegate && [_myTimerDelegate respondsToSelector:@selector(timerComplete)]) {
            [_myTimerDelegate timerComplete];
        }
        
    }else{
        if (_myTimerDelegate && [_myTimerDelegate respondsToSelector:@selector(timerComplete)]) {
            [_myTimerDelegate timerWorkingWithTimeCount:_countTime];
        }
    }
    _countTime --;
}
-(void)stopTimer{
    CLog(@"MyTimerManger Timer Stop");
    _countDownTimer.fireDate = [NSDate distantFuture];
}
@end
