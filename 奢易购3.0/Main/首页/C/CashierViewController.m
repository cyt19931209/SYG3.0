//
//  CashierViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/26.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "CashierViewController.h"

@interface CashierViewController ()

@end

@implementation CashierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收银台";
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 70, 30);
//    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];

    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //右边Item
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 70, 30);
    [rightBtn setTitle:@"确定入账" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 64)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-100, 15)];
    textLabel.text = _dic[@"remark"];
    textLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
    textLabel.font = [UIFont systemFontOfSize:13];
    [whiteView addSubview:textLabel];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, textLabel.bottom+10, kScreenWidth-100, 20)];
    moneyLabel.textColor = [RGBColor colorWithHexString:@"#7c7ac4"];
    moneyLabel.font = [UIFont systemFontOfSize:15];
    if ([_dic[@"type"] isEqualToString:@"4"]) {
        
        moneyLabel.text = [NSString stringWithFormat:@"付款金额：%@",_dic[@"money"]];
        [leftBtn setTitle:@"取消付款" forState:UIControlStateNormal];

    }else{
        moneyLabel.text = [NSString stringWithFormat:@"收款金额：%@",_dic[@"money"]];
        [leftBtn setTitle:@"取消收款" forState:UIControlStateNormal];

    }
    [whiteView addSubview:moneyLabel];
    
}

//返回
- (void)leftBtnAction{

    [self.navigationController popViewControllerAnimated:YES];

}
//确定
- (void)rightBtnAction{
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    
    [DataSeviece requestUrl:add_pay_loghtml params:[_dic mutableCopy] success:^(id result) {
        
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BooksNotification" object:nil];
 
            
        }else{
            
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    

    
    
}


@end
