//
//  ZFMessageSalesController.m
//  antifake
//
//  Created by Zach on 2018/5/12.
//  Copyright © 2018年 Zach. All rights reserved.
//

#import "ZFMessageSalesController.h"

@interface ZFMessageSalesController ()<UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *telephoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *chooseContactButton;
@property (weak, nonatomic) IBOutlet UILabel *numberAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *WordNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTextLabel;
// 签名
@property (weak, nonatomic) IBOutlet UITextField *noticeTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet UILabel *fareLabel;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation ZFMessageSalesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupTextFieldAndTextView];
    
}






- (void)setupTextFieldAndTextView{
    
    self.telephoneTextField.delegate = self;
    self.noticeTextField.delegate = self;
    self.contentTextView.delegate = self;
    
    [self.telephoneTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.noticeTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.WordNumberLabel.text = [NSString stringWithFormat:@"已输入0字，总共%lu字", self.noticeLabel.text.length + self.endTextLabel.text.length];
    
}




- (void)textFieldChanged:(UITextField *)textField{
    
    
    if (textField == self.telephoneTextField) {
        
        ZFLog(@"手机号输入");
        // 1.截取文本内容——>以,为分隔符进行分割判断有多少
        
    }else{
        
        ZFLog(@"签名输入");
        // 0.最大长度监听
        if (self.noticeTextField.text.length > 25) {
            [SVProgressHUD showInfoWithStatus:@"签名长度不能超过25个字"];
            return;
        }
        
        // 1.计算文字长度

        float wirtingLength = self.noticeTextField.text.length + self.contentTextView.text.length;
        float normalength = self.noticeLabel.text.length + self.endTextLabel.text.length;
        self.WordNumberLabel.text = [NSString stringWithFormat:@"已输入%.0f，总共%.0f字", wirtingLength, wirtingLength+normalength];
        
        // 2.动态变化短信签名内容
        self.noticeLabel.text = [NSString stringWithFormat:@"【%@】", self.noticeTextField.text];
    }
    
}



/******************* return键盘收起 *******************/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    
    [self keyboardBackWithView];
    
    return YES;
}

/******************* 收起键盘 *******************/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
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
    
    int offset = 205 + frame.origin.y + 42 - ( heights - 216.0);//键盘高度216
    
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


//- (void)textf


#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeholderLabel.hidden = YES;
    
    
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    if (textView.text.length > 0) {
        
        self.placeholderLabel.hidden = YES;
        
    }else{
        
        self.placeholderLabel.hidden = NO;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
