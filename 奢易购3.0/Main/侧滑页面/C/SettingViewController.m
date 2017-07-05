//
//  SettingViewController.m
//  奢易购3.0
//
//  Created by Andy on 16/9/18.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SettingViewController.h"
#import "SetPhoneOrEmailViewController.h"
#import "PasswordRecoveryViewController.h"

@interface SettingViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{

    NSDictionary *SYGData;
    
    UITextField *titleTextField;
    UITextField *xxTextield;
    UILabel *dqLabel;
    
    UIPickerView *_mPickerView;
    NSArray *provinceArr;
    NSArray *cityArr;
    NSArray *districtArr;
    
    NSInteger provinceIndex;
    NSInteger cityIndex;
    NSInteger districtIndex;
    
    NSString *allName;
    NSString *allCode;
    UIView *_adressV;
    
    NSArray *jsonDataArr;
    
    UILabel *emailLabel;
    UILabel *phoneLabel;
}



@end

@implementation SettingViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    SYGData  = [defaults objectForKey:@"SYGData"];

    
    NSLog(@"%@",SYGData);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SYGDataAction) name:@"SYGDataAction" object:nil];
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    

    
    //右边Item
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 30, 30);
//    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [rightBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
//

    self.view.backgroundColor = [RGBColor colorWithHexString:@"f1f2fa"];

    if ([SYGData[@"type"] isEqualToString:@"2"]) {
        self.navigationItem.title = @"店铺资料";
    }else{
        self.navigationItem.title = @"个人中心";
    }
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    UIImageView *titleImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 219)];
    titleImageV.userInteractionEnabled = YES;
    titleImageV.image = [UIImage imageNamed:@"bg@2x"];
    
    [self.view addSubview:titleImageV];
    
    UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    iconButton.frame = CGRectMake(kScreenWidth/2-35, 84, 70, 70);
    
    [iconButton setImage:[UIImage imageNamed:@"ntx@2x"] forState:UIControlStateNormal];
    
    [self.view addSubview:iconButton];
    
    UILabel *titleTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-125, 174, 75, 25)];
    
    titleTextLabel.textColor = [UIColor whiteColor];
    
    titleTextLabel.font = [UIFont systemFontOfSize:18];
    if ([SYGData[@"type"] isEqualToString:@"2"]) {
        titleTextLabel.text = @"店名:";
    }else{
        titleTextLabel.text = @"用户名:";
    }
    
    titleTextLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:titleTextLabel];
    

    titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 40, 174, 150, 25)];
    
    titleTextField.textColor = [UIColor whiteColor];
    
    titleTextField.font = [UIFont systemFontOfSize:18];
    
    titleTextField.userInteractionEnabled = NO;
    if ([SYGData[@"type"] isEqualToString:@"2"]) {
        
        titleTextField.text = SYGData[@"shop_name"];
        
    }else{
        
        titleTextField.text = SYGData[@"user_name"];
    }
    
    titleTextField.delegate = self;
    titleTextField.returnKeyType = UIReturnKeySend;
    [self.view addSubview:titleTextField];

    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton setImage:[UIImage imageNamed:@"xgicon@2x"] forState:UIControlStateNormal];
    editButton.frame = CGRectMake(kScreenWidth/2+100, 176, 20, 20);
    [editButton addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editButton];
    
//    if ([SYGData[@"type"] isEqualToString:@"2"]) {
    [self cellView];
    
    
    
    //    地区选择器
    
    _adressV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-300, kScreenWidth, 300)];
    _adressV.backgroundColor = [UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1];
    _adressV.hidden = YES;
    [self.view addSubview:_adressV];
    
    _mPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 300)];
    _mPickerView.delegate = self;
    _mPickerView.dataSource = self;
    [_adressV addSubview:_mPickerView];
    UIButton *trueButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    trueButton1.frame = CGRectMake(kScreenWidth-50, 0, 40, 40);
    [trueButton1 addTarget:self action:@selector(trueAction1) forControlEvents:UIControlEventTouchUpInside];
    [trueButton1 setTitle:@"确定" forState:UIControlStateNormal];
    [_adressV addSubview:trueButton1];
    UIButton *cancelButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton1.frame = CGRectMake(10, 0, 40, 40);
    [cancelButton1 setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton1 addTarget:self action:@selector(cancelAction1) forControlEvents:UIControlEventTouchUpInside];
    [_adressV addSubview:cancelButton1];
    
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    jsonDataArr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    provinceArr = jsonDataArr;
    
    cityArr = jsonDataArr[0][@"city"];
    
    districtArr = jsonDataArr[0][@"city"][0][@"area"];

    
    allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:0] objectForKey:@"name"], [[cityArr objectAtIndex:0] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];

}


- (void)trueAction1{
    _adressV.hidden = YES;
    dqLabel.text = allName;
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *SYGData1  = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:@"SYGData"]];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:provinceArr[provinceIndex][@"id"] forKey:@"province"];
    [params setObject:cityArr[cityIndex][@"id"] forKey:@"city"];
    [params setObject:districtArr[districtIndex][@"id"] forKey:@"area"];

    
    [DataSeviece requestUrl:edit_shop_infohtml params:params success:^(id result) {
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            alertV.message = @"修改成功";
            [alertV show];
            NSMutableDictionary *shopDic = [NSMutableDictionary dictionaryWithDictionary:SYGData1[@"shopinfo"]];
            
            [shopDic setValue:provinceArr[provinceIndex][@"id"] forKey:@"province"];
            [shopDic setValue:cityArr[cityIndex][@"id"] forKey:@"city"];
            [shopDic setValue:districtArr[districtIndex][@"id"] forKey:@"area"];
            [shopDic setObject:provinceArr[provinceIndex][@"name"] forKey:@"province_name"];
            [shopDic setObject:cityArr[cityIndex][@"name"] forKey:@"city_name"];
            [shopDic setObject:districtArr[districtIndex][@"name"]forKey:@"area_name"];
            
            [SYGData1 setObject:shopDic forKey:@"shopinfo"];
            
            [defaults setObject:SYGData1 forKey:@"SYGData"];
            
            [defaults synchronize];
        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
}
- (void)cancelAction1{
    _adressV.hidden = YES;
}

//下面列表视图
- (void)cellView{

    if ([SYGData[@"type"] isEqualToString:@"2"]) {

        //第一个
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        bgButton.frame = CGRectMake(0, 229, kScreenWidth, 44);
        
        [bgButton addTarget:self action:@selector(cellAction) forControlEvents:UIControlEventTouchUpInside];
        bgButton.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgButton];
        
        UIImageView *dzImageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 14, 12, 16)];
        dzImageV.image = [UIImage imageNamed:@"iconfont-dizhi@2x"];
        [bgButton addSubview:dzImageV];
        
        UILabel *dzLabel = [[UILabel alloc]initWithFrame:CGRectMake(32, 12, 74, 20)];
        
        dzLabel.text = @"所在地区";
        
        dzLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        dzLabel.font = [UIFont systemFontOfSize:16];
        [bgButton addSubview:dzLabel];
        
        dqLabel = [[UILabel alloc]initWithFrame:CGRectMake(dzLabel.right +10 , 12, kScreenWidth - dzLabel.right - 20, 20)];
        
        dqLabel.text = [NSString stringWithFormat:@"%@ %@ %@",SYGData[@"shopinfo"][@"province_name"],SYGData[@"shopinfo"][@"city_name"],SYGData[@"shopinfo"][@"area_name"]];
        
        dqLabel.textColor = [RGBColor colorWithHexString:@"#a6a6a6"];
        
        dqLabel.font = [UIFont systemFontOfSize:16];
        [bgButton addSubview:dqLabel];
        
        
        //第二个
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 274, kScreenWidth, 44)];
        
        
        bgView.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:bgView];
        
        UILabel *xxLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 74, 20)];
        
        xxLabel.text = @"详细地址";
        
        xxLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        xxLabel.font = [UIFont systemFontOfSize:16];
        [bgView addSubview:xxLabel];
        
        xxTextield = [[UITextField alloc]initWithFrame:CGRectMake( xxLabel.right+10, 12, kScreenWidth -20 - xxLabel.right, 20)];
        
        xxTextield.textColor = [RGBColor colorWithHexString:@"#a6a6a6"];
        xxTextield.font = [UIFont systemFontOfSize:16];
        xxTextield.text = SYGData[@"shopinfo"][@"address"];
        xxTextield.delegate = self;
        xxTextield.returnKeyType = UIReturnKeySend;
        
        [bgView addSubview:xxTextield];
        
        
        //第三个
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 229+44*2, kScreenWidth, 1)];
        lineV.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
        [self.view addSubview:lineV];
        
        UIButton *bgButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        bgButton3.frame = CGRectMake(0, 229+44*2, kScreenWidth, 44);
        
        [bgButton3 addTarget:self action:@selector(cellAction3) forControlEvents:UIControlEventTouchUpInside];
        bgButton3.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgButton3];
        
        
        UILabel *YXLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 40, 20)];
        
        YXLabel.text = @"邮箱:";
        
        YXLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        YXLabel.font = [UIFont systemFontOfSize:16];
        
        [bgButton3 addSubview:YXLabel];
        
        emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(YXLabel.right +10 , 12, kScreenWidth - YXLabel.right - 20, 20)];
        
        emailLabel.text = SYGData[@"email"];
        emailLabel.textColor = [RGBColor colorWithHexString:@"#a6a6a6"];
        
        emailLabel.font = [UIFont systemFontOfSize:16];
        
        [bgButton3 addSubview:emailLabel];
        
        
        //第四个
        UIView *lineV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 229+44*3, kScreenWidth, 1)];
        lineV1.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
        [self.view addSubview:lineV1];
        
        UIButton *bgButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        bgButton4.frame = CGRectMake(0, 229+44*3, kScreenWidth, 44);
        
        [bgButton4 addTarget:self action:@selector(cellAction4) forControlEvents:UIControlEventTouchUpInside];
        bgButton4.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgButton4];
        
        
        UILabel *SJLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 40, 20)];
        
        SJLabel.text = @"手机:";
        
        SJLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        SJLabel.font = [UIFont systemFontOfSize:16];
        
        [bgButton4 addSubview:SJLabel];
        
        phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(SJLabel.right +10 , 12, kScreenWidth - SJLabel.right - 20, 20)];
        
        phoneLabel.text = SYGData[@"mobile"];
        phoneLabel.textColor = [RGBColor colorWithHexString:@"#a6a6a6"];
        
        phoneLabel.font = [UIFont systemFontOfSize:16];
        
        [bgButton4 addSubview:phoneLabel];

        if (![SYGData[@"type"] isEqualToString:@"3"]) {

        UIButton *editPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        editPasswordButton.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
        
        editPasswordButton.frame = CGRectMake(kScreenWidth/2 - 80,bgButton4.bottom+30 , 160, 44);
        [editPasswordButton addTarget:self action:@selector(editPasswordAction) forControlEvents:UIControlEventTouchUpInside];
        editPasswordButton.layer.cornerRadius = 5;
        editPasswordButton.layer.masksToBounds = YES;
        
        [editPasswordButton setTitle:@"修改密码" forState:UIControlStateNormal];
        
        editPasswordButton.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [self.view addSubview:editPasswordButton];

        }
    }else{
    
        //第三个
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 229, kScreenWidth, 1)];
        lineV.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
        [self.view addSubview:lineV];
        
        UIButton *bgButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        bgButton3.frame = CGRectMake(0, 229, kScreenWidth, 44);
        
        [bgButton3 addTarget:self action:@selector(cellAction3) forControlEvents:UIControlEventTouchUpInside];
        bgButton3.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgButton3];
        
        
        UILabel *YXLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 40, 20)];
        
        YXLabel.text = @"邮箱:";
        
        YXLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        YXLabel.font = [UIFont systemFontOfSize:16];
        
        [bgButton3 addSubview:YXLabel];
        
        emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(YXLabel.right +10 , 12, kScreenWidth - YXLabel.right - 20, 20)];
        
        emailLabel.text = SYGData[@"email"];
        emailLabel.textColor = [RGBColor colorWithHexString:@"#a6a6a6"];
        
        emailLabel.font = [UIFont systemFontOfSize:16];
        
        [bgButton3 addSubview:emailLabel];
        
        
        //第四个
        UIView *lineV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 229+44, kScreenWidth, 1)];
        lineV1.backgroundColor = [RGBColor colorWithHexString:@"#d9d9d9"];
        [self.view addSubview:lineV1];
        
        UIButton *bgButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        bgButton4.frame = CGRectMake(0, 229+44, kScreenWidth, 44);
        
        [bgButton4 addTarget:self action:@selector(cellAction4) forControlEvents:UIControlEventTouchUpInside];
        bgButton4.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgButton4];
        
        
        UILabel *SJLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 40, 20)];
        
        SJLabel.text = @"手机:";
        
        SJLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
        
        SJLabel.font = [UIFont systemFontOfSize:16];
        
        [bgButton4 addSubview:SJLabel];
        
        phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(SJLabel.right +10 , 12, kScreenWidth - SJLabel.right - 20, 20)];
        
        phoneLabel.text = SYGData[@"mobile"];
        phoneLabel.textColor = [RGBColor colorWithHexString:@"#a6a6a6"];
        
        phoneLabel.font = [UIFont systemFontOfSize:16];
        
        [bgButton4 addSubview:phoneLabel];

        
        if (![SYGData[@"type"] isEqualToString:@"3"]) {

        UIButton *editPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        editPasswordButton.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
        
        editPasswordButton.frame = CGRectMake(kScreenWidth/2 - 80,bgButton4.bottom+30 , 160, 44);
        [editPasswordButton addTarget:self action:@selector(editPasswordAction) forControlEvents:UIControlEventTouchUpInside];
        editPasswordButton.layer.cornerRadius = 5;
        editPasswordButton.layer.masksToBounds = YES;
        
        [editPasswordButton setTitle:@"修改密码" forState:UIControlStateNormal];
        
        editPasswordButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:editPasswordButton];
        }
    }

    
    
}

- (void)editPasswordAction{
    PasswordRecoveryViewController *passwordRecoveryVC = [[PasswordRecoveryViewController alloc]init];
    
    [self presentViewController:passwordRecoveryVC animated:YES completion:nil];
    
    


}

//邮箱
- (void)cellAction3{

    SetPhoneOrEmailViewController *setVC = [[SetPhoneOrEmailViewController alloc]init];
    
    setVC.isEmail = YES;
    [self.navigationController pushViewController:setVC animated:YES];
    
}

//手机

- (void)cellAction4{
    
    SetPhoneOrEmailViewController *setVC = [[SetPhoneOrEmailViewController alloc]init];
    
    setVC.isEmail = NO;
    [self.navigationController pushViewController:setVC animated:YES];
}


//选择地区
- (void)cellAction{

    _adressV.hidden = NO;

}

//返回
- (void)leftBtnAction{

    [self dismissViewControllerAnimated:YES completion:nil];

}

//编辑
- (void)editAction{

    titleTextField.userInteractionEnabled = YES;
    
    [titleTextField becomeFirstResponder];

}

//完成
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *SYGData1  = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:@"SYGData"]];

    
    if (textField == titleTextField) {
        
        titleTextField.userInteractionEnabled = NO;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:SYGData[@"id"] forKey:@"uid"];

        if ([SYGData[@"type"] isEqualToString:@"2"]) {
            [params setObject:titleTextField.text forKey:@"shop_name"];
            [DataSeviece requestUrl:edit_shop_infohtml params:params success:^(id result) {
                NSLog(@"%@",result);
                
                if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                    alertV.message = @"修改成功";
                    [alertV show];
                    
                    [SYGData1 setValue:titleTextField.text forKey:@"shop_name"];
                    
                    [defaults setObject:SYGData1 forKey:@"SYGData"];
                    [defaults synchronize];
                }else{
                    alertV.message = result[@"result"][@"msg"];
                    [alertV show];
                }
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];

        }else{
        [params setObject:titleTextField.text forKey:@"user_name"];
        [params setObject:SYGData[@"id"] forKey:@"id"];
        [params setObject:SYGData[@"type"] forKey:@"type"];

        [DataSeviece requestUrl:edit_userhtml params:params success:^(id result) {
            NSLog(@"%@",result);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                alertV.message = @"修改成功";
                [alertV show];

                [SYGData1 setValue:titleTextField.text forKey:@"user_name"];
                
                [defaults setObject:SYGData1 forKey:@"SYGData"];
                [defaults synchronize];
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        }
    }else if (textField == xxTextield ){
        
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        [params setObject:xxTextield.text forKey:@"address"];
        NSMutableDictionary *shopDic = [NSMutableDictionary dictionaryWithDictionary:SYGData1[@"shopinfo"]];
        [DataSeviece requestUrl:edit_shop_infohtml params:params success:^(id result) {
            NSLog(@"%@",result);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                alertV.message = @"修改成功";
                [alertV show];
                [shopDic setValue:xxTextield.text forKey:@"address"];
                [SYGData1 setObject:shopDic forKey:@"shopinfo"];
                [defaults setObject:SYGData1 forKey:@"SYGData"];
                [defaults synchronize];
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];

                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

    }
    
    
    
    return YES;
}

#pragma mark - UIPickerViewDataSource||UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger row = 0;
    switch (component)
    {
        case 0:
            row = [provinceArr count];
            break;
        case 1:
            row = [cityArr count];
            break;
        case 2:
            row = [districtArr count];
            break;
        default:
            break;
    }
    return row;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    id item;
    switch (component)
    {
        case 0:
            item = [provinceArr objectAtIndex:row];
            provinceIndex = row;
            break;
        case 1:
            item = [cityArr objectAtIndex:row];
            cityIndex = row;
            break;
        case 2:
            item = [districtArr objectAtIndex:row];
            districtIndex = row;
            break;
        default:
            break;
    }
    if (item)
    {
        title = [item objectForKey:@"name"];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (0 == component)
    {
        
        cityArr = jsonDataArr[row][@"city"];
        districtArr = jsonDataArr[row][@"city"][0][@"area"];

        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        
        provinceIndex = row;

        allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:row] objectForKey:@"name"], [[cityArr objectAtIndex:0] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];
    }
    if (1 == component)
    {
        cityIndex = row;
        
        cityArr = jsonDataArr[provinceIndex][@"city"];
        districtArr = jsonDataArr[provinceIndex][@"city"][row][@"area"];
        
        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        

        allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:provinceIndex] objectForKey:@"name"], [[cityArr objectAtIndex:row] objectForKey:@"name"], [[districtArr objectAtIndex:0] objectForKey:@"name"]];
    }
    
    if (2 == component) {
        
        districtIndex = row;
        
        allName = [NSString stringWithFormat:@"%@ %@ %@",[[provinceArr objectAtIndex:provinceIndex] objectForKey:@"name"], [[cityArr objectAtIndex:cityIndex] objectForKey:@"name"], [[districtArr objectAtIndex:row] objectForKey:@"name"]];

    }
    
    NSLog(@"%@", allName);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIImage *image = [UIImage imageNamed:@"bg_clear"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];

}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)SYGDataAction{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    SYGData  = [defaults objectForKey:@"SYGData"];
    
    
    phoneLabel.text = SYGData[@"mobile"];

    emailLabel.text = SYGData[@"email"];

}


@end
