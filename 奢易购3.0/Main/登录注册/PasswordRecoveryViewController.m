//
//  PasswordRecoveryViewController.m
//  奢易购3.0
//
//  Created by Andy on 16/9/21.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "PasswordRecoveryViewController.h"
#import "AppDelegate.h"

@interface PasswordRecoveryViewController ()<UITextFieldDelegate>{
    
    UITextField *nameTextField;
    UITextField *phoneTextField;
    UITextField *codeTextField;
    UITextField *passwordTextField;
    UIButton *codeButton;
    NSInteger number;

}


@end

@implementation PasswordRecoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    //左边Item
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0, 0, 10, 19);
//    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    
//    self.navigationItem.leftBarButtonItem = leftButtonItem;
//    
    number = 60;
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    
    [self.view addGestureRecognizer:singleRecognizer];
    
    
    //背景图片
    
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    bgImageV.image = [UIImage imageNamed:@"logobg.png"];
    
    [self.view addSubview:bgImageV];
    
    //logo
    
    UIImageView *logoImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-92, 60, 183, 140)];
    logoImageV.image = [UIImage imageNamed:@"logo@2x.png"];
    
    [self.view addSubview:logoImageV];
    
//    UILabel *logoLbael = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, logoImageV.bottom+18, 100, 30)];
//    logoLbael.text = @"3.0Beta";
//    logoLbael.textColor = [RGBColor colorWithHexString:@"#e9ebf9"];
//    logoLbael.font = [UIFont systemFontOfSize:23];
//    [self.view addSubview:logoLbael];
    
    //账号密码
    
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 150, kScreenHeight/2 - 88, 300, 176)];
    
//    midView.backgroundColor = [UIColor whiteColor];
//    midView.layer.cornerRadius = 5;
//    midView.layer.masksToBounds = YES;
//    midView.layer.borderWidth = 1;
//    midView.layer.borderColor = [RGBColor colorWithHexString:@"#999999"].CGColor;
    [self.view addSubview:midView];
    
    
    //手机号和密码 店名 短信验证码
    
    //店名
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 40, 20)];
    nameLabel.text = @"账号:";
    nameLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [midView addSubview:nameLabel];
    
    nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameLabel.right, nameLabel.top, 200, 20)];
    nameTextField.tag = 110;
    nameTextField.delegate = self;
    nameTextField.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    nameTextField.font = [UIFont systemFontOfSize:15];
    nameTextField.placeholder = @"请输入手机号或者邮箱";
    [nameTextField setValue:[RGBColor colorWithHexString:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [nameTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:nameTextField];
    
    
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, nameLabel.top+44, 55, 20)];
    phoneLabel.text = @"新密码:";
    phoneLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    phoneLabel.font = [UIFont systemFontOfSize:15];
    [midView addSubview:phoneLabel];
    
    phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(phoneLabel.right, phoneLabel.top, 200, 20)];
    phoneTextField.delegate = self;
    phoneTextField.tag = 111;
    phoneTextField.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    phoneTextField.secureTextEntry = YES;
    phoneTextField.font = [UIFont systemFontOfSize:15];
    phoneTextField.placeholder = @"请输入密码";
    [phoneTextField setValue:[RGBColor colorWithHexString:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [phoneTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:phoneTextField];
    
    
    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, phoneLabel.top+44, 90, 20)];
    passwordLabel.text = @"确定新密码:";
    passwordLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    passwordLabel.font = [UIFont systemFontOfSize:15];
    [midView addSubview:passwordLabel];
    
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(passwordLabel.right, passwordLabel.top, 200, 20)];
    passwordTextField.delegate = self;
    passwordTextField.tag = 112;
    passwordTextField.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.font = [UIFont systemFontOfSize:15];
    passwordTextField.placeholder = @"请输入密码";
    [passwordTextField setValue:[RGBColor colorWithHexString:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [passwordTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:passwordTextField];
    
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, passwordLabel.top+44, 90, 20)];
    codeLabel.text = @"获取验证码:";
    codeLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    codeLabel.font = [UIFont systemFontOfSize:15];
    [midView addSubview:codeLabel];
    
    codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(codeLabel.right, codeLabel.top, 100, 20)];
    codeTextField.delegate = self;
    codeTextField.tag = 113;
    codeTextField.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    codeTextField.font = [UIFont systemFontOfSize:15];
    codeTextField.placeholder = @"请输入验证码";
    [codeTextField setValue:[RGBColor colorWithHexString:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [codeTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:codeTextField];
    
    codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    codeButton.frame = CGRectMake(midView.width-78, midView.height-7-20, 68, 24);
    [codeButton setBackgroundImage:[UIImage imageNamed:@"hqyz@2x"] forState:UIControlStateNormal];
    
    [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    codeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [codeButton addTarget:self action:@selector(codeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    codeButton.layer.cornerRadius = 5;
    codeButton.layer.masksToBounds = YES;
    
    [midView addSubview:codeButton];

    //中间线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 45, 280, 1)];
    lineView.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    [midView addSubview:lineView];
    
    //中间线
    UIView *line1View = [[UIView alloc]initWithFrame:CGRectMake(10, lineView.top+44, 280, 1)];
    line1View.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    [midView addSubview:line1View];
    
    //中间线
    UIView *line2View = [[UIView alloc]initWithFrame:CGRectMake(10, line1View.top+44, 280, 1)];
    line2View.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    [midView addSubview:line2View];
    
    
    //中间线
    UIView *line3View = [[UIView alloc]initWithFrame:CGRectMake(10, line2View.top+44, 280, 1)];
    line3View.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    [midView addSubview:line3View];
    
    //注册按钮
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton.frame = CGRectMake(kScreenWidth/2 - 140, midView.bottom+32, 280, 44);
    [registButton setBackgroundImage:[UIImage imageNamed:@"loginbtn@2x"] forState:UIControlStateNormal];
    
    [registButton setBackgroundImage:[UIImage imageNamed:@"btnenter@2x"] forState:UIControlStateHighlighted];
    registButton.layer.borderWidth = 1;
    registButton.layer.borderColor = [RGBColor colorWithHexString:@"#ffffff"].CGColor;
    [registButton setTitle:@"确定" forState:UIControlStateNormal];
    registButton.layer.cornerRadius = 3;
    registButton.layer.masksToBounds = YES;
    
    [registButton addTarget:self action:@selector(registButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];

    
    //登录按钮
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(kScreenWidth - 54 - (kScreenWidth - 300)/2 - 10, registButton.bottom+13, 54, 19);
    
    [loginButton setImage:[UIImage imageNamed:@"返回登录"] forState:UIControlStateNormal];
    [loginButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

//确定
- (void)registButtonAction{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    if ([nameTextField.text isEqualToString:@""]) {
        alertV.message = @"手机号不能为空";
        [alertV show];
        return;
    }
    if ([phoneTextField.text isEqualToString:@""]) {
        alertV.message = @"密码不能为空";
        [alertV show];
        return;
    }
    if ([codeTextField.text isEqualToString:@""]) {
        alertV.message = @"验证码不能为空";
        [alertV show];
        return;
    }
    
    if (![passwordTextField.text isEqualToString:phoneTextField.text] ) {
        alertV.message = @"密码不相同";
        [alertV show];
        return;
    }
    
    [params setObject:nameTextField.text forKey:@"mobile"];

    [params setObject:phoneTextField.text forKey:@"password"];

    [params setObject:codeTextField.text forKey:@"code"];

    
    [DataSeviece requestUrl:find_passwordhtml params:params success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:@"SYGData"]];
            [dic setObject:passwordTextField.text forKey:@"password"];
            [defaults setObject:dic forKey:@"SYGData"];
            [defaults synchronize];
            alertV.message = @"修改密码成功";
            [alertV show];
            [self dismissViewControllerAnimated:YES completion:nil];

        }else{
            
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



//获取验证码
- (void)codeButtonAction:(UIButton*)bt{
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    if ([nameTextField.text isEqualToString:@""]) {
        alertV.message = @"账号不能为空";
        [alertV show];
        return;
    }
    [DataSeviece requestUrl:send_codehtml_API params:[@{@"mobile":nameTextField.text,@"code_type":@"1"} mutableCopy] success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            //            alertV.message = @"发送成功";
            //            [alertV show];
            codeButton.userInteractionEnabled = NO;
            [codeButton setBackgroundImage:[UIImage imageNamed:@"hqyzhui@2x"] forState:UIControlStateNormal];
            
            [codeButton setTitleColor:[RGBColor colorWithHexString:@"#b3b3b3"] forState:UIControlStateNormal];
            
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
            
        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)timeAction:(NSTimer*)timer{
    
    if (number == 0) {
        codeButton.userInteractionEnabled = YES;
        [timer invalidate];
        timer = nil;
        number = 60;
        [codeButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [codeButton setBackgroundImage:[UIImage imageNamed:@"hqyz@2x"] forState:UIControlStateNormal];
        
        [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }else{
        number--;
        
        [codeButton setTitle:[NSString stringWithFormat:@"%ld秒",number] forState:UIControlStateNormal];
    }
    
}


//登录
- (void)loginButtonAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

//隐藏键盘
- (void)singleAction{

    [phoneTextField resignFirstResponder];
    
    [nameTextField resignFirstResponder];
    
    [passwordTextField resignFirstResponder];
    
    [codeTextField resignFirstResponder];
}

////返回
//- (void)leftBtnAction{
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}



//- (IBAction)HQYZMAction:(id)sender {
//
//    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    
//    if ([_SJHTextField.text isEqualToString:@""]) {
//        alertV.message = @"手机号不能为空";
//        [alertV show];
//        return;
//    }
//    
//    
//    [DataSeviece requestUrl:send_codehtml_API params:[@{@"mobile":_SJHTextField.text,@"code_type":@"1"} mutableCopy] success:^(id result) {
//        
//        NSLog(@"%@",result);
//        
//        
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        
//    }];
//
//}
//
//
//- (IBAction)XYBAction:(id)sender {
//    
//    
//}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


@end
