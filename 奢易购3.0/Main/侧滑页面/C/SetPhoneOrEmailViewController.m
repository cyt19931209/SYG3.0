//
//  SetPhoneOrEmailViewController.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/19.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SetPhoneOrEmailViewController.h"

@interface SetPhoneOrEmailViewController ()<UITableViewDataSource,UITableViewDelegate>{

    NSInteger number;
    
}


@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation SetPhoneOrEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (_isEmail) {
        self.navigationItem.title = @"邮箱设置";
    }else{
        self.navigationItem.title = @"手机设置";
    }
    number = 60;
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    [self.view addSubview:_myTableView];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    
    UIButton *QDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QDButton.frame = CGRectMake(kScreenWidth/2 - 140, 30, 280, 50);
    QDButton.backgroundColor = [RGBColor colorWithHexString:@"#787fc6"];
    [QDButton setTitle:@"确定" forState:UIControlStateNormal];
    
    QDButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [QDButton addTarget:self action:@selector(QDAction) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:QDButton];
    
    _myTableView.tableFooterView = footView;
    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    
    [self.view addGestureRecognizer:singleRecognizer];
    
}

- (void)singleAction{

    for (int i = 0; i < 2; i++) {
        UITextField *textField = [self.view viewWithTag:200+i];
        
        [textField resignFirstResponder];
        
    }

}

//确定
- (void)QDAction{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *SYGData1  = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:@"SYGData"]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [params setObject:SYGData1[@"id"] forKey:@"uid"];

    UITextField *textField = [self.view viewWithTag:200];
    UITextField *codetextfield = [self.view viewWithTag:201];
    
    if (_isEmail) {
        
        [params setObject:textField.text forKey:@"email"];
        
    }else{
        
        [params setObject:textField.text forKey:@"mobile"];

    }
    [params setObject:codetextfield.text forKey:@"code"];
    
    [DataSeviece requestUrl:change_accounthtml params:params success:^(id result) {
        NSLog(@"%@",result);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            alertV.message = @"修改成功";
            [alertV show];
            
            if (_isEmail) {
                [SYGData1 setValue:textField.text forKey:@"email"];

            }else{
            
                [SYGData1 setValue:textField.text forKey:@"mobile"];

            }
            NSLog(@"%@",SYGData1);
            
            [defaults setObject:SYGData1 forKey:@"SYGData"];
            
            [defaults synchronize];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SYGDataAction" object:nil];
        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    

}

- (void)leftBtnAction{

    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetPhoneCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SetPhoneCell"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 55, 44)];
        label.tag = indexPath.row+100;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [RGBColor colorWithHexString:@"#666666"];
        [cell.contentView addSubview:label];
        

        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(65, 0, 200, 44)];
        
        textField.tag = indexPath.row+200;
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = [RGBColor colorWithHexString:@"#666666"];
        [cell.contentView addSubview:textField];
        
        
        UIButton *codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        codeButton.frame = CGRectMake(kScreenWidth-88, 5, 78, 34);
        
        [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [codeButton setTitleColor:[RGBColor colorWithHexString:@"#787fc6"] forState:UIControlStateNormal];
        codeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [codeButton addTarget:self action:@selector(codeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        codeButton.layer.cornerRadius = 5;
        codeButton.layer.masksToBounds = YES;
        codeButton.layer.borderWidth = 1;
        codeButton.layer.borderColor = [RGBColor colorWithHexString:@"#787fc6"].CGColor;
        codeButton.tag = indexPath.row + 300;
        
        [cell.contentView addSubview:codeButton];

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *label = [cell.contentView viewWithTag:indexPath.row+100];
    
    UITextField *textField = [cell.contentView viewWithTag:indexPath.row +200];
    
    UIButton *bt = [cell.contentView viewWithTag:indexPath.row +300];
    
    
    if (_isEmail) {
        if (indexPath.row == 0) {
            
            label.text = @"邮箱号:";
            textField.placeholder = @"请输入您的邮箱号";
            bt.hidden = YES;
        }else{
            label.text = @"验证码:";
            textField.placeholder = @"请输入收到的验证码";
            bt.hidden = NO;


        }
 
    }else{
    
        if (indexPath.row == 0) {
            
            label.text = @"手机号:";
            textField.placeholder = @"请输入您的手机号";
            bt.hidden = YES;

        }else{
            
            label.text = @"验证码:";
            textField.placeholder = @"请输入收到的验证码";
            bt.hidden = NO;

            
        }

    }
    
    
    return cell;
}

//获取验证码
- (void)codeButtonAction:(UIButton*)bt{
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    UITextField *phoneTextField = [self.view viewWithTag:200];
    
    UIButton *codeButton = [self.view viewWithTag:301];
    
    if ([phoneTextField.text isEqualToString:@""]) {
        alertV.message = @"账号不能为空";
        [alertV show];
        return;
    }
    
    if (_isEmail) {
        
        if (![self validateEmail:phoneTextField.text]) {
            alertV.message = @"邮箱格式不正确";
            [alertV show];
            return;

        }
    }
    
    [DataSeviece requestUrl:send_codehtml_API params:[@{@"mobile":phoneTextField.text,@"code_type":@"4"} mutableCopy] success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            //            alertV.message = @"发送成功";
            //            [alertV show];
            codeButton.userInteractionEnabled = NO;
            
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
    
    UIButton *codeButton = [self.view viewWithTag:301];

    if (number == 0) {
        codeButton.userInteractionEnabled = YES;
        [timer invalidate];
        timer = nil;
        number = 60;
        
        [codeButton setTitleColor:[RGBColor colorWithHexString:@"#787fc6"] forState:UIControlStateNormal];
        [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }else{
        number--;
        
        [codeButton setTitle:[NSString stringWithFormat:@"%ld秒",number] forState:UIControlStateNormal];
    }
    
}


- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


@end
