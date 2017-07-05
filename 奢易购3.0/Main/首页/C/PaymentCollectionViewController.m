//
//  PaymentCollectionViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/21.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "PaymentCollectionViewController.h"
#import "AppDelegate.h"
#import "CalculatorView.h"
#import "PaymentView.h"
#import "Keyboard.h"
#import "CashierViewController.h"

@interface PaymentCollectionViewController (){

    UIView *bgView;
    CalculatorView *calculatorV;
    PaymentView *paymentV;
    UILabel *showView;
    Keyboard *key;
    MoneyEditView *monetEditV;
    NSString *isSF;

}

@end

@implementation PaymentCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotification:) name:@"pushNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MoneyBZAction:) name:@"MoneyBZNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backMoneyAction) name:@"BackMoneyNotification" object:nil];
    self.navigationItem.title = @"收银台";
    
    //改变导航栏标题的字体颜色和大小
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //右边Item
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 25, 26);
//    [rightBtn setImage:[UIImage imageNamed:@"计算器"] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(calculatorAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
//    
    //付款
    UIButton *paymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    paymentButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导航栏背景.png"]];
    paymentButton.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight/2-52);
    [paymentButton addTarget:self action:@selector(paymentButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paymentButton];
 
    UIImageView *paymentImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 106, 91)];
    paymentImageV.center = paymentButton.center;
    paymentImageV.image = [UIImage imageNamed:@"付款.png"];
    [paymentButton addSubview:paymentImageV];
    
    UILabel *paymentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    paymentLabel.text = @"付款";
    paymentLabel.textAlignment = NSTextAlignmentCenter;
    paymentLabel.textColor = [RGBColor colorWithHexString:@"#ffffff"];
    paymentLabel.font = [UIFont systemFontOfSize:35];
    paymentLabel.top = paymentImageV.bottom;
    [paymentButton addSubview:paymentLabel];
    
    
    //收款
    UIButton *receivablesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    receivablesButton.frame = CGRectMake(0, kScreenHeight/2-52, kScreenWidth, kScreenHeight/2-12);
    [receivablesButton addTarget:self action:@selector(receivablesButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:receivablesButton];
    
    UIImageView *receivablesImageV = [[UIImageView alloc]initWithFrame:CGRectMake(receivablesButton.width/2-53, receivablesButton.height/2-60, 106, 91)];
    receivablesImageV.image = [UIImage imageNamed:@"收款.png"];
    [receivablesButton addSubview:receivablesImageV];
    
    UILabel *receivablesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    receivablesLabel.text = @"收款";
    receivablesLabel.textAlignment = NSTextAlignmentCenter;
    receivablesLabel.textColor = [RGBColor colorWithHexString:@"#787fc6"];
    receivablesLabel.font = [UIFont systemFontOfSize:35];
    receivablesLabel.top = receivablesImageV.bottom;
    [receivablesButton addSubview:receivablesLabel];

    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    bgView.alpha = .4;
    bgView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];

    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = bgView.frame;
    [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:bgButton];

    
    //计算器
    
    showView=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth,200)];
    showView.backgroundColor=[UIColor darkGrayColor];
    showView.userInteractionEnabled = YES;
    showView.tag=1;//设置tag，方便后面对他操作
    [showView setTextAlignment:NSTextAlignmentRight];
    [showView setFont:[UIFont systemFontOfSize:40]];
    showView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:showView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(11, showView.height-40, 50, 30);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:backButton];
    
    //创建了一个自定义视图，显示键盘，并且按键监控
    key=[[Keyboard alloc]initWithFrame:CGRectMake(0, 264, kScreenWidth, kScreenHeight-200-64)];
    key.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:key];
    showView .text =[NSString stringWithFormat:@"%@",key.result];//设置显示的结果
    
    
    
//    calculatorV = [[[NSBundle mainBundle]loadNibNamed:@"CalculatorView" owner:self options:nil]firstObject];
//    calculatorV.frame = CGRectMake(0, 0, kScreenWidth, 450);
//    calculatorV.hidden = YES;
//    [self.view addSubview:calculatorV];
//    __weak CalculatorView *weakView = calculatorV;
//    __weak UIView *weakbgView = bgView;
//    
//    calculatorV.backBlock = ^(){
//        
//        weakView.hidden = YES;
//        weakbgView.hidden = YES;
//    };
    
}

//隐藏视图
- (void)bgButtonAction{
    
    monetEditV.hidden = YES;
    bgView.hidden = YES;
    showView.hidden = YES;
    key.hidden = YES;
    paymentV.hidden = YES;

    
}


//关闭计算器
- (void)backButtonAction{
    bgView.hidden = YES;
    showView.hidden = YES;
    key.hidden = YES;
}

//计算器
- (void)calculatorAction{
    
    bgView.hidden = NO;

    showView.hidden = NO;
    key.hidden = NO;
}


//付款
- (void)paymentButtonAction{
    bgView.hidden = NO;
    
    isSF = @"FK";
    
    [monetEditV removeFromSuperview];
    monetEditV = [[[NSBundle mainBundle]loadNibNamed:@"MoneyEditView" owner:self options:nil]lastObject];
    monetEditV.isSF = isSF;
    monetEditV.frame = CGRectMake(10, (kScreenHeight-325)/2, kScreenWidth-20, 325);
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:monetEditV];
    

//    paymentV = [[[NSBundle mainBundle]loadNibNamed:@"PaymentView" owner:self options:nil]lastObject];
//    paymentV.frame = CGRectMake(10, 64, kScreenWidth-20, 550);
//    paymentV.isSF = @"FK";
//
//    [[UIApplication sharedApplication].keyWindow  addSubview:paymentV];
//    
}


//收款
- (void)receivablesButtonAction{
    bgView.hidden = NO;
    isSF = @"SK";
    
    [monetEditV removeFromSuperview];
    monetEditV = [[[NSBundle mainBundle]loadNibNamed:@"MoneyEditView" owner:self options:nil]lastObject];
    
    monetEditV.frame = CGRectMake(10, (kScreenHeight-325)/2, kScreenWidth-20, 325);
    monetEditV.isSF = isSF;

    
    [[UIApplication sharedApplication].keyWindow addSubview:monetEditV];
    

    
//    paymentV = [[[NSBundle mainBundle]loadNibNamed:@"PaymentView" owner:self options:nil]lastObject];
//    paymentV.frame = CGRectMake(10, 64, kScreenWidth-20, 550);
//    paymentV.isSF = @"SK";
//
//    [[UIApplication sharedApplication].keyWindow  addSubview:paymentV];
//    

}

//左边返回按钮
- (void)leftBtnAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];

    [self.navigationController popViewControllerAnimated:YES];

}
//跳转
- (void)pushNotification:(NSNotification*)noti{

    bgView.hidden = YES;
    paymentV.hidden = YES;

    CashierViewController *cashierVC = [[CashierViewController alloc]init];
    cashierVC.dic = [noti object];
    [self.navigationController pushViewController:cashierVC animated:YES];
}


//收银台金额和备注
- (void)MoneyBZAction:(NSNotification*)noti{
    
    monetEditV.hidden = YES;
    paymentV.hidden = NO;
    [paymentV removeFromSuperview];
    
    paymentV = [[[NSBundle mainBundle]loadNibNamed:@"PaymentView" owner:self options:nil]lastObject];
    paymentV.moneyBZDic = [noti object];
    paymentV.frame = CGRectMake(10, 64, kScreenWidth-20, 480);
    paymentV.isSF = isSF;
    
    [[UIApplication sharedApplication].keyWindow  addSubview:paymentV];
    
    
}



- (void)backMoneyAction{
    
    paymentV.hidden = YES;
    monetEditV.hidden = NO;
    
}



- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}



@end
