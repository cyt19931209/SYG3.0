//
//  StorageViewController.h
//  奢易购3.0
//
//  Created by guest on 16/7/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StorageViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UIButton *DJJJButton;
@property (weak, nonatomic) IBOutlet UIButton *ZJJButton;

@property (weak, nonatomic) IBOutlet UITextField *SPLLLabel;
//扫码
@property (nonatomic,strong)NSDictionary *codeDic;

//置换判断商品
@property (nonatomic,copy) NSString *goods_id;

//编辑
@property (nonatomic,assign) BOOL isEdit;
@property (nonatomic,strong) NSDictionary *editDic;

@property (weak, nonatomic) IBOutlet UILabel *SPBHLabel;

@property (weak, nonatomic) IBOutlet UILabel *QXESLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageV;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;

@property (weak, nonatomic) IBOutlet UILabel *suppleLabel;
@property (weak, nonatomic) IBOutlet UITextField *SPSLLabel;

@property (weak, nonatomic) IBOutlet UITextField *SPMCTextField;
@property (weak, nonatomic) IBOutlet UITextField *DJJJTextField;

@property (weak, nonatomic) IBOutlet UITextField *ZJJTextField;

@property (weak, nonatomic) IBOutlet UITextField *SJTextField;
@property (weak, nonatomic) IBOutlet UITextField *RKSJTextField;
@property (weak, nonatomic) IBOutlet UILabel *BZLabel;

@property (weak, nonatomic) IBOutlet UITextView *BZTextView;

@property (nonatomic,assign) BOOL isJM;

@property (nonatomic,copy) NSString *isType;

@property (nonatomic,strong) NSDictionary *KHDic;
@property (weak, nonatomic) IBOutlet UITextField *DJTextField;
@property (weak, nonatomic) IBOutlet UITextView *friendTextView;

@end
