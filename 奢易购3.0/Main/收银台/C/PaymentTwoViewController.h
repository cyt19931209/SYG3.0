//
//  PaymentTwoViewController.h
//  奢易购3.0
//
//  Created by Andy on 16/9/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Keyboard.h"

@interface PaymentTwoViewController : UIViewController{

    NSString *isType;
    BOOL isJM;
    UILabel *showView;
    Keyboard *key;

}


@property (nonatomic,strong) NSDictionary *JSRDic;

//购买客户信息
@property (nonatomic,strong) NSDictionary *KHDic;

@property (nonatomic,copy) NSString *KHName;

@property (nonatomic,copy) NSString *KHId;
//出售数量
@property (nonatomic,copy) NSString *numbel;

@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,strong) NSDictionary *HSDic;
@property (nonatomic,strong) NSDictionary *HSRKDic;
@property (nonatomic,strong) NSDictionary *HomeDic1;
@property (nonatomic,strong) NSDictionary *HomeDic2;
@property (nonatomic,strong) NSDictionary *HomeDic3;

//寄卖结算
@property (nonatomic,strong) NSDictionary *JMJSDic;

@property (nonatomic,strong) NSMutableDictionary *indexDic;
@property (nonatomic,strong) NSDictionary *notiDic;


@property (nonatomic,copy) NSString *isSF;


@end
