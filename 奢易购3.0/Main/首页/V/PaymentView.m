//
//  PaymentView.m
//  奢易购3.0
//
//  Created by guest on 16/7/22.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "PaymentView.h"
#import "PayMView.h"
#import "CashierViewController.h"
#import "UIView+Controller.h"

@implementation PaymentView


- (void)awakeFromNib{

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addViewAction) name:@"AddViewNotification" object:nil];
    
    _index = 1;
    
    _paymentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 134, self.width, 264)];
    
    _paymentScrollView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_paymentScrollView];
    
    PayMView *payMView = [[[NSBundle mainBundle] loadNibNamed:@"PayMView" owner:self options:nil]lastObject];
    payMView.moneyTextField.delegate = self;
    payMView.isPayment = YES;
    payMView.top = 88*(_index-1)+10;
    payMView.section = _index-1;
    payMView.index = _index;
    payMView.tag = 1000+_index;

    [_paymentScrollView addSubview:payMView];
    
    _moneyTextField.text = @"0";

    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction1)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    
    [self addGestureRecognizer:singleRecognizer];
    
    _moneyTextField.userInteractionEnabled = NO;
    _BZTextField.userInteractionEnabled = NO;
    
}

- (void)setMoneyBZDic:(NSDictionary *)moneyBZDic{
    _moneyBZDic = moneyBZDic;
    
    
    _moneyTextField.text = _moneyBZDic[@"money"];
    
    _BZTextField.text = [NSString stringWithFormat:@"%@",_moneyBZDic[@"remark"]];
}


- (void)singleAction1{
    
    [_moneyTextField resignFirstResponder];
    [_BZTextField resignFirstResponder];
    for (int i = 1; i<=_index; i++) {
        
        PayMView *payMView = [self viewWithTag:1000+i];
        [payMView.moneyTextField resignFirstResponder];
    }
    
}


- (void)setIsSF:(NSString *)isSF{
    _isSF = isSF;
    
    PayMView *payMView = [_paymentScrollView viewWithTag:1001];
    payMView.isSF = _isSF;
    
    if ([_isSF isEqualToString:@"SK"]) {
        
        _FKLabel.text = @"收款金额:";
        [_qranButton setImage:[UIImage imageNamed:@"确认收款.png"] forState:UIControlStateNormal];
    }else{
        _FKLabel.text = @"付款金额:";
        [_qranButton setImage:[UIImage imageNamed:@"确认付款初始.png"] forState:UIControlStateNormal];

    }

}

- (void)addViewAction{

    _index++;

    PayMView *payMView = [[[NSBundle mainBundle] loadNibNamed:@"PayMView" owner:self options:nil]lastObject];
    payMView.moneyTextField.delegate = self;
    payMView.isPayment = YES;
    payMView.top = 88*(_index-1)+10;
    payMView.section = _index-1;
    payMView.index = _index;
    payMView.tag = 1000+_index;
    payMView.isSF = _isSF;

    [_paymentScrollView addSubview:payMView];
    
    _paymentScrollView.contentSize = CGSizeMake(self.width, 88*_index);

    
}

- (IBAction)tureAction:(id)sender {
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    NSMutableDictionary *payment = [NSMutableDictionary dictionary];
    [params setObject:SYGData[@"id"] forKey:@"uid"];

    if ([_isSF isEqualToString:@"SK"]) {
        [params setObject:@"5" forKey:@"type"];
    }else{
        [params setObject:@"4" forKey:@"type"];
    }
    [params setObject:_BZTextField.text forKey:@"remark"];
    NSInteger money2 = 0;
    for (int i = 1; i<_index; i++) {
        
        PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];

        [dic setObject:payMView.account_id forKey:@"account_id"];
        [dic setObject:payMView.moneyTextField.text forKey:@"amount"];

        [payment setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];

        NSInteger money1 = [payMView.moneyTextField.text integerValue];
        
        money2 = money2+money1;

    }
    
    if (money2 != [_moneyTextField.text integerValue]) {
        
        alertV.message = @"金额不对";
        [alertV show];
        return;
    }
    
    if ([_BZTextField.text isEqualToString:@""]) {
        alertV.message = @"备注不能为空";
        [alertV show];
        return;

    }
    
    [params setObject:payment forKey:@"item"];
    
    
    [params setObject:_moneyTextField.text forKey:@"money"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNotification" object:params];
    

}


- (void)textFieldDidEndEditing:(UITextField *)textField{

     money = 0;
    
    for (int i = 1; i<_index; i++) {
        
        PayMView *payMView = [_paymentScrollView viewWithTag:1000+i];
        
        NSInteger money1 = [payMView.moneyTextField.text integerValue];
        
        money = money+money1;
        
    }
    
    _moneyTextField.text = [NSString stringWithFormat:@"%ld",money];
}

//返回
- (IBAction)JSQAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackMoneyNotification" object:nil];

    
}

- (void)singleAction{

    _bgView.hidden = YES;
    showView.hidden = YES;
    key.hidden = YES;

}



@end
