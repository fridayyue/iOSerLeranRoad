//
//  DXShenqingSignViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/24.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DXShenqingSignViewController.h"
#import "WXYingxiaoModelControl.h"
#import "UIImage+CustomSize.h"
#import "WXYingXiaoManger.h"
#import "ImagePreView.h"
#import "UIAlertView+Block.h"
#import "DXModelControl.h"

@interface DXShenqingSignViewController ()
<
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>
@property (weak, nonatomic) IBOutlet UITextField *qianmingTF;
@property (weak, nonatomic) IBOutlet UIImageView *updateImage;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;

@end

@implementation DXShenqingSignViewController{
    NSString *_data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)dealloc{
    CLog(@"%s",__FUNCTION__);
    [[WXYingXiaoManger shareManger] destroy];
}
-(void)initView{
    self.title = @"申请签名";
    [self makeRightNavBtnTitle:@"提交"];
}
#pragma mark - Net
-(void)upLoadImage:(NSDictionary *)paramtar{
    
    [WXYingxiaoModelControl uploadFile:paramtar progress:^(NSProgress *progress) {
        [SVProgressHUD showProgress:progress.fractionCompleted];
    } success:^(NSString *data) {
        [SVProgressHUD showSuccessWithStatus:@"上传完成"];
        _data = data;
        [self getImage:data];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"上传失败"];
    }];
}
-(void)getImage:(NSString *)imageID{
    _data = imageID;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-msdownload"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *paramtar = @{
                               @"id":imageID,
                               @"token":[UserManger shareManger].getUserID
                               };
    [manager GET:@"http://flb.huarenpay.com/app/findFile" parameters:paramtar progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CLog(@"");
        _updateImage.image = [[UIImage alloc] initWithData:responseObject];
        _uploadBtn.selected = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)delegateImage{
    NSDictionary *paramtar = @{
                               @"token":[UserManger shareManger].getUserID,
                               @"id":_data
                               };
    [WXYingxiaoModelControl deleteFile:paramtar success:^(NSString *data) {
        [SVProgressHUD showInfoWithStatus:@"删除成功！"];
        _updateImage.image = [UIImage imageNamed:@"WX_UpLoadImage.png"];
        _uploadBtn.selected = NO;
    } failure:^(NSError *error) {
        
    }];
}
-(void)submitSign{
//    pkey_value    20180624202841348055
    NSDictionary *paramtar = @{
                               @"token":[UserManger shareManger].getUserID,
                               @"sign":_qianmingTF.text,
                               @"pkey_value":[WXYingXiaoManger shareManger].pkey_value
                               };
    [SVProgressHUD show];
    [DXModelControl submitSign:paramtar success:^(NSString *str) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            [self.navigationController popViewControllerAnimated:YES];
        } title:@"注意" message:@"提交成功！" cancelButtonName:@"确定" otherButtonTitles:nil, nil];
    } failure:^(NSError *error, NSString *errorString) {
        [SVProgressHUD showErrorWithStatus:errorString];
    }];
}
#pragma mark - Net
-(void)actionForRightBtn:(id)sender{
    if ([Judge judgeStringIsEmpty:_qianmingTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"签名不能为空"];
        return;
    }
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self submitSign];
        }
    } title:@"注意" message:@"确定提交签名吗？" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
}
- (IBAction)actionForUpdateImage:(UIButton *)sender {
    if (_uploadBtn.selected) {
        ImagePreView *preview = [[ImagePreView alloc] init];
        preview.previewImage = _updateImage.image;
        [preview show];
        preview.deleBlcok = ^{
            [self delegateImage];
        };
    }else{
        [self selectImage];
    }
}
- (IBAction)actionForDown:(UIButton *)sender {
//    http://flb.huarenpay.com/app/loadSignBook
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://flb.huarenpay.com/app/loadSignBook"]];


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
    uploadImage = [uploadImage scaleToSize:CGSizeMake(800, 640)];
    NSData *data = [uploadImage compressQualityWithMaxLength:300*1024];
    if (data) {
        NSString *imgStr =[[NSString alloc] initWithData: [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength] encoding:NSUTF8StringEncoding];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpeg",[WXYingXiaoManger shareManger].pkey_value];
        NSDictionary *dic = @{
                              @"name_diaplay":fileName,
                              @"pkey_value":[WXYingXiaoManger shareManger].pkey_value,
                              @"tableName":@"flb_sign",
                              @"token":[[UserManger shareManger] getUserID],
                              @"attach_type":@"OUT_MATERIAL",
                              @"suffix":@"jpeg",
                              @"comments":@"申请签名",
                              @"attach_size":@(data.length/1024.0),
                              @"file_content":imgStr
                              };
        [self upLoadImage:dic];
    }
}
@end
