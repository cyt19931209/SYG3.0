//
//  ConsignmentViewController.h
//  奢易购3.0
//
//  Created by guest on 16/7/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsignmentViewController : UITableViewController


@property (nonatomic,assign)BOOL isEdit;
@property (nonatomic,strong) NSDictionary *editDic;

@property (weak, nonatomic) IBOutlet UILabel *JMDLabel;
@property (weak, nonatomic) IBOutlet UITextField *SPMCTextField;

@property (weak, nonatomic) IBOutlet UILabel *QXESLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageV;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
@property (weak, nonatomic) IBOutlet UITextField *SPSLTextField;
@property (weak, nonatomic) IBOutlet UITextField *JMSJTextField;
@property (weak, nonatomic) IBOutlet UILabel *KHXXLabel;
@property (weak, nonatomic) IBOutlet UITextField *KHDSJTextField;
//@property (weak, nonatomic) IBOutlet UITextField *YJTextField;
@property (weak, nonatomic) IBOutlet UITextField *JMJGTextField;
//@property (weak, nonatomic) IBOutlet UITextField *YJLTextField;
@property (weak, nonatomic) IBOutlet UILabel *BZLabel;
@property (weak, nonatomic) IBOutlet UITextView *BZTextField;

@property (weak, nonatomic) IBOutlet UITableViewCell *KHCell;
@property (weak, nonatomic) IBOutlet UITextField *JMKHLabel;

//继续入库
@property (nonatomic,strong) NSDictionary *KHDic;
//编辑入库
@property (nonatomic,strong) NSDictionary *BJDic;
@property (nonatomic,assign) NSInteger index;

//扫码
@property (nonatomic,strong)NSDictionary *codeDic;




@end
