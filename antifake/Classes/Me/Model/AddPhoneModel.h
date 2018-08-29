//
//  AddPhoneModel.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicJsonModel.h"
//{
//    binddate = 1527574261000,
//    id = 23,
//    bindstate = 1,
//    unbinddate = <null>,
//    user_id = "5a1fd0a3-894e-4628-aebd-e3fe142701f2",
//    bindcount = 1,
//    xnum = "17077895683",
//    anum = "17679088329",
//    }
@interface AddPhoneModel : BasicJsonModel
@property(nonatomic,copy)NSString* binddate;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger bindstate;
@property(nonatomic,copy)NSString* unbinddate;
@property(nonatomic,copy)NSString* user_id;
@property(nonatomic,assign)NSInteger bindcount;
@property(nonatomic,copy)NSString* xnum;
@property(nonatomic,copy)NSString* anum;
@end
