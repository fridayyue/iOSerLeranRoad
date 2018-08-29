//
//  ZFChoosShopController.h
//  antifake
//
//  Created by Zach on 2018/5/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFShopListModel.h"

@protocol  ZFChooseShopControllerDelegate<NSObject>
@optional

- (void)finishSelectShopWithShopModel:(ZFShopListModel *)model;


@end

@interface ZFChoosShopController : UIViewController

@property (nonatomic, weak) id<ZFChooseShopControllerDelegate> chooseshopDelegate;



@end
