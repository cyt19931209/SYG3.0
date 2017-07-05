//
//  LoginViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/18.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "AppDelegate.h"
#import "PasswordRecoveryViewController.h"



@interface LoginViewController ()<UITextFieldDelegate>{

    UITextField *phoneTextField;
    UITextField *passwordTextField;
    UIButton *codeButton;
    NSInteger number;

}

@property (nonatomic,strong) UIImageView *selectImageV;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    number = 60;
    //背景图片
    
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    bgImageV.image = [UIImage imageNamed:@"logobg"];
    
    [self.view addSubview:bgImageV];
    
    //账号密码
    
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 150, kScreenHeight/2 - 60, 300, 120)];
    
    [self.view addSubview:midView];
    
    //logo
    
    UIImageView *logoImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-92, 60, 183, 140)];
    logoImageV.image = [UIImage imageNamed:@"logo@2x.png"];
    
    [self.view addSubview:logoImageV];
    
    //主账号和子账号选择按钮
    
    UIButton *mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mainButton.frame = CGRectMake(0, 0, midView.width/2, 30);
    [mainButton setTitle:@"主账号" forState:UIControlStateNormal];
    [mainButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [mainButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
    mainButton.titleLabel.font = [UIFont systemFontOfSize:16];

    mainButton.tag = 101;
    mainButton.selected = YES;
    [mainButton addTarget:self action:@selector(mainButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:mainButton];
    
    
    _selectImageV = [[UIImageView alloc]initWithFrame:CGRectMake((midView.width/2 - 20)/2, 25, 20, 10)];
    
    _selectImageV.image = [UIImage imageNamed:@"ydb@2x"];
    
//    _selectImageV.backgroundColor = [UIColor whiteColor];
//    _selectImageV.layer.cornerRadius = 4;
//    _selectImageV.layer.masksToBounds = YES;
    [mainButton addSubview:_selectImageV];
    
    UIButton *sonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sonButton.frame = CGRectMake(midView.width/2, 0, midView.width/2, 30);
    [sonButton setTitle:@"子账号" forState:UIControlStateNormal];
    [sonButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [sonButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
    sonButton.titleLabel.font = [UIFont systemFontOfSize:16];
    sonButton.tag = 102;
    [sonButton addTarget:self action:@selector(sonButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:sonButton];
    
    //手机号和密码
    
    UIImageView *phoneImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 48, 19, 22)];
    
    phoneImageV.image = [UIImage imageNamed:@"员工@3x"];
    
    [midView addSubview:phoneImageV];

    phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(phoneImageV.right+10, 50, 200, 22)];
    phoneTextField.delegate = self;
    phoneTextField.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    phoneTextField.tag = 110;
    phoneTextField.font = [UIFont systemFontOfSize:18];
    phoneTextField.keyboardType = UIKeyboardTypeEmailAddress;
    phoneTextField.placeholder = @"请输入手机号或者邮箱";
    [phoneTextField setValue:[RGBColor colorWithHexString:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [phoneTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:phoneTextField];
    
    UIImageView *passwordImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 95, 19, 22)];
    passwordImageV.image = [UIImage imageNamed:@"mima@2x"];
    passwordImageV.tag = 121;
    [midView addSubview:passwordImageV];
    
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(passwordImageV.right+10, 97, 200, 22)];
    passwordTextField.delegate = self;
    passwordTextField.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    passwordTextField.tag = 111;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.font = [UIFont systemFontOfSize:18];
    passwordTextField.placeholder = @"请输入密码";
    [passwordTextField setValue:[RGBColor colorWithHexString:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [passwordTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:passwordTextField];
    
    codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    codeButton.frame = CGRectMake(midView.width-78, midView.height-7-30+10, 68, 24);
    
    [codeButton setBackgroundImage:[UIImage imageNamed:@"hqyz@2x"] forState:UIControlStateNormal];
    
    
    [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    codeButton.titleLabel.font = [UIFont systemFontOfSize:12];

    [codeButton addTarget:self action:@selector(codeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    codeButton.layer.cornerRadius = 5;
    codeButton.layer.masksToBounds = YES;
    codeButton.hidden = YES;
    codeButton.tag = 120;
    [midView addSubview:codeButton];


    //中间线
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 75, 280, 1)];
    lineView.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    [midView addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(10, 125, 280, 1)];
    lineView1.backgroundColor = [RGBColor colorWithHexString:@"#ffffff"];
    [midView addSubview:lineView1];

    
    //登录按钮
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(kScreenWidth/2 - 140, midView.bottom+32, 280, 44);
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"loginbtn@2x"] forState:UIControlStateNormal];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"btnenter@2x"] forState:UIControlStateHighlighted];
    loginButton.layer.borderWidth = 1;
    loginButton.layer.borderColor = [RGBColor colorWithHexString:@"#ffffff"].CGColor;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    loginButton.titleLabel.font = [UIFont systemFontOfSize:21];
    
    
    
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.masksToBounds = YES;
    [self.view addSubview:loginButton];
    
    //注册按钮
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton.frame = CGRectMake(kScreenWidth - 64 - (kScreenWidth - midView.width)/2, loginButton.bottom+13, 54, 19);
    
    [registButton setTitle:@"免费注册" forState:UIControlStateNormal];
    [registButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [registButton addTarget:self action:@selector(registButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
    
    //忘记密码
    UIButton *passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    passwordButton.frame = CGRectMake((kScreenWidth - midView.width)/2, loginButton.bottom+15, 80, 15);
    
    [passwordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [passwordButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [passwordButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    passwordButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [passwordButton addTarget:self action:@selector(passwordButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:passwordButton];
    
    

}


//忘记密码
- (void)passwordButtonAction{
    
    PasswordRecoveryViewController *passwordRecoveryVC = [[PasswordRecoveryViewController alloc]init];
    
    [self presentViewController:passwordRecoveryVC animated:YES completion:nil];
    

}


//获取验证码
- (void)codeButtonAction:(UIButton*)bt{
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

    if ([phoneTextField.text isEqualToString:@""]) {
        alertV.message = @"账号不能为空";
        [alertV show];
        return;
    }
    
    [DataSeviece requestUrl:send_codehtml_API params:[@{@"mobile":phoneTextField.text,@"code_type":@"3"} mutableCopy] success:^(id result) {
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

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    

    UIButton *button = [self.view viewWithTag:101];
    NSString *url;
    if ([phoneTextField.text isEqualToString:@""]) {
        alertV.message = @"账号不能为空";
        [alertV show];
        return;
    }else{
        [params setObject:phoneTextField.text forKey:@"mobile"];
    }

    if (button.selected) {
        
        if ([passwordTextField.text isEqualToString:@""]) {
            alertV.message = @"密码不能为空";
            [alertV show];
            return;
        }else{
            
            [params setObject:passwordTextField.text forKey:@"password"];
        }
        
        url = master_loginhtmlA_API;

    }else{
        if ([passwordTextField.text isEqualToString:@""]) {
            alertV.message = @"验证码不能为空";
            [alertV show];
            return;
        }else{
            
            [params setObject:passwordTextField.text forKey:@"code"];
        }
        url = child_loginhtml_API;
    
    }

    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [UIApplication sharedApplication].keyWindow.rootViewController = delegate.drawerController;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            
            NSMutableArray *arr = nil;
            
            if ([defaults objectForKey:@"IdArr"]) {
                
                arr = [NSMutableArray arrayWithArray:[defaults objectForKey:@"IdArr"]];

            }else{
            
                arr = [NSMutableArray array];
            }
            
            BOOL isAdd = YES;
            
            NSLog(@"%@",arr);
            
            for (NSString *str in arr) {
                
                NSLog(@"%@ %@",str,result[@"result"][@"data"][@"id"]);

                
                if ([str isEqualToString:result[@"result"][@"data"][@"id"]]) {
                    isAdd = NO;
                }
            }
            
            if (isAdd) {
                [arr addObject:result[@"result"][@"data"][@"id"]];
            }
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[NULLHandle NUllHandle:result[@"result"][@"data"]]];
            NSDictionary *dic1 = [NULLHandle NUllHandle:dic[@"shopinfo"]];
            [dic setObject:dic1 forKey:@"shopinfo"];
            [dic setObject:passwordTextField.text forKey:@"password"];
            [defaults setObject:dic forKey:@"SYGData"];
            [defaults setObject:arr forKey:@"IdArr"];
            [defaults synchronize];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataNotifocation" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
        }else{
            
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];

    
    
}
//注册
- (void)registButtonAction{

    RegistViewController *registVC = [[RegistViewController alloc]init];
    
    [self presentViewController:registVC animated:YES completion:nil];
    
}


//主账号选择
- (void)mainButtonAction:(UIButton*)bt{

    if (bt.selected == NO) {
        UIButton *sonButton = (UIButton*)[self.view viewWithTag:102];
        sonButton.selected = NO;
        bt.selected = YES;
        UIImageView *imageV = [self.view viewWithTag:121];
        imageV.image = [UIImage imageNamed:@"mima@2x"];
        UIButton *button = (UIButton*)[self.view viewWithTag:120];
        button.hidden = YES;
        phoneTextField.text = @"";
        passwordTextField.text = @"";
        passwordTextField.secureTextEntry = YES;
        passwordTextField.placeholder = @"请输入密码";
        [passwordTextField setValue:[RGBColor colorWithHexString:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
        [passwordTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];

        [bt addSubview:_selectImageV];
    }
    
}

//子帐号选择
- (void)sonButtonAction:(UIButton*)bt{

    if (bt.selected == NO) {
        
        UIButton *mainButton = (UIButton*)[self.view viewWithTag:101];
        mainButton.selected = NO;
        bt.selected = YES;
        UIImageView *imageV = [self.view viewWithTag:121];
        imageV.image = [UIImage imageNamed:@"验证码@2x"];

        UIButton *button = (UIButton*)[self.view viewWithTag:120];
        button.hidden = NO;
        phoneTextField.text = @"";
        passwordTextField.text = @"";
        passwordTextField.secureTextEntry = NO;
        passwordTextField.placeholder = @"请输入验证码";
        [passwordTextField setValue:[RGBColor colorWithHexString:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
        [passwordTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];

        [bt addSubview:_selectImageV];

    }

    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (int i = 0; i < 2; i++) {
        UITextField *textField = [self.view viewWithTag:110+i];
        [textField resignFirstResponder];
        
    }
    
}

@end
