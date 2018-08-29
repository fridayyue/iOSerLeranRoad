//
//  ZFDataCenterListController.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFDataCenterListController.h"
#import "ZFMatchingController.h"
#import "ZFUnMatchedController.h"

@interface ZFDataCenterListController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

/**< 选项卡ScrollView */
@property (nonatomic, strong)UIScrollView *optionScrollView;

/**< 选择的选项卡 */
@property (nonatomic, strong) UIButton *selectTitleButton;

/**< 选项卡底部view */
@property (nonatomic, strong) UIView *titleBottomView;

/**< 选项卡数组 */
@property(nonatomic, copy)NSMutableArray *titleButtons;

@end

@implementation ZFDataCenterListController


#pragma mark - lazy
- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化Nav
    [self setupNav];
    
    // 2.添加所有子控制器
    [self addAllChildViewController];
    
    // 3.初始化背景ScrollView
    [self setupScrollView];
    
    // 4.初始化——选项卡
    [self setUpOptionButton];
    
}






#pragma mark - Private

/************ 1.初始化Nav ************/
- (void)setupNav
{
    // 0.设置间距
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 1.设置title
    self.navigationItem.title = @"猫碟";
    
    
    
}



/************ 2.初始化背景ScrollView ************/
- (void)setupScrollView
{
    
    // 1.设置背景色——由于做分割线
    self.view.backgroundColor = ZFGrayColor(240);
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    // ➕10间距来做分割线！！！！！！！！！！
    scrollView.frame = CGRectMake(0, 61 + 10, ZFScreenW, self.view.height);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * ZFScreenW, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
}




/************ 3.添加所有子控制器 ************/
- (void)addAllChildViewController
{
    // 1.添加子控制器
    // 未匹配
    ZFUnMatchedController *apprasingVC = [[ZFUnMatchedController alloc] init];
    apprasingVC.title = @"未匹配";
    [self addChildViewController:apprasingVC];
    
    
    // 已匹配
    ZFMatchingController *apprasedVC = [[ZFMatchingController alloc] init];
    apprasedVC.title = @"已匹配";
    [self addChildViewController:apprasedVC];
    

    
}



/************ 4.初始化——选项卡 ************/
- (void)setUpOptionButton
{
    /**** 1.创建选项卡 ****/
    // a.标签栏整体
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    titleView.frame = CGRectMake(0, 0, ZFScreenW, 60);
    [self.view addSubview:titleView];
    
    // b.内部按钮
    NSUInteger count = 2;
    CGFloat titleButtonH = titleView.height;
    CGFloat titleButtonW = titleView.width / count;
    
    for (int i = 0; i < count; i ++) {
        // 创建
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        
        NSString *title = self.childViewControllers[i].title;
        [titleButton setTitle:title forState:UIControlStateNormal];
        [titleButton setTitleColor:ZFColor(160, 192, 236) forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [titleButton setBackgroundColor:ZFColor(70, 142, 239)];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        // frame
        titleButton.y = 0;
        titleButton.height = titleButtonH;
        titleButton.width = titleButtonW;
        titleButton.x = i * titleButton.width;
        
        
    }
    
    
    
    // 指示控件
    UIView *titleBottomvView = [[UIView alloc] init];
    //    titleBottomvView.backgroundColor = [self.titleButtons.lastObject titleColorForState:UIControlStateSelected];
    titleBottomvView.height = 3;
    titleBottomvView.y = titleView.height - titleBottomvView.height;
    titleBottomvView.width = ZFScreenW/2 - 5;
    [titleView addSubview:titleBottomvView];
    self.titleBottomView = titleBottomvView;
    
    
    
    // 默认点击
    UIButton *firstButton = self.titleButtons.firstObject;
    [firstButton.titleLabel sizeToFit];
    
    titleBottomvView.centerX = firstButton.centerX;
    [self titleClick:firstButton];
    
    // 设置默认显示的VC
    
    
}





#pragma mrak - 监听
/************ 选项卡点击 ************/
- (void)titleClick:(UIButton *)titleButton
{
    // 控制按钮状态
    self.selectTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectTitleButton = titleButton;
    
    // 底部控件位置、尺寸、颜色
    [UIView animateWithDuration:0.25 animations:^{
        //        self.titleBottomView.width = titleButton.titleLabel.width;
        self.titleBottomView.width = ZFScreenW/2 - 5;
        self.titleBottomView.centerX = titleButton.centerX;
        self.titleBottomView.backgroundColor = [UIColor whiteColor];
        
    }];
    
    // 让scrollView滚动到对应位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = (self.view.width) * [self.titleButtons indexOfObject:titleButton];
    [self.scrollView setContentOffset:offset animated:YES];
}






#pragma mark - UIScrollViewDelegate

/************ ScrollView结束滑动 ************/
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        int index = self.scrollView.contentOffset.x / self.scrollView.width;
        UIViewController *willShowVc = self.childViewControllers[index];
        NSLog(@"index==========%d",index);
        
        // 如果控制器已经被创建过了，就直接返回——>不重复进行创建
        if (willShowVc.isViewLoaded) {
            return;
        }
        
        
        // 添加子控制器到above
        //        willShowVc.view.frame = CGRectMake(0, 0, KScreenW, KScreenH);
        willShowVc.view.frame = self.scrollView.bounds;
        [self.scrollView addSubview:willShowVc.view];
        
    }
    
    
}




#pragma mark - ClickAction
- (void)searchClickAction
{
    
    
}



- (void)messageClickAction
{
    
    
    
}




/************ ScrollView结束减速 ************/
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
    
    // 点击按钮
    int index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titleButtons[index]];
}


@end
