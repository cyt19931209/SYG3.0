//
//  StorageView.m
//  奢易购3.0
//
//  Created by guest on 16/7/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "StorageView.h"
#import "PayMView.h"
#import "UIView+Controller.h"


@implementation StorageView

- (void)awakeFromNib{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addViewAction) name:@"AddViewNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushHideViewAction) name:@"PushHideViewAction" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowAction:) name:@"ShowNotification" object:nil];
    
    _indexDic = [NSMutableDictionary dictionary];
    
    _BZTextField.userInteractionEnabled = NO;
    _moneTextField.userInteractionEnabled = NO;
    _index = 1;
    
    _paymentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 150, self.width, 264)];
    
    _paymentScrollView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_paymentScrollView];
    
    PayMView *payMView = [[[NSBundle mainBundle] loadNibNamed:@"PayMView" owner:self options:nil]lastObject];
    
    payMView.top = 88*(_index-1)+10;
    payMView.section = _index-1;
    payMView.index = _index;
    payMView.tag = 1000+_index;
    payMView.backgroundColor = [UIColor whiteColor];
    payMView.moneyTextField.delegate = self;
    
    [_paymentScrollView addSubview:payMView];
    

    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction1)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    
    [self addGestureRecognizer:singleRecognizer];

    
}

- (void)setMoneyBZDic:(NSDictionary *)moneyBZDic{
    _moneyBZDic = moneyBZDic;
    

    _moneTextField.text = _moneyBZDic[@"money"];
    
    _BZTextField.text = [NSString stringWithFormat:@"备注:%@",_moneyBZDic[@"remark"]];
}


- (void)setDic:(NSDictionary *)dic{
    
    _dic = dic;
    isType = @"JM";
//    _XBFKButton.hidden = YES;
//    _DZButton.hidden = YES;
//    _MLButton.hidden = YES;
//
//    _moneTextField.text = [NSString stringWithFormat:@"%ld",[_dic[@"price"] integerValue] * [_numbel integerValue]];
//    _BZTextField.text = [NSString stringWithFormat:@"备注:%@售出收款",_dic[@"goods"][@"goods_sn"]];

}

- (void)setHSDic:(NSDictionary *)HSDic{
    _HSDic = HSDic;
    isType = @"HS";
    isJM = YES;
//    _XBFKButton.hidden = YES;
//    _DZButton.hidden = YES;
//    _MLButton.hidden = YES;
//
//    _moneTextField.text = [NSString stringWithFormat:@"%ld",[_HSDic[@"price"] integerValue]* [_numbel integerValue]];
//    _BZTextField.text = [NSString stringWithFormat:@"备注:%@售出收款",_HSDic[@"goods_sn"]];
//    
}

- (void)setHSRKDic:(NSDictionary *)HSRKDic{
    _HSRKDic = HSRKDic;
    isType = @"HSRK";
    _FKJELabel.text = @"付款金额:";
    PayMView *payMView = [_paymentScrollView viewWithTag:1001];
    payMView.isSF = @"FK";
//    [_XBFKButton setImage:[UIImage imageNamed:@"先不付款初始"] forState:UIControlStateNormal];
    [_XBFK1Button setImage:[UIImage imageNamed:@"先不付款"] forState:UIControlStateNormal];
//    _XBFKButton.hidden = YES;
//    _DZButton.hidden = YES;
//    _MLButton.hidden = YES;

//    _moneTextField.text = [NSString stringWithFormat:@"%@",_HSRKDic[@"money"]];
//    _BZTextField.text = [NSString stringWithFormat:@"备注:%@回收进货款",_HSRKDic[@"goods_sn"]];
//    
}

- (void)setHomeDic1:(NSDictionary *)HomeDic1{
    _HomeDic1 = HomeDic1;
    isType = @"Home1";
    isJM = YES;
    _FKJELabel.text = @"待收金额:";

//    float money = [_HomeDic1[@"total_amount"] floatValue] - [_HomeDic1[@"total_price"]floatValue];
//    _moneTextField.text = [NSString stringWithFormat:@"%.2lf",money];
//    _BZTextField.text = [NSString stringWithFormat:@"备注:%@待收款",_HomeDic1[@"goods_list"][0][@"goods_sn"]];
    
//    _XBFKButton.hidden = YES;
//    _DZButton.hidden = YES;
//    _MLButton.hidden = YES;
//    
//    _JELabel.text = [NSString stringWithFormat:@"已收金额:%@",_HomeDic1[@"total_price"]];
//    
//    _KHLabel.text = [NSString stringWithFormat:@"向%@收款",_HomeDic1[@"customer_name"]];
}

- (void)setHomeDic3:(NSDictionary *)HomeDic3{
    
    _HomeDic3 = HomeDic3;
    
    isType = @"Home3";
    
//    _moneTextField.text = [NSString stringWithFormat:@"%.2lf",[_HomeDic3[@"goods_list"][0][@"customer_price"] floatValue] - [_HomeDic3[@"goods_list"][0][@"customer_price_has_pay"] floatValue]];
    _FKJELabel.text = @"待付金额:";
    PayMView *payMView = [_paymentScrollView viewWithTag:1001];
    payMView.isSF = @"FK";
//    [_XBFKButton setImage:[UIImage imageNamed:@"先不付款初始"] forState:UIControlStateNormal];
//    [_XBFK1Button setImage:[UIImage imageNamed:@"先不付款"] forState:UIControlStateNormal];
//    _BZTextField.text = [NSString stringWithFormat:@"备注:%@寄卖结算",_HomeDic3[@"goods_list"][0][@"goods_sn"]];
    
//    _XBFKButton.hidden = YES;
//    _DZButton.hidden = YES;
//    _MLButton.hidden = YES;
//    NSLog(@"%@",HomeDic3);

//    _JELabel.text = [NSString stringWithFormat:@"已付金额:%@",_HomeDic3[@"goods_list"][0][@"customer_price_has_pay"]];
//    _KHLabel.text = [NSString stringWithFormat:@"向%@付款",_HomeDic3[@"customer_name"]];
//
    
    
}

- (void)setHomeDic2:(NSDictionary *)HomeDic2{
    _HomeDic2 = HomeDic2;
    isType = @"Home2";
    _FKJELabel.text = @"待付金额:";
    PayMView *payMView = [_paymentScrollView viewWithTag:1001];
    payMView.isSF = @"FK";
//    [_XBFKButton setImage:[UIImage imageNamed:@"先不付款初始"] forState:UIControlStateNormal];
//    [_XBFK1Button setImage:[UIImage imageNamed:@"先不付款"] forState:UIControlStateNormal];
    

//    _moneTextField.text = [NSString stringWithFormat:@"%@",_HomeDic2[@"unpay"]];
//    _BZTextField.text = [NSString stringWithFormat:@"%@回收款",_HomeDic2[@"goods_sn"]];
//    

//    _XBFKButton.hidden = YES;
//    _DZButton.hidden = YES;
//    _MLButton.hidden = YES;
    
//    _JELabel.text = [NSString stringWithFormat:@"已付金额:%@",_HomeDic2[@"haspay"]];
//    _KHLabel.text = [NSString stringWithFormat:@"向%@付款",_HomeDic2[@"customer_name"]];
//    
//    NSLog(@"%@",HomeDic2);
}

- (void)setJMJSDic:(NSDictionary *)JMJSDic{

    _JMJSDic = JMJSDic;
    isType = @"JMJS";
    _FKJELabel.text = @"付款金额:";
    PayMView *payMView = [_paymentScrollView viewWithTag:1001];
    payMView.isSF = @"FK";
//    [_XBFKButton setImage:[UIImage imageNamed:@"先不付款初始"] forState:UIControlStateNormal];
//    [_XBFK1Button setImage:[UIImage imageNamed:@"先不付款"] forState:UIControlStateNormal];
    
//    _XBFKButton.hidden = YES;
//    _DZButton.hidden = YES;
//    _MLButton.hidden = YES;


    NSLog(@"%@",JMJSDic);
    
    float money = [JMJSDic[@"commission_total"] floatValue];
    
    for (NSDictionary *dic in JMJSDic[@"paylog"]) {
        
        float money1 = [dic[@"amount"] floatValue];
        
        money  = money - money1;
    }
//    _moneTextField.text = [NSString stringWithFormat:@"%.2lf",money];
//    _BZTextField.text = [NSString stringWithFormat:@"备注:%@结算款",_JMJSDic[@"goods"][@"goods_sn"]];

}


//先不付款
- (IBAction)noPaymentAction:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    

    
    if ([isType isEqualToString:@"JM"]) {
            
    [params setObject:_moneTextField.text forKey:@"total_price"];

    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:_KHId forKey:@"customer_id"];
    
    NSDictionary *goods_list = @{@"1":@{@"goods_id":_dic[@"goods"][@"goods_id"],@"number":_numbel,@"price":_dic[@"price"]}};
    
    [params setObject:goods_list forKey:@"goods_list"];
    
    [params setObject:@"1" forKey:@"is_pause"];
    
    NSMutableDictionary *payment = [NSMutableDictionary dictionary];
    
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
    
        [params setObject:payment forKey:@"payment"];
        [params setObject:_moneyBZDic[@"remark"] forKey:@"remark"];

        [DataSeviece requestUrl:add_saleshtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            _bgView.hidden = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HideViewAction" object:nil];
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];


    }else if ([isType isEqualToString:@"HS"]){
        
        [params setObject:_moneTextField.text forKey:@"total_price"];

        [params setObject:_KHId forKey:@"customer_id"];
        
        NSDictionary *goods_list = @{@"1":@{@"goods_id":_HSDic[@"id"],@"number":_numbel,@"price":_moneTextField.text}};
        
        [params setObject:goods_list forKey:@"goods_list"];
        
        [params setObject:@"1" forKey:@"is_pause"];

        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }

        [params setObject:payment forKey:@"payment"];
        
        [params setObject:_moneyBZDic[@"remark"] forKey:@"remark"];


        [DataSeviece requestUrl:add_saleshtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            _bgView.hidden = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HideViewAction" object:nil];
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

    }else if ([isType isEqualToString:@"HSRK"]){
        

        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:_HSRKDic];
        [params1 setObject:_moneTextField.text forKey:@"total_price"];

        [params1 setObject:@"1" forKey:@"is_pause"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params1 setObject:payment forKey:@"payment"];
        [params1 setObject:_moneyBZDic[@"remark"] forKey:@"pay_remark"];


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
        [params setObject:_moneTextField.text forKey:@"total_price"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params setObject:payment forKey:@"payment"];
        
        [params setObject:_HomeDic1[@"goods_list"][0][@"sales_id"] forKey:@"sales_id"];
        [params setObject:_moneyBZDic[@"remark"] forKey:@"remark"];

        
        [DataSeviece requestUrl:continutehtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"errmsg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [self.viewController.navigationController popToRootViewControllerAnimated:YES];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierBackNotification" object:nil];
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
        
    }else if ([isType isEqualToString:@"Home3"]){
        
        
        [params setObject:@"1" forKey:@"is_pause"];
        [params setObject:_moneTextField.text forKey:@"customer_price"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params setObject:payment forKey:@"payment"];
        [params setObject:_HomeDic3[@"goods_list"][0][@"id"] forKey:@"sales_goods_id"];
        [params setObject:_moneyBZDic[@"remark"] forKey:@"remark"];

        [DataSeviece requestUrl:consighmenthtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"errmsg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                [self.viewController.navigationController popToRootViewControllerAnimated:YES];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierBackNotification" object:nil];
                
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
        [params1 setObject:_moneTextField.text forKey:@"total_price"];

        [params1 setObject:@"1" forKey:@"is_pause"];
        
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        [params1 setObject:_HomeDic2[@"id"] forKey:@"id"];
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }

        
        
        [params1 setObject:payment forKey:@"payment"];

        [params1 setObject:_moneTextField.text forKey:@"total_price"];
        [params1 setObject:@"1" forKey:@"is_pause"];
        [params1 setObject:_moneyBZDic[@"remark"] forKey:@"remark"];

        [DataSeviece requestUrl:edit_goodshtm params:params1 success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                [self.viewController.navigationController popToRootViewControllerAnimated:YES];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierBackNotification" object:nil];
                
                
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
        [params1 setObject:_moneTextField.text forKey:@"customer_price"];
        
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params1 setObject:@"1" forKey:@"is_pause"];
        [params1 setObject:_JMJSDic[@"sales_goods_id"] forKey:@"sales_goods_id"];
        [params1 setObject:_moneTextField.text forKey:@"total_price"];

        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params1 setObject:payment forKey:@"payment"];
        [params1 setObject:_moneyBZDic[@"remark"] forKey:@"remark"];

        
        [DataSeviece requestUrl:consighmenthtml params:params1 success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                [self.viewController.navigationController popToRootViewControllerAnimated:YES];
                
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
    
    
}
//打折
- (IBAction)discountACTION:(id)sender {
    
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

    _discountV.price = [_moneTextField.text integerValue];
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
        _moneTextField.text = _discountV.moneyLabel.text;
    }
}

- (void)singleAction1{

    [_moneTextField resignFirstResponder];
    
    [_BZTextField resignFirstResponder];
    
    for (int i = 1; i<=_index; i++) {
    
        PayMView *payMView = [self viewWithTag:1000+i];
        [payMView.moneyTextField resignFirstResponder];
    }
}

- (void)addViewAction{
    
    _index++;
    
    PayMView *payMView = [[[NSBundle mainBundle] loadNibNamed:@"PayMView" owner:self options:nil]lastObject];
    payMView.moneyTextField.delegate = self;
    payMView.top = 88*(_index-1)+10;
    payMView.section = _index-1;
    payMView.index = _index;
    payMView.tag = 1000+_index;
    
    if (_HSRKDic||_HomeDic3||_HomeDic2||_JMJSDic) {
        
        payMView.isSF = @"FK";

        
    }else{
        payMView.isSF = @"SK";
    }
    
    [_paymentScrollView addSubview:payMView];
    
    _paymentScrollView.contentSize = CGSizeMake(self.width, 88*_index);
    
}


- (IBAction)tureAction:(id)sender {
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
    int money = 0;
    
    for (int i = 1; i<_index; i++) {
        
        PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
        money = money + [payMView.moneyTextField.text intValue];
        
    }
    
    if (money != [_moneTextField.text intValue]) {
        
        alertV.message = @"输入的金额不对";
        [alertV show];
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];

    if ([isType isEqualToString:@"JM"]) {
        
    [   params setObject:_KHId forKey:@"customer_id"];

        NSDictionary *goods_list = @{@"1":@{@"goods_id":_dic[@"goods"][@"goods_id"],@"number":_numbel,@"price":_dic[@"price"]}};
    
        [params setObject:goods_list forKey:@"goods_list"];
    
        [params setObject:_moneTextField.text forKey:@"total_price"];
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
    
    
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
     
        [params setObject:payment forKey:@"payment"];
        [params setObject:_moneyBZDic[@"remark"] forKey:@"remark"];

        [DataSeviece requestUrl:add_saleshtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierBackNotification" object:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ConsignmentNotification" object:nil];
                
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];

            }

        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

        
    }else if ([isType isEqualToString:@"HS"]){
    
        [params setObject:_KHId forKey:@"customer_id"];
        
        NSDictionary *goods_list = @{@"1":@{@"goods_id":_HSDic[@"id"],@"number":_numbel,@"price":_moneTextField.text}};
        
        [params setObject:goods_list forKey:@"goods_list"];
        
        [params setObject:_moneTextField.text forKey:@"total_price"];

        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params setObject:_moneyBZDic[@"remark"] forKey:@"remark"];

        [params setObject:payment forKey:@"payment"];
        [DataSeviece requestUrl:add_saleshtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierBackNotification" object:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SalesRecordsNotification" object:nil];

            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    
    }else if ([isType isEqualToString:@"HSRK"]){
    
        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:_HSRKDic];
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        [params1 setObject:_moneTextField.text forKey:@"total_price"];

        [params1 setObject:@"2" forKey:@"is_pause"];
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        [params1 setObject:payment forKey:@"payment"];
        [params1 setObject:_moneyBZDic[@"remark"] forKey:@"pay_remark"];

        [DataSeviece requestUrl:add_goodshtml params:params1 success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
        
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                

                [[NSNotificationCenter defaultCenter] postNotificationName:@"HideViewAction" object:nil];
                
                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
                
            }

        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

    
    }else if ([isType isEqualToString:@"Home1"]){
    
        
        [params setObject:@"2" forKey:@"is_pause"];
        [params setObject:_moneTextField.text forKey:@"total_price"];

        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        
        [params setObject:payment forKey:@"payment"];
        
        [params setObject:_HomeDic1[@"goods_list"][0][@"sales_id"] forKey:@"sales_id"];
        
        [params setObject:_moneyBZDic[@"remark"] forKey:@"remark"];

        [DataSeviece requestUrl:continutehtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"errmsg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierBackNotification" object:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SalesRecordsNotification" object:nil];

                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

        
    
    }else if ([isType isEqualToString:@"Home3"]){
    
        
        [params setObject:@"2" forKey:@"is_pause"];
        [params setObject:_moneTextField.text forKey:@"customer_price"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        
        [params setObject:payment forKey:@"payment"];
        [params setObject:_HomeDic3[@"goods_list"][0][@"id"] forKey:@"sales_goods_id"];
        [params setObject:_moneyBZDic[@"remark"] forKey:@"remark"];

        [DataSeviece requestUrl:consighmenthtml params:params success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"errmsg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierBackNotification" object:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SalesRecordsNotification" object:nil];

                
            }else{
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

    
    }else if ([isType isEqualToString:@"Home2"]){
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:_HomeDic2];
        [params1 setObject:_moneTextField.text forKey:@"total_price"];

        [params1 setObject:@"2" forKey:@"is_pause"];
        
        [params1 setObject:SYGData[@"id"] forKey:@"uid"];
        
        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            
            if ([payMView.account_id isEqualToString:@""]) {
                NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                NSLog(@"%@",dic1);
                
                if (dic1) {
                    
                    [dic setObject:@"2" forKey:@"account_id"];
                    [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    if (dic1[@"id"]) {
                        [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                        [dic setObject:dic1[@"SL"] forKey:@"number"];
                        
                    }else{
                        [dic setObject:dic1 forKey:@"goods"];
                    }
                    
                }else{
                    
                }
            }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                
            }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        

        [params1 setObject:payment forKey:@"payment"];
        [params1 setObject:_moneyBZDic[@"remark"] forKey:@"remark"];

        [params1 setObject:_HomeDic2[@"id"] forKey:@"id"];
        [DataSeviece requestUrl:edit_goodshtm params:params1 success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierBackNotification" object:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SalesRecordsNotification" object:nil];

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
        [params1 setObject:_moneTextField.text forKey:@"customer_price"];

        [params1 setObject:SYGData[@"id"] forKey:@"uid"];

        [params1 setObject:@"2" forKey:@"is_pause"];
        [params1 setObject:_JMJSDic[@"sales_goods_id"] forKey:@"sales_goods_id"];


        NSMutableDictionary *payment = [NSMutableDictionary dictionary];
        
        for (int i = 1; i<_index; i++) {
            
            
            
            PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
            
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];


            if ([payMView.account_id isEqualToString:@""]) {
                    NSDictionary *dic1 = [_indexDic objectForKey:[NSString stringWithFormat:@"%d",i]];
                
                    NSLog(@"%@",dic1);
                    
                    if (dic1) {
                        
                        [dic setObject:@"2" forKey:@"account_id"];
                        [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                        if (dic1[@"id"]) {
                            [dic setObject:dic1[@"id"] forKey:@"goods_id"];
                            [dic setObject:dic1[@"SL"] forKey:@"number"];
                            
                        }else{
                            [dic setObject:dic1 forKey:@"goods"];
                        }
                        
                    }else{
                        
                    }
                }else{
                [dic setObject:payMView.account_id forKey:@"account_id"];
                [dic setObject:payMView.moneyTextField.text forKey:@"amount"];
                    
                }
            [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        [params1 setObject:payment forKey:@"payment"];
        [params1 setObject:_moneyBZDic[@"remark"] forKey:@"remark"];

        [DataSeviece requestUrl:consighmenthtml params:params1 success:^(id result) {
            NSLog(@"%@ %@",result[@"result"],result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierBackNotification" object:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SalesRecordsNotification" object:nil];

                
            }else{
                alertV.message = result[@"result"][@"errmsg"];
                [alertV show];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }

}


- (void)PushHideViewAction{

    self.hidden = YES;

    _bgView.hidden = YES;
}

//- (void)ShowAction:(NSNotification*)noti{
//    self.hidden = NO;
//
//    _bgView.hidden = NO;
//
//    
//    _notiDic = [noti object];
//
//    PayMView *payMView = [_paymentScrollView viewWithTag:1000+_index-1];
//    payMView.moneyTextField.text = _notiDic[@"DJ"];
//    payMView.account_id = @"";
//    payMView.imageV.image = nil;
//    
//    payMView.ZHLabel.text = _notiDic[@"goods_name"];
//
//    [_indexDic setObject:_notiDic forKey:[NSString stringWithFormat:@"%ld",_index-1]];
//    
//}
- (void)textFieldDidEndEditing:(UITextField *)textField{

    for (int i = 1; i<=_index; i++) {
        
        PayMView *payMView = [self viewWithTag:1000+i];
        
        if (textField == payMView.moneyTextField) {
            
            if ([textField.text floatValue] > [_moneTextField.text floatValue]) {
                UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"输入金额太大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
                
                textField.text = @"";
                
            }
        }
    
    }
    
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//返回
- (IBAction)JSQAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackMoneyNotification" object:nil];

}


@end
