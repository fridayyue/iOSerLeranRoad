//
//  ZFLoginModel.m
//  happymoney
//
//  Created by chengRui on 2017/10/24.
//  Copyright © 2017年 AW. All rights reserved.
//


#import "ZFLoginModel.h"
#import <MJExtension.h>

#import "NSString+ZFDir.h"



#define ZFAccountFileName @"FLBLoginData.data"



@implementation ZFLoginModel

MJCodingImplementation


/************ 储存数据 ************/
- (BOOL)saveData
{
    
    NSString *accountPath = [ZFAccountFileName appendDocumentDir];

    return [NSKeyedArchiver archiveRootObject:self toFile:accountPath];
 
}


/************ 删除数据 ************/
- (BOOL)delateData
{
    // 1.获取沙河路径
    NSString *accountPath = [ZFAccountFileName appendDocumentDir];
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    
    // 2.将归档删除
    return [fileManager removeItemAtPath:accountPath error:nil];
    
}


/************ 储存数据 ************/
+ (instancetype)unarchiveDataFromSandBox
{
    
    // 1.获取沙河路径
    NSString *accountPath = [ZFAccountFileName appendDocumentDir];
    
    // 2.取出存储的模型对象
    ZFLoginModel *loginData = [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
    
    return loginData;
    
}

@end
