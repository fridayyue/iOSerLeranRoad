//
//  MyTimerManger.h
//  bank94
//
//  Created by Liu Hui on 2018/3/21.
//  Copyright © 2018年 com.hongzhe.tldy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyTimerMangerDelegate <NSObject>
-(void)timerWorkingWithTimeCount:(NSInteger)timeCount;
-(void)timerComplete;
@end

@interface MyTimerManger : NSObject
@property (assign, nonatomic) NSInteger  countTime;
@property (strong, nonatomic) NSTimer*  countDownTimer;
@property (weak, nonatomic) id  <MyTimerMangerDelegate>myTimerDelegate;
@property (strong, nonatomic) NSString*  lastResource;
@property(nonatomic,assign)CGFloat peace;


/**
 单利创建对象
 
 @return 创建网络请求管理器
 */
+(instancetype)Sharemanger;

/**
 开始计时器，来源同一个就会接着上一个的计时器开始，不同的来源会重置计时器

 @param timeCont 倒计时总时间
 @param resource 来源
 */
-(void)startTimerWorkingWithTimeCount:(NSInteger)timeCont resource:(NSString *)resource;
-(void)stopTimer;
@end
