//
//  EmailViewController.m
//  奢易购3.0
//
//  Created by guest on 16/8/2.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "EmailViewController.h"

@interface EmailViewController ()<UITextFieldDelegate>{

    UITextField *emailTextField;
}

@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"电子邮箱管理";
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fb"];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];

    bgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bgView];
    
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 75, 20)];
    
    emailLabel.text = @"电子邮箱:";
    
    emailLabel.font = [UIFont systemFontOfSize:14];
    
    [bgView addSubview:emailLabel];
    
    emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(emailLabel.right, 12, kScreenWidth-emailLabel.right-10, 20)];
    emailTextField.placeholder = @"请输入你方便接收合同以及通知的电子邮箱";
    
    emailTextField.font = [UIFont systemFontOfSize:12];
    emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    emailTextField.returnKeyType = UIReturnKeySend;
    emailTextField.delegate = self;
    [bgView addSubview:emailTextField];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    emailTextField.text = SYGData[@"email"];
    
    
}

//左边返回按钮
- (void)leftBtnAction{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    //网络加载
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *SYGData = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:@"SYGData"]];
    
    
    [DataSeviece requestUrl:edit_shop_infohtml params:[@{@"uid":SYGData[@"id"],@"email":emailTextField.text} mutableCopy] success:^(id result) {
        
        
        NSLog(@"%@",result);
        UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            alertV.message = @"修改成功";
            [alertV show];
            [SYGData setValue:emailTextField.text forKey:@"email"];
            
            [defaults setValue:SYGData forKey:@"SYGData"];

            [defaults synchronize];
            
        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

    [textField resignFirstResponder];
    return YES;
}

@end
