//
//  FindAVAlertView.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/1.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "FindAVAlertView.h"
#import "MeitiTableViewCell.h"

static void *tableSize = &tableSize;

@interface FindAVAlertView ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FindAVAlertView{
    NSArray *_listArray;
    UIView *_whiteView;
    UIButton *_bgBtn;
}
-(void)dealloc{
    @try{
        [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize))];
    }
    
    @catch(NSException *exception) {
        
    }
}
-(instancetype)initWithFrame:(CGRect)frame listArray:(NSArray *)listArray{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        _listArray = listArray.copy;
        self.frame = frame;
        [self initView];
    }
    return self;
}
-(void)initView{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.cornerRadius = 5;
    [_tableView registerNib:[UINib nibWithNibName:@"MeitiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MeitiTableViewCell"];
    [_tableView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) options:NSKeyValueObservingOptionNew context:tableSize];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (context == tableSize) {
        CGSize tableViewSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
        _tableViewHeight.constant = tableViewSize.height;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeitiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeitiTableViewCell"];
    FindAVModel *model  = [[FindAVModel alloc] initWithDictionary:_listArray[indexPath.row] error:nil];
    cell.media_nameLB.text  = model.adv_name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_findBlock) {
        FindAVModel *model  = [[FindAVModel alloc] initWithDictionary:_listArray[indexPath.row] error:nil];
        _findBlock(model);
        [self actionForClose:nil];
    }
}
-(IBAction)actionForClose:(id)sender{
    if (self.superview) {
        [self removeFromSuperview];
    }
}
@end
