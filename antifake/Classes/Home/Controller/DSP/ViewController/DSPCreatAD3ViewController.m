//
//  DSPCreatAD3ViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/7/3.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "DSPCreatAD3ViewController.h"
#import "ImagePreView.h"
#import "WXYingxiaoModelControl.h"
#import "UIImage+CustomSize.h"
#import "DSPManger.h"

@interface DSPCreatAD3ViewController ()
<
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>
@property (weak, nonatomic) IBOutlet UITextField *wenzi1TF;
@property (weak, nonatomic) IBOutlet UITextField *wenzi2TF;
@property (weak, nonatomic) IBOutlet UITextField *wenzi3TF;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *uploadImage;

@end

@implementation DSPCreatAD3ViewController{
    WXQueryFileListModel *_queryFileListModel;
    NSString *_data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}
-(void)initView{
    self.title = @"创建广告";
}
#pragma mark - Net
-(void)getData{
//    tableName    flb_dsp
    NSDictionary *paramtar = @{
                               @"pkey_value":[DSPManger shareManger].pkey_value,
                               @"token":[UserManger shareManger].getUserID,
                               @"tableName":@"flb_dsp"
                               };
    [WXYingxiaoModelControl getqueryFileList:paramtar success:^(NSArray *dataArray) {
        for (NSDictionary *dic in dataArray) {
            if ([[dic objectForKey:@"attach_type"] isEqualToString:@"MAIN"]) {
                _queryFileListModel = [[WXQueryFileListModel alloc] initWithDictionary:[dataArray firstObject] error:nil];
                if (_queryFileListModel) {
                    [self getImage:_queryFileListModel.id];
                }
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)upLoadImage:(NSDictionary *)paramtar{
    
    [WXYingxiaoModelControl uploadFile:paramtar progress:^(NSProgress *progress) {
        [SVProgressHUD showProgress:progress.fractionCompleted];
    } success:^(NSString *data) {
        [SVProgressHUD showSuccessWithStatus:@"上传完成"];
        self->_data = data;
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
        _uploadImage.image = [[UIImage alloc] initWithData:responseObject];
        _imageBtn.selected = YES;
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
        _uploadImage.image = [UIImage imageNamed:@"WX_UpLoadImage.png"];
        _imageBtn.selected = NO;
    } failure:^(NSError *error) {
        
    }];
}
- (IBAction)actionForUpdateImage:(UIButton *)sender {
    if (_imageBtn.selected) {
        ImagePreView *preview = [[ImagePreView alloc] init];
        preview.previewImage = _uploadImage.image;
        [preview show];
        preview.deleBlcok = ^{
            [self delegateImage];
        };
    }else{
        [self selectImage];
    }
}
- (IBAction)actionForSure:(UIButton *)sender {
//    AdContent    编辑文字一@~v~@编辑文字二@~v~@编辑文字三
    if (![Judge judgeStringIsEmpty:_wenzi1TF.text]) {
        [DSPManger shareManger].AdContent = _wenzi1TF.text;
    }if(![Judge judgeStringIsEmpty:_wenzi2TF.text]){
        [DSPManger shareManger].AdContent = [NSString stringWithFormat:@"%@@~v~@%@",[DSPManger shareManger].AdContent,_wenzi2TF.text];
    }if(![Judge judgeStringIsEmpty:_wenzi3TF.text]){
         [DSPManger shareManger].AdContent = [NSString stringWithFormat:@"%@@~v~@%@",[DSPManger shareManger].AdContent,_wenzi3TF.text];
    }
    if (_updateBlock) {
        _updateBlock(![Judge judgeStringIsEmpty:_data]);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    uploadImage = [uploadImage scaleToSize:CGSizeMake(960, 360)];
    NSData *data = [uploadImage compressQualityWithMaxLength:300*1024];
    if (data) {
        NSString *imgStr =[[NSString alloc] initWithData: [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength] encoding:NSUTF8StringEncoding];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpeg",[DSPManger shareManger].pkey_value];
//        tableName    flb_dsp
        NSDictionary *dic = @{
                              @"name_diaplay":fileName,
                              @"pkey_value":[DSPManger shareManger].pkey_value,
                              @"tableName":@"flb_dsp",
                              @"token":[[UserManger shareManger] getUserID],
                              @"attach_type":@"MAIN",
                              @"suffix":@"jpeg",
                              @"comments":@"DSP图片",
                              @"attach_size":@(data.length/1024.0),
                              @"file_content":imgStr
                              };
        [self upLoadImage:dic];
    }
}
@end
