//
//  ZFAddShopController.m
//  antifake
//
//  Created by Zach on 2018/5/7.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFAddShopController.h"

@interface ZFAddShopController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *shopNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *managerTextField;

@property (weak, nonatomic) IBOutlet UITextField *IDCardTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *businessTextField;

@property (weak, nonatomic) IBOutlet UITextField *placeTextField;

@property (weak, nonatomic) IBOutlet UITextField *businessIDTextField;

@end

@implementation ZFAddShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 0.消除间距
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 1.设置NavTitle
    self.navigationItem.title = @"添加店铺";
    
    [self setupTextField];
    
}


/*************** 初始化UITextField ***************/
- (void)setupTextField
{
    self.shopNameTextField.delegate = self;
    self.managerTextField.delegate = self;
    self.IDCardTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.businessTextField.delegate = self;
    self.placeTextField.delegate = self;
    self.businessIDTextField.delegate = self;
}


- (IBAction)addClickAction:(id)sender {
    
    if ([self.shopNameTextField.text isEqualToString:@""]){
        
        [SVProgressHUD showInfoWithStatus:@"请输入店铺名称"];
        
        return;
    }
    if ([self.managerTextField.text isEqualToString:@""]){
        
        [SVProgressHUD showInfoWithStatus:@"请输入店主姓名"];
        
        return;
    }
    
    if ([self.IDCardTextField.text isEqualToString:@""]){
        
        [SVProgressHUD showInfoWithStatus:@"请输入身份证号码"];
        
        return;
    }
    
    
    
    /***** 0.初始化参数 *****/
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // 姓名+密码——>要进行MD5加密
    parameters[@"token"] = [[UserManger shareManger] getUserID];
    parameters[@"businessName"] = self.shopNameTextField.text;
    parameters[@"managerName"] = self.managerTextField.text;
    parameters[@"bus_phone"] = self.phoneTextField.text;
    parameters[@"bus_idCard"] = self.IDCardTextField.text;
    parameters[@"bus_site"] = self.placeTextField.text;
    parameters[@"bus_license_number"] = self.businessIDTextField.text;
    parameters[@"industry"] = self.businessTextField.text;
    
    
    
    /***** 1.发送短信请求 *****/
    [[ZFNetTool shareNetTool] POSWithURL:ZFAddShopURL parameters:parameters success:^(id data) {
        
        // a.JSONDict
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        ZFLog(@"添加店铺=====%@", JSON);
        
        if (JSON[@"flag"]) {
            
            
            [SVProgressHUD showInfoWithStatus:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
//            [SVProgressHUD showErrorWithStatus:@"添加失败"];
            
        }
       
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"您的网络不给力"];
        
    }];
}


#pragma mark - TextFieldSetting

/******************* return键盘收起 *******************/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    
    [self keyboardBackWithView];
    
    return YES;
}

/******************* 收起键盘 *******************/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    [self keyboardBackWithView];
    
}

/******************* 键盘收起时View回弹 *******************/
- (void)keyboardBackWithView
{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, ZFNAVIGATION_BAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    
}

#pragma mark - UITextFieldDelegate

/******************* 开始输入 *******************/
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    
    CGFloat heights = self.view.frame.size.height;
    
    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
    
    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
    
    int offset = 100 + frame.origin.y + 42 - ( heights - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.view.frame.size.width;
    
    float height = self.view.frame.size.height;
    
    if(offset > 0) {
        
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        
        self.view.frame = rect;
        
    }
    
    [UIView commitAnimations];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
