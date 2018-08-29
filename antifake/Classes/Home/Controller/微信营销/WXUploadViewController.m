//
//  WXUploadViewController.m
//  antifake
//
//  Created by 岳腾飞 on 2018/6/18.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "WXUploadViewController.h"
#import "WXYingXiaoManger.h"
#import "WXYingxiaoModelControl.h"
#import "UIImage+CustomSize.h"
#import <AFNetworking.h>
#import "ImagePreView.h"

@interface WXUploadViewController ()
<
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITextViewDelegate
>
@property (weak, nonatomic) IBOutlet UITextView *wenanTextView;
@property (weak, nonatomic) IBOutlet UILabel *zishuLabel;
@property (weak, nonatomic) IBOutlet UIImageView *upLoadImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upLoadImageHeight;
@property (weak, nonatomic) IBOutlet UIButton *upLoadImagBtn;

@end

@implementation WXUploadViewController{
    WXQueryFileListModel *_queryFileListModel;
    NSString *_data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}
-(void)initView{
    self.title = @"上传外层素材";
    _wenanTextView.delegate = self;
}
-(void)configView{
    
}
#pragma mark - Net
-(void)getData{
    NSDictionary *paramtar = @{
                               @"pkey_value":[WXYingXiaoManger shareManger].pkey_value,
                               @"token":[UserManger shareManger].getUserID,
                               @"tableName":@"flb_wxfriends_advertisement"
                               };
    [WXYingxiaoModelControl getqueryFileList:paramtar success:^(NSArray *dataArray) {
        for (NSDictionary *dic in dataArray) {
            if ([[dic objectForKey:@"attach_type"] isEqualToString:@"OUT_MATERIAL"]) {
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
-(void)delegateImage{
    NSDictionary *paramtar = @{
                               @"token":[UserManger shareManger].getUserID,
                               @"id":_data
                               };
    [WXYingxiaoModelControl deleteFile:paramtar success:^(NSString *data) {
        [SVProgressHUD showInfoWithStatus:@"删除成功！"];
        _upLoadImageView.image = [UIImage imageNamed:@"WX_UpLoadImage.png"];
        _upLoadImagBtn.selected = NO;
    } failure:^(NSError *error) {
        
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
        self->_upLoadImageView.image = [[UIImage alloc] initWithData:responseObject];
        _upLoadImagBtn.selected = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - Action
- (IBAction)actionForUpLoadImage:(UIButton *)sender {
    if (_upLoadImagBtn.selected) {
        ImagePreView *preview = [[ImagePreView alloc] init];
        preview.previewImage = _upLoadImageView.image;
        [preview show];
        preview.deleBlcok = ^{
            [self delegateImage];
        };
    }else{
        [self selectImage];
    }
}
- (IBAction)actionForComplete:(UIButton *)sender {
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
                              @"tableName":@"flb_wxfriends_advertisement",
                              @"token":[[UserManger shareManger] getUserID],
                              @"attach_type":@"OUT_MATERIAL",
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
    if ([textView.text isEqualToString:@"请输入详细内容"]) {
        textView.text = @"";
        textView.textColor = HEX_COLOR(0x333333);
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入详细内容"]) {
        _zishuLabel.text = @"0/40";
    }else{
        _zishuLabel.text = [NSString stringWithFormat:@"%ld/40",textView.text.length];
    }
    if (textView.text.length > 40) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, 39)];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@""]){
        textView.text = @"请输入详细内容";
        textView.textColor = HEX_COLOR(0x999999);
    }
}
@end
