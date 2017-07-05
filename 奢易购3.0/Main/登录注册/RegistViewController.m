//
//  RegistViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/19.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "RegistViewController.h"
#import "AppDelegate.h"


@interface RegistViewController ()<UITextFieldDelegate>{

    UITextField *nameTextField;
    UITextField *phoneTextField;
    UITextField *codeTextField;
    UITextField *passwordTextField;
    UIButton *codeButton;
    NSInteger number;
    
}

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    number = 60;
    
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
//    
    //账号密码
    
    UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 150, kScreenHeight/2 - 88, 300, 176)];
//    
//    midView.backgroundColor = [UIColor whiteColor];
//    midView.layer.cornerRadius = 5;
//    midView.layer.masksToBounds = YES;
//    midView.layer.borderWidth = 1;
//    midView.layer.borderColor = [RGBColor colorWithHexString:@"#999999"].CGColor;
    [self.view addSubview:midView];
    
    
    //手机号和密码 店名 短信验证码
    
    //店名
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 40, 20)];
    nameLabel.text = @"店名:";
    nameLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [midView addSubview:nameLabel];
    
    nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameLabel.right+10, nameLabel.top, 200, 20)];
    nameTextField.tag = 110;
    nameTextField.delegate = self;
    nameTextField.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    nameTextField.font = [UIFont systemFontOfSize:15];
    nameTextField.placeholder = @"请输入店名";
    [nameTextField setValue:[RGBColor colorWithHexString:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [nameTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:nameTextField];

    
    
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, nameLabel.top+44, 40, 20)];
    phoneLabel.text = @"账号:";
    phoneLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    phoneLabel.font = [UIFont systemFontOfSize:15];
    [midView addSubview:phoneLabel];
    
    phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(phoneLabel.right+10, phoneLabel.top-2, 200, 20)];
    phoneTextField.delegate = self;
    phoneTextField.tag = 111;
    phoneTextField.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    phoneTextField.font = [UIFont systemFontOfSize:15];
    phoneTextField.placeholder = @"请输入手机号或者邮箱";
    [phoneTextField setValue:[RGBColor colorWithHexString:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [phoneTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    phoneTextField.keyboardType = UIKeyboardTypeEmailAddress;

    [midView addSubview:phoneTextField];
    
    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, phoneLabel.top+44, 40, 20)];
    passwordLabel.text = @"密码:";
    passwordLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    passwordLabel.font = [UIFont systemFontOfSize:15];
    [midView addSubview:passwordLabel];
    
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(passwordLabel.right+10, passwordLabel.top-2, 200, 20)];
    passwordTextField.delegate = self;
    passwordTextField.tag = 112;
    passwordTextField.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    passwordTextField.secureTextEntry = YES;

    passwordTextField.font = [UIFont systemFontOfSize:15];
    
    passwordTextField.placeholder = @"请输入密码";
    [passwordTextField setValue:[RGBColor colorWithHexString:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [passwordTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [midView addSubview:passwordTextField];
    
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, passwordLabel.top+44, 55, 20)];
    codeLabel.text = @"验证码:";
    codeLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    codeLabel.font = [UIFont systemFontOfSize:15];
    [midView addSubview:codeLabel];
    
    codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(codeLabel.right, codeLabel.top, 100, 20)];
    codeTextField.delegate = self;
    codeTextField.tag = 113;
    codeTextField.textColor = [RGBColor colorWithHexString:@"#ffffff"];
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
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    registButton.layer.cornerRadius = 3;
    registButton.layer.masksToBounds = YES;
    [registButton addTarget:self action:@selector(registButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registButton];
    
    //登录按钮
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(kScreenWidth/2-100, registButton.bottom+20, 200, 15);
    [loginButton setTitle:@"已有奢易购账号？去登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[RGBColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
}

//获取验证码
- (void)codeButtonAction:(UIButton*)bt{

    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    if ([phoneTextField.text isEqualToString:@""]) {
        alertV.message = @"账号不能为空";
        [alertV show];
        return;
    }
    [DataSeviece requestUrl:send_codehtml_API params:[@{@"mobile":phoneTextField.text,@"code_type":@"2"} mutableCopy] success:^(id result) {
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
//注册
- (void)registButtonAction{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    if ([nameTextField.text isEqualToString:@""]) {
        alertV.message = @"店名不能为空";
        [alertV show];
        return;
    }else{
        [params setObject:nameTextField.text forKey:@"shop_name"];
    }
    if ([phoneTextField.text isEqualToString:@""]) {
        alertV.message = @"账号不能为空";
        [alertV show];
        return;
    }else{
        [params setObject:phoneTextField.text forKey:@"mobile"];
    }
    
    if ([codeTextField.text isEqualToString:@""]) {
        alertV.message = @"验证码不能为空";
        [alertV show];
        return;
    }else{
        [params setObject:codeTextField.text forKey:@"code"];
    }

    if ([passwordTextField.text isEqualToString:@""]) {
        alertV.message = @"密码不能为空";
        [alertV show];
        return;
    }else{
        [params setObject:passwordTextField.text forKey:@"password"];
    }

    [DataSeviece requestUrl:registerhtml_API params:params success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
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
            

            
            NSDictionary *dic = [NULLHandle NUllHandle:result[@"result"][@"data"]];
            
            [defaults setObject:dic forKey:@"SYGData"];
            [defaults setObject:arr forKey:@"IdArr"];
            
            [defaults synchronize];
            
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [UIApplication sharedApplication].keyWindow.rootViewController = delegate.drawerController;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PresentNotification" object:nil];
            
            
        }else{
        
            alertV.message = result[@"result"][@"msg"];
            [alertV show];

        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (int i = 0; i < 4; i++) {
        UITextField *textField = [self.view viewWithTag:110+i];
        [textField resignFirstResponder];
        
    }

}



@end
