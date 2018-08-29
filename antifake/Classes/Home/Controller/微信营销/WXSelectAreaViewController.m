//
//  WXSelectAreaViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/17.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "WXSelectAreaViewController.h"
#import "WXSelectCollectionViewCell.h"
#import "AddressPickView.h"
#import "WXYingXiaoManger.h"
#import "WXFunSelectViewController.h"
#import "WXFunModel.h"

@interface WXSelectAreaViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource
>
@property (weak, nonatomic) IBOutlet UILabel *iteamTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layOut;

@end

@implementation WXSelectAreaViewController{
    NSMutableArray *_daArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)initView{
    switch (_selectType) {
        case wxAereaSelectType:
        {
            self.title = @"选择区域";
            [self.addBtn setTitle:@"添加区域" forState:UIControlStateNormal];
            _daArray = [NSMutableArray arrayWithArray:[WXYingXiaoManger shareManger].wxAreaArray];
        }
            break;
        case wxFunSelectType:
        {
            self.title = @"选择兴趣";
            _iteamTitleLabel.text = @"已选择兴趣";
            [self.addBtn setTitle:@"添加兴趣" forState:UIControlStateNormal];
            _typeBtn.hidden = YES;
            _daArray = [NSMutableArray arrayWithArray:[WXYingXiaoManger shareManger].wxFunArray];
        }
            break;
            
        default:
            break;
    }
    _layOut.minimumInteritemSpacing = 10;
    _layOut.minimumLineSpacing = 10;
    _layOut.estimatedItemSize = CGSizeMake(190, 40);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"WXSelectCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"WXSelectCollectionViewCell"];
    [self makeRightNavBtnTitle:@"确定"];
}
-(void)makeAdressView{

    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.navigationController.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        NSString *adressString = [NSString stringWithFormat:@"%@-%@-%@",province,city,town];
        if (![self->_daArray containsObject:adressString]) {
            [self->_daArray addObject:adressString];
            [self->_collectionView reloadData];
        }
    };
}
-(void)gotoFunSelectVC{
    WXFunSelectViewController *funSelectVC = [[WXFunSelectViewController alloc] init];
    funSelectVC.compleBlock = ^{
         self->_daArray = [NSMutableArray arrayWithArray:[WXYingXiaoManger shareManger].wxFunArray];
        [self->_collectionView reloadData];
    };
    [self.navigationController pushViewController:funSelectVC animated:YES];
}
#pragma makr - Action
- (IBAction)actionForAdd:(UIButton *)sender {
    switch (_selectType) {
        case wxAereaSelectType:
                [self makeAdressView];
            break;
        case wxFunSelectType:
                [self gotoFunSelectVC];
            break;
            
        default:
            break;
    }
}
-(void)actionForRightBtn:(id)sender{
    switch (_selectType) {
        case wxAereaSelectType:
        {
            [WXYingXiaoManger shareManger].wxAreaArray = _daArray;
        }
            break;
        case wxFunSelectType:
        {
            [WXYingXiaoManger shareManger].wxFunArray = _daArray;
        }
            break;
            
        default:
            break;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _daArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 15, 5, 15);//（上、左、下、右）
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"WXSelectCollectionViewCell";
    WXSelectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.borderWidth = 0.5f;
    cell.layer.cornerRadius = 5;
    cell.layer.borderColor = HEX_COLOR(0x666666).CGColor;
    
    if (_selectType == wxFunSelectType) {
        WXFunModel *pModel = _daArray[indexPath.row];
        cell.myTitleLabel.text = pModel.hobbyName;
    }else{
        cell.myTitleLabel.text = _daArray[indexPath.row];
    }
    
    return cell;
}
@end
