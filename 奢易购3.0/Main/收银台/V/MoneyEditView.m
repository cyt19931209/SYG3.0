//
//  MoneyEditView.m
//  奢易购3.0
//
//  Created by Andy on 16/9/13.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "MoneyEditView.h"

@implementation MoneyEditView



- (void)awakeFromNib{

    _removeTextField.delegate = self;
    _monetTextField.delegate = self;
    
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction1)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    
    [self addGestureRecognizer:singleRecognizer];


}

//隐藏键盘
- (void)singleAction1{
    
    [_monetTextField resignFirstResponder];
    
    [_removeTextField resignFirstResponder];

}

- (void)setIsSF:(NSString *)isSF{
    _isSF = isSF;
    
    
    if ([isSF isEqualToString:@"SK"]) {
        
        _SKJELabel.text = @"收款金额:";
 
    }else{
    
        _SKJELabel.text = @"付款金额:";

    }

    
    _XBFKButton.hidden = YES;
    _MLButton.hidden = YES;
    _DZButton.hidden = YES;
    
}


- (void)setDic:(NSDictionary *)dic{
    
    _dic = dic;
    isType = @"JM";
    _monetTextField.text = [NSString stringWithFormat:@"%ld",[_dic[@"price"] integerValue] *[_numbel integerValue]];
    _removeTextField.text = [NSString stringWithFormat:@"%@售出收款",_dic[@"goods"][@"goods_sn"]];
    
}

- (void)setHSDic:(NSDictionary *)HSDic{
    _HSDic = HSDic;
    isType = @"HS";
    _monetTextField.text = [NSString stringWithFormat:@"%ld",[_HSDic[@"price"] integerValue]* [_numbel integerValue]];
    _removeTextField.text = [NSString stringWithFormat:@"%@售出收款",_HSDic[@"goods_sn"]];
    
}

- (void)setHSRKDic:(NSDictionary *)HSRKDic{
    _HSRKDic = HSRKDic;
    isType = @"HSRK";
    _SKJELabel.text = @"付款金额:";
    [_XBFKButton setImage:[UIImage imageNamed:@"先不付款初始"] forState:UIControlStateNormal];
    
    _monetTextField.text = [NSString stringWithFormat:@"%ld",[_HSRKDic[@"money"] integerValue]];
    _removeTextField.text = [NSString stringWithFormat:@"%@回收进货款",_HSRKDic[@"goods_sn"]];
    
}

- (void)setHomeDic1:(NSDictionary *)HomeDic1{
    _HomeDic1 = HomeDic1;
    isType = @"Home1";
    _SKJELabel.text = @"待收金额:";
    
    float money = [_HomeDic1[@"total_amount"] floatValue] - [_HomeDic1[@"total_price"]floatValue];
    _monetTextField.text = [NSString stringWithFormat:@"%.0lf",money];
    _removeTextField.text = [NSString stringWithFormat:@"%@待收款",_HomeDic1[@"goods_list"][0][@"goods_sn"]];
}

- (void)setHomeDic3:(NSDictionary *)HomeDic3{
    
    _HomeDic3 = HomeDic3;
    
    isType = @"Home3";
    
    _monetTextField.text = [NSString stringWithFormat:@"%.0lf",[_HomeDic3[@"goods_list"][0][@"customer_price"] floatValue] - [_HomeDic3[@"goods_list"][0][@"customer_price_has_pay"] floatValue]];
    _SKJELabel.text = @"待付金额:";

//    [_XBFKButton setImage:[UIImage imageNamed:@"先不付款初始"] forState:UIControlStateNormal];
    _removeTextField.text = [NSString stringWithFormat:@"%@寄卖结算",_HomeDic3[@"goods_list"][0][@"goods_sn"]];
    
}

- (void)setHomeDic2:(NSDictionary *)HomeDic2{
    _HomeDic2 = HomeDic2;
    isType = @"Home2";
    _SKJELabel.text = @"待收金额:";
//    [_XBFKButton setImage:[UIImage imageNamed:@"先不付款初始"] forState:UIControlStateNormal];
    
    
    _monetTextField.text = [NSString stringWithFormat:@"%ld",[_HomeDic2[@"unpay"] integerValue]];
    _removeTextField.text = [NSString stringWithFormat:@"%@回收款",_HomeDic2[@"goods_sn"]];
    
    
}

- (void)setJMJSDic:(NSDictionary *)JMJSDic{
    
    _JMJSDic = JMJSDic;
    isType = @"JMJS";
    _SKJELabel.text = @"付款金额:";

    [_XBFKButton setImage:[UIImage imageNamed:@"先不付款初始"] forState:UIControlStateNormal];
    
    
    NSLog(@"%@",JMJSDic);
    
    float money = [JMJSDic[@"commission_total"] floatValue];
    
    for (NSDictionary *dic in JMJSDic[@"paylog"]) {
        
        float money1 = [dic[@"amount"] floatValue];
        
        money  = money - money1;
    }
    _monetTextField.text = [NSString stringWithFormat:@"%.0lf",money];
    _removeTextField.text = [NSString stringWithFormat:@"%@结算款",_JMJSDic[@"goods"][@"goods_sn"]];
    
}


//计算机按钮
- (IBAction)JSQAction:(id)sender {
    
    [showView removeFromSuperview];
    [key removeFromSuperview];
    
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    _bgView.alpha = .4;
    _bgView.hidden = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    
    
    
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    [_bgView addGestureRecognizer:singleRecognizer];
    //计算器
    showView=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,200)];
    showView.backgroundColor=[UIColor darkGrayColor];
    showView.userInteractionEnabled = YES;
    showView.tag=1;//设置tag，方便后面对他操作
    [showView setTextAlignment:NSTextAlignmentRight];
    [showView setFont:[UIFont systemFontOfSize:40]];
    [[UIApplication sharedApplication].keyWindow addSubview:showView];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(11, showView.height-40, 50, 30);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:backButton];
    
    //创建了一个自定义视图，显示键盘，并且按键监控
    key=[[Keyboard alloc]initWithFrame:CGRectMake(0, 264, kScreenWidth, kScreenHeight-200-64)];
    [[UIApplication sharedApplication].keyWindow addSubview:key];
    showView .text =[NSString stringWithFormat:@"%@",key.result];//设置显示的结果
}

- (void)backButtonAction{
    
    [showView removeFromSuperview];
    [key removeFromSuperview];
    _bgView.hidden = YES;
    showView.hidden = YES;
    key.hidden = YES;
}

//确定按钮
- (IBAction)tureAction:(id)sender {
    

    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    if ([_monetTextField.text isEqualToString:@""]) {
        alertV.message = @"金额不能为空";
        [alertV show];
        return;
    }
    
    if ([_removeTextField.text isEqualToString:@""]) {
        alertV.message = @"备注不能为空";
        [alertV show];
        return;
    }
    
    
    NSDictionary *dic = @{@"money":_monetTextField.text,@"remark":_removeTextField.text};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MoneyBZNotification" object:dic];
}

//先不付款
- (IBAction)XBFKAction:(id)sender {
    
    
    self.hidden = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
    
    if ([isType isEqualToString:@"JM"]) {
        
        [params setObject:_monetTextField.text forKey:@"total_price"];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        [params setObject:_KHId forKey:@"customer_id"];
        
        NSDictionary *goods_list = @{@"1":@{@"goods_id":_dic[@"goods"][@"goods_id"],@"number":_numbel,@"price":_dic[@"price"]}};
        
        [params setObject:goods_list forKey:@"goods_list"];
        
        [params setObject:@"1" forKey:@"is_pause"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        [payment setObject:@{@"account_id":@"1",@"amount":@"0"} forKey:@"1"];
        
        [params setObject:payment forKey:@"payment"];
        [params setObject:_removeTextField.text forKey:@"remark"];

        [DataSeviece requestUrl:add_saleshtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            _bgView.hidden = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HideViewAction" object:nil];
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }else if ([isType isEqualToString:@"HS"]){
        
        [params setObject:_monetTextField.text forKey:@"total_price"];
        
        [params setObject:_KHId forKey:@"customer_id"];
        
        NSDictionary *goods_list = @{@"1":@{@"goods_id":_HSDic[@"id"],@"number":_numbel,@"price":_monetTextField.text}};
        
        [params setObject:goods_list forKey:@"goods_list"];
        
        [params setObject:@"1" forKey:@"is_pause"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        [payment setObject:@{@"account_id":@"1",@"amount":@"0"} forKey:@"1"];
        
        [params setObject:payment forKey:@"payment"];
        
        [params setObject:_removeTextField.text forKey:@"remark"];

        [DataSeviece requestUrl:add_saleshtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            _bgView.hidden = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HideViewAction" object:nil];
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if ([isType isEqualToString:@"HSRK"]){
        
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:_HSRKDic];
        [params1 setObject:_monetTextField.text forKey:@"total_price"];
        
        [params1 setObject:@"1" forKey:@"is_pause"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        [payment setObject:@{@"account_id":@"1",@"amount":@"0"} forKey:@"1"];
        
        [params1 setObject:payment forKey:@"payment"];
        
        [params1 setObject:_removeTextField.text forKey:@"pay_remark"];

        [DataSeviece requestUrl:add_goodshtml params:params1 success:^(id result) {
            NSLog(@"%@",result);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                _bgView.hidden = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"HideViewAction" object:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
                
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if ([isType isEqualToString:@"Home1"]){
        
        
        [params setObject:@"1" forKey:@"is_pause"];
        [params setObject:_monetTextField.text forKey:@"total_price"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        [payment setObject:@{@"account_id":@"1",@"amount":@"0"} forKey:@"1"];
        
        [params setObject:payment forKey:@"payment"];
        
        [params setObject:_HomeDic1[@"goods_list"][0][@"sales_id"] forKey:@"sales_id"];
        
        [params setObject:_removeTextField.text forKey:@"remark"];

        [DataSeviece requestUrl:continutehtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"errmsg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationHomeBack" object:nil];
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
        
    }else if ([isType isEqualToString:@"Home3"]){
        
        
        [params setObject:@"1" forKey:@"is_pause"];
        [params setObject:_monetTextField.text forKey:@"customer_price"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        [payment setObject:@{@"account_id":@"1",@"amount":@"0"} forKey:@"1"];
        [params setObject:payment forKey:@"payment"];
        [params setObject:_HomeDic3[@"goods_list"][0][@"id"] forKey:@"sales_goods_id"];
        [params setObject:_removeTextField.text forKey:@"remark"];

        [DataSeviece requestUrl:consighmenthtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"errmsg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationHomeBack" object:nil];
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else if ([isType isEqualToString:@"Home2"]){
        
        _bgView.hidden = YES;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HideViewAction" object:nil];
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:_HomeDic2];
        [params1 setObject:_monetTextField.text forKey:@"total_price"];
        [params1 setObject:@"1" forKey:@"is_pause"];
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        [params1 setObject:_HomeDic2[@"id"] forKey:@"id"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        [payment setObject:@{@"account_id":@"1",@"amount":@"0"} forKey:@"1"];
        [params1 setObject:payment forKey:@"payment"];
        [params1 setObject:@"1" forKey:@"is_pause"];
        [params1 setObject:_removeTextField.text forKey:@"remark"];

        [DataSeviece requestUrl:edit_goodshtm params:params1 success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationHomeBack" object:nil];
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else if ([isType isEqualToString:@"JMJS"]){
        
        NSLog(@"%@",_JMJSDic);
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
        [params1 setObject:_monetTextField.text forKey:@"customer_price"];
        
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params1 setObject:@"1" forKey:@"is_pause"];
        [params1 setObject:_JMJSDic[@"sales_goods_id"] forKey:@"sales_goods_id"];
        [params1 setObject:_monetTextField.text forKey:@"total_price"];
        
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        [payment setObject:@{@"account_id":@"1",@"amount":@"0"} forKey:@"1"];
        
        [params1 setObject:payment forKey:@"payment"];
        
        [params1 setObject:_removeTextField.text forKey:@"remark"];

        [DataSeviece requestUrl:consighmenthtml params:params1 success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierBackNotification" object:nil];
                
            }else{
                alertV.message = result[@"result"][@"errmsg"];
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
        
}
//抹零
- (IBAction)MLAction:(id)sender {
    
    NSInteger money = [_monetTextField.text integerValue];
    
    NSInteger Y = money%100;
    
    money = money - Y;
    
    _monetTextField.text = [NSString stringWithFormat:@"%ld",money];
    

    
}
//打折
- (IBAction)DZAction:(id)sender {
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    _bgView.alpha = .4;
    [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    
    
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    
    [_bgView addGestureRecognizer:singleRecognizer];
    
    _discountV = [[[NSBundle mainBundle] loadNibNamed:@"DiscountView" owner:self options:nil]lastObject];
    _discountV.frame = CGRectMake(10, kScreenHeight - 388, kScreenWidth - 20, 388);
    
    _discountV.price = [_monetTextField.text integerValue];
    _discountV.hidden = NO;
    
    [[UIApplication sharedApplication].keyWindow addSubview:_discountV];

    
}

- (void)singleAction{
    
    if (_discountV.hidden == NO) {
        
        
        showView.hidden = YES;
        key.hidden = YES;
        
        [showView removeFromSuperview];
        [key removeFromSuperview];
        
        _discountV.hidden = YES;
        _bgView.hidden = YES;
        _monetTextField.text = _discountV.moneyLabel.text;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;
}


@end
