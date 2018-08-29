//
//  ImagePreView.h
//  antifake
//
//  Created by 岳腾飞 on 2018/6/20.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PreviewDeleBlock) (void);

@interface ImagePreView : UIView
@property (weak, nonatomic) IBOutlet UIView *showView;
@property(nonatomic,strong)UIImage* previewImage;
@property(nonatomic,copy)PreviewDeleBlock deleBlcok;

-(void)show;
@end
