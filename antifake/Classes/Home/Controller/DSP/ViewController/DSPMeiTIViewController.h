//
//  DSPMeiTIViewController.h
//  antifake
//
//  Created by 岳腾飞 on 2018/7/1.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "BasicViewController.h"
#import "MeiTiModel.h"

typedef void (^MeiTiBlock)(MeiTiModel *meitiModel);

@interface DSPMeiTIViewController : BasicViewController
@property(nonatomic,copy)MeiTiBlock meitiBlock;

@end
