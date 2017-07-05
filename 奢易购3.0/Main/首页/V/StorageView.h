//
//  StorageView.h
//  奢易购3.0
//
//  Created by guest on 16/7/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscountView.h"
#import "Keyboard.h"

@interface StorageView : UIView<UITextFieldDelegate>{

    NSString *isType;

    BOOL isJM;
    
    UILabel *showView;
    Keyboard *key;

}

//确定金额和备注
@property (nonatomic,strong) NSDictionary *moneyBZDic;

//寄卖结款
@property (nonatomic,assign) BOOL isJMJK;

@property (nonatomic,copy) NSString *KHName;

@property (nonatomic,strong) UIView *bgView;
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
//先不付款显示
@property (weak, nonatomic) IBOutlet UIButton *XBFK1Button;

//付款金额显示
@property (weak, nonatomic) IBOutlet UILabel *FKJELabel;

@property (nonatomic,strong) UITableView *paymentTableView;

@property (nonatomic,strong) UIScrollView *paymentScrollView;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) DiscountView *discountV;
@property (weak, nonatomic) IBOutlet UITextField *moneTextField;
@property (weak, nonatomic) IBOutlet UITextField *BZTextField;

@property (nonatomic,strong) NSMutableDictionary *indexDic;
@property (nonatomic,strong) NSDictionary *notiDic;

@end
