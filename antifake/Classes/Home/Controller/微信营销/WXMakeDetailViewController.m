//
//  WXMakeDetailViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/18.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "WXMakeDetailViewController.h"
#import "MakeDetailExplainViewController.h"
#import "SinglePickerAlertView.h"
#import "WXYingXiaoManger.h"
#import <Masonry.h>
#import "WXYingxiaoModelControl.h"
#import "DatePickerView.h"
#import "XTTimeDateManger.h"
#import "UIImage+CustomSize.h"
#import "ImagePreView.h"

typedef NS_ENUM(NSInteger,DetailType){
    jieshaoType,
    xinxiVido,
    xinxiPic
};

@interface WXMakeDetailViewController ()
<
    UITextViewDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>
@property (weak, nonatomic) IBOutlet UILabel *pinpaiTypeLabel;
@property (weak, nonatomic) IBOutlet UITextField *shareTitleTF;
@property (weak, nonatomic) IBOutlet UITextField *shareMiaoShuTF;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *buchongPicTitle;
@property (weak, nonatomic) IBOutlet UIButton *buchongImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (strong, nonatomic) IBOutlet UIView *jieshaoView;
@property (weak, nonatomic) IBOutlet UITextField *jieShao_biaotiTF;
@property (weak, nonatomic) IBOutlet UITextView *jieshao_miaoshuTV;
@property (weak, nonatomic) IBOutlet UILabel *jieshao_zishuLabel;
@property (weak, nonatomic) IBOutlet UITextField *jieshao_videoTF;
@property (weak, nonatomic) IBOutlet UITextField *jieshao_anniuWNTF;
@property (weak, nonatomic) IBOutlet UITextField *jieshao_anniuTZTF;

@property (strong, nonatomic) IBOutlet UIView *xinxiVideoView;
@property (weak, nonatomic) IBOutlet UITextField *xinxiVideo_nameTF;
@property (weak, nonatomic) IBOutlet UILabel *xinxiVideo_startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *xinxiVideo_endTimeLabel;
@property (weak, nonatomic) IBOutlet UITextField *xinxiVideo_videDdizhiTF;
@property (weak, nonatomic) IBOutlet UITextField *xinxiVideo_anniuWATf;

@property (strong, nonatomic) IBOutlet UIView *xinxiPicView;
@property (weak, nonatomic) IBOutlet UITextField *xinxiPic_nameTF;
@property (weak, nonatomic) IBOutlet UILabel *xinxiPic_startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *xinxiPic_endTimeLabel;
@property (weak, nonatomic) IBOutlet UITextField *xinxiPic_anniuWNTF;

@end

@implementation WXMakeDetailViewController{
    DetailType _detailType;
    //SUPPLYMENT:补充图片素材
    //SHARE:分享图片
    //VIDEO:视频封面素材
    NSString *_uploadType;
    NSString *_delegateType;
    CGSize _uploadSize;
    NSInteger _uploadQuantity;
    WXQueryFileListModel *_vidoImageModel;
    WXQueryFileListModel *_shareImageModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initView{
    self.title = @"制作详情页";
    [self makeRightNavBtnImage:[UIImage imageNamed:@"WX_Question.png"]];
    _jieshao_miaoshuTV.delegate = self;
    [_typeView addSubview:_jieshaoView];
    [_typeView addSubview:_xinxiVideoView];
    [_typeView addSubview:_xinxiPicView];
    [self updateTypeView];
    [self getData];
}
-(void)updateTypeView{
    CGFloat typeViewHeight = 330;
    _jieshaoView.hidden = YES;
    _xinxiVideoView.hidden = YES;
    _xinxiPicView.hidden = YES;
    if ([[WXYingXiaoManger shareManger].wxDetailType isEqualToString:@"品牌活动介绍页"]) {
        _detailType = jieshaoType;
        _pinpaiTypeLabel.text  = @"品牌活动介绍页";
        _buchongPicTitle.text = @"上传视频封面";
        typeViewHeight = 330;
        _jieshaoView.hidden = NO;
        [_typeView bringSubviewToFront:_jieshaoView];
    }else if ([[WXYingXiaoManger shareManger].wxDetailType isEqualToString:@"信息收集页-视频型"]){
        _detailType = xinxiVido;
        _pinpaiTypeLabel.text  = @"信息收集页-视频型";
        _buchongPicTitle.text = @"上传视频封面";
        typeViewHeight = 310;
        _xinxiVideoView.hidden = NO;
        [_typeView bringSubviewToFront:_xinxiVideoView];
        
    }else if ([[WXYingXiaoManger shareManger].wxDetailType isEqualToString:@"信息收集页-图片型"]){
        _detailType = xinxiPic;
        _pinpaiTypeLabel.text  = @"信息收集页-图片型";
        _buchongPicTitle.text = @"上传图片";
        typeViewHeight = 260;
        _xinxiPicView.hidden = NO;
        [_typeView bringSubviewToFront:_xinxiPicView];
        
    }else{
        _detailType = jieshaoType;
        _pinpaiTypeLabel.text  = @"品牌活动介绍页";
        _buchongPicTitle.text = @"上传视频封面";
        typeViewHeight = 330;
        _jieshaoView.hidden = NO;
        [_typeView bringSubviewToFront:_jieshaoView];
    }
    _typeViewHeight.constant = typeViewHeight;
}
-(void)updateImageSet{
    if (_vidoImageModel) {
        [self getImage:_vidoImageModel.id getimage:^(UIImage *image) {
            [_buchongImageBtn setImage:image forState:UIControlStateNormal];
            _buchongImageBtn.selected = YES;
        }];
    }else{
        [_buchongImageBtn setImage:[UIImage imageNamed:@"WX_UpLoadImage.png"] forState:UIControlStateNormal];
        _buchongImageBtn.selected = NO;
    }
    if (_shareImageModel) {
        [self getImage:_shareImageModel.id getimage:^(UIImage *image) {
            [_shareBtn setImage:image forState:UIControlStateNormal];
            _shareBtn.selected = YES;
        }];
        
    }else{
        [_shareBtn setImage:[UIImage imageNamed:@"WX_UpLoadImage.png"] forState:UIControlStateNormal];
        _shareBtn.selected = NO;
    }
}
#pragma mark - Net
-(void)getData{
    NSDictionary *paramtar = @{
                               @"pkey_value":[WXYingXiaoManger shareManger].pkey_value,
                               @"token":[UserManger shareManger].getUserID,
                               @"tableName":@"flb_wxfriends_advertisement"
                               };
    [WXYingxiaoModelControl getqueryFileList:paramtar success:^(NSArray *dataArray) {
        _vidoImageModel = nil;
        _shareImageModel = nil;
        for (NSDictionary *dic in dataArray) {
            if ([[dic objectForKey:@"attach_type"] isEqualToString:@"VIDEO"]) {
                _vidoImageModel = [[WXQueryFileListModel alloc] initWithDictionary:dic error:nil];
            }else if ([[dic objectForKey:@"attach_type"] isEqualToString:@"SHARE"]){
                _shareImageModel = [[WXQueryFileListModel alloc] initWithDictionary:dic error:nil];
            }
        }
        [self updateImageSet];
    } failure:^(NSError *error) {
        
    }];
}
-(void)upLoadImage:(NSDictionary *)paramtar{
    
    [WXYingxiaoModelControl uploadFile:paramtar progress:^(NSProgress *progress) {
        [SVProgressHUD showProgress:progress.fractionCompleted];
    } success:^(NSString *data) {
        [SVProgressHUD showSuccessWithStatus:@"上传完成"];
        [self getData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"上传失败"];
        [self getData];
    }];
}
-(void)getImage:(NSString *)imageID getimage:(void(^)(UIImage *image))getImange{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-msdownload"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *paramtar = @{
                               @"id":imageID,
                               @"token":[UserManger shareManger].getUserID
                               };
    [manager GET:@"http://flb.huarenpay.com/app/findFile" parameters:paramtar progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        UIImage *image = [[UIImage alloc] initWithData:responseObject];
        getImange(image);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)delegateImage{
    NSString *deleteID = @"";
    if ([_delegateType isEqualToString:@"VIDEO"]) {
        deleteID = _vidoImageModel.id;
    }else{
        deleteID = _shareImageModel.id;
    }
    NSDictionary *paramtar = @{
                               @"token":[UserManger shareManger].getUserID,
                               @"id":deleteID
                               };
    [WXYingxiaoModelControl deleteFile:paramtar success:^(NSString *data) {
        [SVProgressHUD showInfoWithStatus:@"删除成功！"];
        [self getData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - Action
-(void)actionForRightBtn:(id)sender{
    MakeDetailExplainViewController *makeDetilVC = [[MakeDetailExplainViewController alloc] init];
    [self.navigationController pushViewController:makeDetilVC animated:YES];
}
- (IBAction)actionForDetailDemo:(id)sender {
    SinglePickerAlertView *aimAlertView = [[SinglePickerAlertView alloc] initWithType:adDetailDemo defaultString:_pinpaiTypeLabel.text];
    aimAlertView.block = ^(NSString *data) {
        [WXYingXiaoManger shareManger].wxDetailType = data;
        [self updateTypeView];
    };
    [self.navigationController.view addSubview:aimAlertView];
    [aimAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForxinxiVideoBtn:(id)sender {
    DatePickerView *picker = [[DatePickerView alloc] init];
    picker.block = ^(NSDate *date) {
        _xinxiVideo_startTimeLabel.text = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:date];
    };
    [self.navigationController.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForXinxiVideoEndBtn:(id)sender {
    DatePickerView *picker = [[DatePickerView alloc] init];
    picker.block = ^(NSDate *date) {
        _xinxiVideo_endTimeLabel.text = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:date];
    };
    [self.navigationController.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForXinxiPicStartBtn:(id)sender {
    DatePickerView *picker = [[DatePickerView alloc] init];
    picker.block = ^(NSDate *date) {
        _xinxiPic_startTimeLabel.text = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:date];
    };
    [self.navigationController.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForXinxiPicEnd:(id)sender {
    DatePickerView *picker = [[DatePickerView alloc] init];
    picker.block = ^(NSDate *date) {
        _xinxiPic_endTimeLabel.text = [XTTimeDateManger fomatterTime:@"yyyy-MM-dd" date:date];
    };
    [self.navigationController.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.navigationController.view);
    }];
}
- (IBAction)actionForBuchongImagUpdload:(id)sender {
    if (_buchongImageBtn.selected) {
        ImagePreView *preview = [[ImagePreView alloc] init];
        preview.previewImage = _buchongImageBtn.imageView.image;
        [preview show];
        _delegateType = @"VIDEO";
        preview.deleBlcok = ^{
            [self delegateImage];
        };
    }else{
        _uploadType = @"VIDEO";
        _uploadSize = CGSizeMake(750, 422);
        _uploadQuantity = 300;
        [self selectImage];
    }
}
- (IBAction)actionForShareUpLoad:(id)sender {
    if (_shareBtn.selected) {
        ImagePreView *preview = [[ImagePreView alloc] init];
        preview.previewImage = _shareBtn.imageView.image;
        [preview show];
        _delegateType = @"SHARE";
        preview.deleBlcok = ^{
            [self delegateImage];
        };
    }else{
        _uploadType = @"SHARE";
        _uploadSize = CGSizeMake(120, 120);
        _uploadQuantity = 10;
        [self selectImage];
    }
}
#pragma mark - VC
-(void)selectImage{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}
#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *uploadImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    uploadImage = [uploadImage scaleToSize:_uploadSize];
    NSData *data = [uploadImage compressQualityWithMaxLength:_uploadQuantity*1024];
    if (data) {
        NSString *imgStr =[[NSString alloc] initWithData: [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength] encoding:NSUTF8StringEncoding];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpeg",[WXYingXiaoManger shareManger].pkey_value];
        NSDictionary *dic = @{
                              @"name_diaplay":fileName,
                              @"pkey_value":[WXYingXiaoManger shareManger].pkey_value,
                              @"tableName":@"flb_wxfriends_advertisement",
                              @"token":[[UserManger shareManger] getUserID],
                              @"attach_type":_uploadType,
                              @"suffix":@"jpeg",
                              @"comments":@"外层素材",
                              @"attach_size":@(data.length/1024.0),
                              @"file_content":imgStr
                              };
        [self upLoadImage:dic];
    }
}
#pragma mark - TextviewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入描述内容"]) {
        textView.text = @"";
        textView.textColor = HEX_COLOR(0x333333);
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入描述内容"]) {
        _jieshao_zishuLabel.text = @"0/40";
    }else{
        _jieshao_zishuLabel.text = [NSString stringWithFormat:@"%ld/40",textView.text.length];
    }
    if (textView.text.length > 40) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, 39)];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@""]){
        textView.text = @"请输入描述内容";
        textView.textColor = HEX_COLOR(0x999999);
    }
}
- (IBAction)actionforComplete:(id)sender {
    
}
-(BOOL)check{
    if ([Judge judgeStringIsEmpty:_jieShao_biaotiTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"主标题不能为空"];
        return NO;
    }
    if ([Judge judgeStringIsEmpty:_jieshao_miaoshuTV.text]&&![_jieshao_miaoshuTV.text isEqualToString:@"请输入描述内容"]) {
        [SVProgressHUD showErrorWithStatus:@"描述内容不能为空"];
        return NO;
    }
    if ([Judge judgeStringIsEmpty:_jieshao_videoTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"视频地址不能为空"];
        return NO;
    }
    if ([Judge judgeStringIsEmpty:_jieshao_anniuWNTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"按钮文案不能为空"];
        return NO;
    }
    if ([Judge judgeStringIsEmpty:_jieshao_anniuTZTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"按钮跳转地址不能为空"];
        return NO;
    }
    if ([Judge judgeStringIsEmpty:_shareTitleTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"分享标题不能为空"];
        return NO;
    }
    if ([Judge judgeStringIsEmpty:_shareMiaoShuTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"分享描述不能为空"];
        return NO;
    }
    
    [WXYingXiaoManger shareManger].wxBiaoTi = _jieShao_biaotiTF.text;
    [WXYingXiaoManger shareManger].wxMiaoShu = _jieshao_miaoshuTV.text;
    [WXYingXiaoManger shareManger].wxShipin = _jieshao_videoTF.text;
    [WXYingXiaoManger shareManger].wxAnniuWean = _jieshao_anniuWNTF.text;
    [WXYingXiaoManger shareManger].wxShareTitle = _shareTitleTF.text;
    [WXYingXiaoManger shareManger].wxShareMiaoshu = _shareMiaoShuTF.text;
    return YES;
}
@end
