//
//  PayMView.h
//  奢易购3.0
//
//  Created by guest on 16/7/22.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef  void(^AddBlock)(NSInteger);


@interface PayMView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{

    UIView *SKFSView;

    UIView *bgView;
    
    NSArray *typeArr;
    
}

//判断是否为直接收银台

@property (nonatomic,assign) BOOL isPayment;
//判断是收款还是付款
@property (nonatomic,copy) NSString *isSF;

//判断第几个
@property (nonatomic,assign) NSInteger section;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,copy) NSString *account_id;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UITextField *ZHLabel;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;


@property (nonatomic,assign) NSInteger index;

//@property (nonatomic,copy) AddBlock addBlock;



@end
