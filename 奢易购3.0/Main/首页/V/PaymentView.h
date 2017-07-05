//
//  PaymentView.h
//  奢易购3.0
//
//  Created by guest on 16/7/22.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Keyboard.h"

@interface PaymentView : UIView<UITextFieldDelegate>{
    
    NSInteger money;//总价
    UILabel *showView;
    Keyboard *key;

}

//确定金额和备注
@property (nonatomic,strong) NSDictionary *moneyBZDic;



@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UITableView *paymentTableView;

@property (nonatomic,strong) UIScrollView *paymentScrollView;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) NSString *isSF;

@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UITextField *BZTextField;
@property (weak, nonatomic) IBOutlet UILabel *FKLabel;
@property (weak, nonatomic) IBOutlet UIButton *qranButton;

@end
