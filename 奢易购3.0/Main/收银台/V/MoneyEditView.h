//
//  MoneyEditView.h
//  奢易购3.0
//
//  Created by Andy on 16/9/13.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Keyboard.h"
#import "DiscountView.h"

@interface MoneyEditView : UIView<UITextFieldDelegate>{

    //标示
    NSString *isType;
    
    UILabel *showView;
    Keyboard *key;

}

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) DiscountView *discountV;


//出售数量
@property (nonatomic,copy) NSString *numbel;
//客户ID
@property (nonatomic,copy) NSString *KHId;

//收银台判断
@property (nonatomic,copy) NSString *isSF;

@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,strong) NSDictionary *HSDic;
@property (nonatomic,strong) NSDictionary *HSRKDic;
@property (nonatomic,strong) NSDictionary *HomeDic1;
@property (nonatomic,strong) NSDictionary *HomeDic2;
@property (nonatomic,strong) NSDictionary *HomeDic3;
@property (nonatomic,strong) NSDictionary *JMJSDic;

@property (weak, nonatomic) IBOutlet UITextField *monetTextField;
@property (weak, nonatomic) IBOutlet UITextField *removeTextField;
@property (weak, nonatomic) IBOutlet UILabel *SKJELabel;
@property (weak, nonatomic) IBOutlet UIButton *XBFKButton;
@property (weak, nonatomic) IBOutlet UIButton *MLButton;
@property (weak, nonatomic) IBOutlet UIButton *DZButton;

@end
