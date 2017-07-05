//
//  PendingPaymentViewController.m
//  奢易购3.0
//
//  Created by guest on 16/7/28.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "PendingPaymentViewController.h"
//#import "StorageView.h"
#import "StorageViewController.h"
#import "StockPriceViewController.h"
#import "PaymentTwoViewController.h"
#import "TransactionRecordViewController.h"
#import "MerchandiseViewController.h"
#import "StockDetailsViewController.h"
#import "SticksViewController.h"

@interface PendingPaymentViewController (){
    UIView *_bgView;
//    StorageView *storageV;
//    MoneyEditView *monetEditV;

    UILabel *ZFLabel;
    
    UIButton *JSRButton;
}

@property (nonatomic,strong) NSDictionary *JSRDic;

@property (nonatomic,strong) NSDictionary *dataDic;

@end

@implementation PendingPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SupplierBackAction) name:@"SupplierBackNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HideViewAction) name:@"HideViewAction" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushHideViewAction) name:@"PushHideViewAction" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowAction) name:@"ShowNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MoneyBZAction:) name:@"MoneyBZNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backMoneyAction) name:@"BackMoneyNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HomeBackAction) name:@"NotificationHomeBack" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddSticksNotification:) name:@"AddSticksNotification" object:nil];

    
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    if ([_type isEqualToString:@"3"]) {
        
    }else{
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 65, 30);
        [rightBtn setTitle:@"删除挂单" forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = rightButtonItem;

    }
    // 加载数据
    [self loadData];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(kScreenWidth-130, kScreenHeight-50-64, 130, 50);
    [button setBackgroundImage:[UIImage imageNamed:@"导航栏背景.png"] forState:UIControlStateNormal];

    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    if ([_type isEqualToString:@"1"]) {
        [button setTitle:@"继续收款" forState:UIControlStateNormal];
        self.navigationItem.title = @"待收款";

    }else{
        [button setTitle:@"继续付款" forState:UIControlStateNormal];
        self.navigationItem.title = @"待付款";
    }
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-50-64, kScreenWidth - 130, 50)];
    
    footView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:footView];
    
    ZFLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreenWidth - 150, 20)];
    ZFLabel.font = [UIFont systemFontOfSize:15];
    ZFLabel.textColor = [RGBColor colorWithHexString:@"#787fc6"];
    ZFLabel.textAlignment = NSTextAlignmentRight;
    [footView addSubview:ZFLabel];
    
    //遮罩视图
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgView.backgroundColor = [RGBColor colorWithHexString:@"#2d2d2d"];
    _bgView.alpha = .4;
    _bgView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = _bgView.frame;
    [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:bgButton];
    
}
//删除挂单
- (void)deleteAction{

    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    NSLog(@"%@",_dataDic);
    
    NSString *url = @"";

    if ([_type isEqualToString:@"2"]) {
        url = Goodscancel_pausehtml;
        [params setObject:_dataDic[@"id"] forKey:@"goods_id"];

    }else{
        url = Salescancel_pausehtml;
        [params setObject:_dataDic[@"id"] forKey:@"sales_id"];
    }
    
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            alertV.message = result[@"result"][@"msg"];
            [alertV show];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
//点击背景
- (void)bgButtonAction{

    _bgView.hidden = YES;
    
//    monetEditV.hidden = YES;
//    [monetEditV.monetTextField resignFirstResponder];
//    [monetEditV.removeTextField resignFirstResponder];
//    storageV.hidden = YES;
//    
//    storageV = nil;
//    

}
//支付
- (void)buttonAction{

//    _bgView.hidden = NO;
//    storageV.hidden = NO;
//    [monetEditV removeFromSuperview];
    
//    monetEditV = [[[NSBundle mainBundle]loadNibNamed:@"MoneyEditView" owner:self options:nil]lastObject];
//
//    monetEditV.frame = CGRectMake(10, (kScreenHeight-325)/2, kScreenWidth-20, 325);
//
//    if ([_type isEqualToString:@"2"]) {
//        monetEditV.HomeDic2 = _dataDic;
//    }else if ([_type isEqualToString:@"1"]){
//        monetEditV.HomeDic1 = _dataDic;
//    }else if ([_type isEqualToString:@"3"]){
//        monetEditV.HomeDic3 = _dataDic;
//    }
//    
//    
//    [[UIApplication sharedApplication].keyWindow addSubview:monetEditV];
//
    
    PaymentTwoViewController *paymentCollectionVC = [[PaymentTwoViewController alloc]init];
    
    if ([_type isEqualToString:@"2"]) {
        
        paymentCollectionVC.HomeDic2 = _dataDic;
        
    }else if ([_type isEqualToString:@"1"]){
        
        paymentCollectionVC.HomeDic1 = _dataDic;
        
    }else if ([_type isEqualToString:@"3"]){
        paymentCollectionVC.JSRDic = _JSRDic;
        paymentCollectionVC.HomeDic3 = _dataDic;
        
    }
    
    [self.navigationController pushViewController:paymentCollectionVC animated:YES];
    

}


- (void)loadData{
    
    NSLog(@"%@",_arr);

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    [params setObject:_salesId forKey:@"id"];

    
    NSString *url = @"";
    
    if ([_type isEqualToString:@"2"]) {
        url = get_goodshtml;
    }else{
        url = get_saleshtml;
        
    }
    
    [DataSeviece requestUrl:url params:params success:^(id result) {
        NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
        
        
        NSDictionary *dic = [NULLHandle NUllHandle:result[@"result"][@"data"]];
        _dataDic = dic;
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 210)];
        bgView.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:bgView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 25)];
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
        [bgView addSubview:titleLabel];
        
        UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        pushButton.frame = CGRectMake(0, 0, kScreenWidth, 90);
        
        [pushButton addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
        
        [bgView addSubview:pushButton];
        
        [bgView addSubview:pushButton];
        
        if ([_type isEqualToString:@"2"]) {
            
            titleLabel.text = @"待付商品信息";
            NSArray *photoArr = dic[@"photo_list"];
            
            if (photoArr.count != 0) {
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 42, 70, 85)];
                [bgView addSubview:imageV];
                UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right+10, 42, kScreenWidth-100, 21)];
                label.textColor = [RGBColor colorWithHexString:@"#999999"];
                label.font = [UIFont systemFontOfSize:13];
                [bgView addSubview:label];
                
                UILabel *label10 = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right + 10, imageV.bottom - 20, 200, 20)];
                label10.textColor = [RGBColor colorWithHexString:@"#787fc6"];
                label10.font = [UIFont systemFontOfSize:15];
                [bgView addSubview:label10];

                UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth -100, imageV.bottom - 20, 90, 20)];
                
                label11.textColor = [RGBColor colorWithHexString:@"#666666"];
                label11.font = [UIFont systemFontOfSize:13];
                label11.textAlignment = NSTextAlignmentRight;
                
                [bgView addSubview:label11];
                
                label.text = dic[@"goods_name"];
                label10.text = [NSString stringWithFormat:@"单价:%@",dic[@"price"]];
                label11.text = [NSString stringWithFormat:@"x%@",dic[@"recovery_log"][@"number"]];
                [imageV sd_setImageWithURL:[NSURL URLWithString:photoArr[0][@"image_url"]]];

            }else{
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 52, 18, 21)];
            [bgView addSubview:imageV];
            UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right+20, 52, kScreenWidth-150, 21)];
            label.textColor = [RGBColor colorWithHexString:@"#999999"];
            label.font = [UIFont systemFontOfSize:14];
            [bgView addSubview:label];
            
            UILabel *label10 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 120, 52, 100, 21)];
            label10.textColor = [RGBColor colorWithHexString:@"#787fc6"];
            label10.font = [UIFont systemFontOfSize:14];
            label10.textAlignment = NSTextAlignmentRight;
            [bgView addSubview:label10];
            
            NSLog(@"%@",dic);
                
            for (NSDictionary *dic1 in _arr) {
                
                if ([dic1[@"id"] isEqualToString:dic[@"category_id"]]) {
                    
                    imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dic1[@"category_name"]]];
                }
            }
            if (!imageV.image) {
                imageV.image = [UIImage imageNamed:@"其他"];
            }
            
            label.text = dic[@"goods_name"];
            
            label10.text = dic[@"price"];
                
            }
            UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(10, 50+44, kScreenWidth-20, 1)];
            
            if (photoArr.count != 0 ) {
                
                lineV.top = 150;
                pushButton.height = 150;
            }else{
            
                lineV.top = 90;
            }
            lineV.backgroundColor = [RGBColor colorWithHexString:@"#999999"];
            [bgView addSubview:lineV];
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, lineV.bottom+10, kScreenWidth/2-10, 20)];
            label1.textColor = [RGBColor colorWithHexString:@"#787fc6"];
            label1.font = [UIFont systemFontOfSize:14];
            [bgView addSubview:label1];
            
            
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, lineV.bottom+10, kScreenWidth/2-10, 20)];
            label2.textColor = [RGBColor colorWithHexString:@"#787fc6"];
            label2.font = [UIFont systemFontOfSize:14];
            label2.textAlignment = NSTextAlignmentRight;
            [bgView addSubview:label2];
            
            UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, label1.bottom+30, kScreenWidth/3-10, 20)];
            label3.textColor = [RGBColor colorWithHexString:@"#787fc6"];
            label3.font = [UIFont systemFontOfSize:14];
            [bgView addSubview:label3];
            
            
            UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3, label1.bottom+30, kScreenWidth/3, 20)];
            label4.textColor = [RGBColor colorWithHexString:@"#787fc6"];
            label4.font = [UIFont systemFontOfSize:14];
            label4.textAlignment = NSTextAlignmentCenter;
            [bgView addSubview:label4];
            
            UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3*2, label1.bottom+30, kScreenWidth/3-10, 20)];
            label5.textColor = [RGBColor colorWithHexString:@"#787fc6"];
            label5.font = [UIFont systemFontOfSize:14];
            label5.textAlignment = NSTextAlignmentRight;
            [bgView addSubview:label5];
            
            NSLog(@"%@",dic[@"add_time"]);
            
            NSTimeInterval time=[dic[@"add_time"] doubleValue];//因为时差问题要加8小时 == 28800 sec
            NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
            //实例化一个NSDateFormatter对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
            label1.text = currentDateStr;

            
            label2.text = [NSString stringWithFormat:@"向%@付款",dic[@"customer_name"]];
            label3.text = [NSString stringWithFormat:@"总价:%@",dic[@"shouldpay"]];
            label5.text = [NSString stringWithFormat:@"已付:%@",dic[@"haspay"]];
            
            
            bgView.height = label5.bottom+20;

            ZFLabel.text = [NSString stringWithFormat:@"还需支付:%@",dic[@"unpay"]];

        }else{
        
        NSArray * list = dic[@"goods_list"];
        
        for (int i = 0; i < list.count ; i++) {
            NSDictionary *dic1 = list[i];
            
            NSArray *photoArr = dic1[@"photo"];
            
            if (photoArr.count != 0) {
                
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 42, 70, 85)];
                [bgView addSubview:imageV];
                UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right+10, 42, kScreenWidth-100, 21)];
                label.textColor = [RGBColor colorWithHexString:@"#999999"];
                label.font = [UIFont systemFontOfSize:13];
                [bgView addSubview:label];
                
                UILabel *label10 = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right + 10, imageV.bottom - 20, 200, 20)];
                label10.textColor = [RGBColor colorWithHexString:@"#787fc6"];
                label10.font = [UIFont systemFontOfSize:15];
                
                [bgView addSubview:label10];
                
                UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth -100, imageV.bottom - 20, 90, 20)];
                
                label11.textColor = [RGBColor colorWithHexString:@"#666666"];
                label11.font = [UIFont systemFontOfSize:13];
                label11.textAlignment = NSTextAlignmentRight;
                
                [bgView addSubview:label11];
         
                label.text = dic1[@"goods_name"];
                
                label10.text = [NSString stringWithFormat:@"单价:%@",dic1[@"price"]];
                label11.text = [NSString stringWithFormat:@"x%@",dic1[@"quantity"]];
                [imageV sd_setImageWithURL:[NSURL URLWithString:photoArr[0][@"image_url"]]];
                
            }else{

            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, i*44+42, 18, 21)];
            [bgView addSubview:imageV];
            
            UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(imageV.right+20, i*44+42, kScreenWidth-150, 21)];
            label.textColor = [RGBColor colorWithHexString:@"#999999"];
            label.font = [UIFont systemFontOfSize:14];
            [bgView addSubview:label];
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 120, i*44+42, 100, 21)];
            label1.textColor = [RGBColor colorWithHexString:@"#787fc6"];
            label1.font = [UIFont systemFontOfSize:14];
            label1.textAlignment = NSTextAlignmentRight;
            
            [bgView addSubview:label1];

            for (NSDictionary *dic in _arr) {
                if ([dic[@"id"] isEqualToString:dic1[@"category_id"]]) {
                    imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dic[@"category_name"]]];
                }
            }
            if (!imageV.image) {
                imageV.image = [UIImage imageNamed:@"其他"];
            }

            label.text = dic1[@"goods_name"];
            label1.text = dic1[@"price"];
        }
        }
        
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(10, 40+(list.count*44), kScreenWidth-20, 1)];
            NSArray *arr = dic[@"goods_list"][0][@"photo"];
        if (arr.count == 0) {
            
                lineV.top = 90;
            
            }else{
                lineV.top = 150;
                pushButton.height = 150;

            }

        lineV.backgroundColor = [RGBColor colorWithHexString:@"#999999"];
        [bgView addSubview:lineV];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, lineV.bottom+10, kScreenWidth/2-10, 20)];
        label1.textColor = [RGBColor colorWithHexString:@"#787fc6"];
        label1.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:label1];
        
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, lineV.bottom+10, kScreenWidth/2-10, 20)];
        label2.textColor = [RGBColor colorWithHexString:@"#787fc6"];
        label2.font = [UIFont systemFontOfSize:14];
        label2.textAlignment = NSTextAlignmentRight;
        [bgView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, label1.bottom+30, kScreenWidth/3-10, 20)];
        label3.textColor = [RGBColor colorWithHexString:@"#787fc6"];
        label3.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:label3];
        
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3, label1.bottom+30, kScreenWidth/3, 20)];
        label4.textColor = [RGBColor colorWithHexString:@"#787fc6"];
        label4.font = [UIFont systemFontOfSize:14];
        label4.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:label4];
        
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/3*2, label1.bottom+30, kScreenWidth/3-10, 20)];
        label5.textColor = [RGBColor colorWithHexString:@"#787fc6"];
        label5.font = [UIFont systemFontOfSize:14];
        label5.textAlignment = NSTextAlignmentRight;
        [bgView addSubview:label5];
        
            NSTimeInterval time=[dic[@"add_time"] doubleValue];//因为时差问题要加8小时 == 28800 sec
            NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
            //实例化一个NSDateFormatter对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
            label1.text = currentDateStr;
            bgView.height = label5.bottom+20;

            if ([_type isEqualToString:@"1"]) {
                titleLabel.text = @"待收商品信息";

                label2.text = [NSString stringWithFormat:@"向%@收款",dic[@"customer_name"]];

                label3.text = [NSString stringWithFormat:@"总价:%@",dic[@"total_amount"]];
                label5.text = [NSString stringWithFormat:@"已收:%@",dic[@"total_price"]];
                float money = [dic[@"total_amount"] floatValue] - [dic[@"total_price"]floatValue];

                ZFLabel.text = [NSString stringWithFormat:@"还需收款:%.2lf",money];

            }else{
                titleLabel.text = @"待付商品信息";

                label2.text = [NSString stringWithFormat:@"向%@付款",dic[@"goods_list"][0][@"customer_name"]];
                label3.text = [NSString stringWithFormat:@"总价:%@",dic[@"goods_list"][0][@"customer_price"]];
                label5.text = [NSString stringWithFormat:@"已付:%@",dic[@"goods_list"][0][@"customer_price_has_pay"]];
                
                
                ZFLabel.text = [NSString stringWithFormat:@"还需支付:%.2lf",[dic[@"goods_list"][0][@"customer_price"] floatValue] - [dic[@"goods_list"][0][@"customer_price_has_pay"] floatValue]];
                
                JSRButton = [UIButton buttonWithType:UIButtonTypeCustom];
                
                JSRButton.frame = CGRectMake(10, bgView.bottom + 10, kScreenWidth - 20, 34);
                
                [JSRButton setBackgroundImage:[UIImage imageNamed:@"bacg@2x"] forState:UIControlStateNormal];

                [JSRButton addTarget:self action:@selector(JSRButtonAction) forControlEvents:UIControlEventTouchUpInside];
                [JSRButton setTitle:[NSString stringWithFormat:@"结算经手人:%@",SYGData[@"user_name"]] forState:UIControlStateNormal];
                [JSRButton setTitleColor:[RGBColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
                JSRButton.titleLabel.font = [UIFont systemFontOfSize:15];
                
                [self.view addSubview:JSRButton];
                
            }
        
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


- (void)JSRButtonAction{

    SticksViewController *sticksVC = [[SticksViewController alloc]init];
    
    [self.navigationController pushViewController:sticksVC animated:YES];
    

}

//经手人返回通知
- (void)AddSticksNotification:(NSNotification*)noti{
    
    _JSRDic = [noti object];
    
    [JSRButton setTitle:[NSString stringWithFormat:@"结算经手人:%@",_JSRDic[@"user_name"]] forState:UIControlStateNormal];
    
}


- (void)SupplierBackAction{

    _bgView.hidden = YES;
    _bgView = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BooksNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)HomeBackAction{
    
    _bgView.hidden = YES;
    _bgView = nil;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];

}



- (void)HideViewAction{
    
    _bgView.hidden = YES;
//    storageV.hidden = YES;
//    storageV = nil;
    _bgView = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeNotification" object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)PushHideViewAction{
    
    _bgView.hidden = YES;
    
//    storageV.hidden = YES;
    if ([_type isEqualToString:@"1"]) {
        
        
        StorageViewController *storageVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"StorageViewController"];
        storageVC.isType = @"1";
        NSDictionary *dic = @{@"phone":@"",@"name":_dataDic[@"customer_name"],@"id":_dataDic[@"customer_id"]};
        storageVC.KHDic = dic;
        storageVC.isJM = YES;
        storageVC.goods_id = _dataDic[@"goods_list"][0][@"id"];
        
        [self.navigationController pushViewController:storageVC animated:YES];

    }else if ([_type isEqualToString:@"2"]){
    
        StockPriceViewController *stockPrice = [[StockPriceViewController alloc]init];
        
        stockPrice.type = @"1";
        stockPrice.goods_id =  _dataDic[@"id"];
        [self.navigationController pushViewController:stockPrice animated:YES];

    }else if ([_type isEqualToString:@"3"]){
        
        StockPriceViewController *stockPrice = [[StockPriceViewController alloc]init];
        stockPrice.type = @"1";
        stockPrice.goods_id = _dataDic[@"goods_list"][0][@"id"];
        [self.navigationController pushViewController:stockPrice animated:YES];
        
    }
    
}


- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//左边返回按钮
- (void)leftBtnAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackNotification" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _bgView.hidden = YES;
}

//跳转
- (void)pushAction{

    if ([_type isEqualToString:@"1"]) {
        
        TransactionRecordViewController *transactionRecordVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"TransactionRecordViewController"];
        transactionRecordVC.sales_id = _dataDic[@"id"];
        transactionRecordVC.arr = _arr;
        [self.navigationController pushViewController:transactionRecordVC animated:YES];

    }else if ([_type isEqualToString:@"2"]){
        
        StockDetailsViewController *stockDetailVC = [[UIStoryboard storyboardWithName:@"Share" bundle:nil] instantiateViewControllerWithIdentifier:@"StockDetailsViewController"];
        stockDetailVC.isType = @"1";
        stockDetailVC.SPID = _dataDic[@"id"];
        [self.navigationController pushViewController:stockDetailVC animated:YES];
        
    }else if ([_type isEqualToString:@"3"]){
    
        MerchandiseViewController *merchandiseVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"MerchandiseViewController"];
        merchandiseVC.status = @"2";
        merchandiseVC.merchandiseId = _dataDic[@"goods_list"][0][@"consighment_pay_id"];
        [self.navigationController pushViewController:merchandiseVC animated:YES];

    }
}


@end
