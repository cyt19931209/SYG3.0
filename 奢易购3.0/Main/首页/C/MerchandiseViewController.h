//
//  MerchandiseViewController.h
//  奢易购3.0
//
//  Created by guest on 16/7/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchandiseViewController : UITableViewController


@property (nonatomic,copy) NSString *status;

@property (nonatomic,copy) NSString *merchandiseId;
@property (nonatomic,copy) NSString *goodId;
@property (weak, nonatomic) IBOutlet UILabel *SPBHLabel;
@property (weak, nonatomic) IBOutlet UITextField *SPMCTextField;
@property (weak, nonatomic) IBOutlet UITextField *SPLXTextField;
@property (weak, nonatomic) IBOutlet UITextField *QXESTextField;
@property (weak, nonatomic) IBOutlet UITextField *SPSLTextField;
@property (weak, nonatomic) IBOutlet UITextField *SPXXTextField;
@property (weak, nonatomic) IBOutlet UITextField *KHDSJTextField;
@property (weak, nonatomic) IBOutlet UITextField *JMJGTextField;
@property (weak, nonatomic) IBOutlet UITextField *JMSJTextField;
@property (weak, nonatomic) IBOutlet UITextField *KHDHTextField;
@property (weak, nonatomic) IBOutlet UITextView *BZTextView;
@property (weak, nonatomic) IBOutlet UITextField *DKSLTextField;
@property (weak, nonatomic) IBOutlet UITextField *DJTextField;
@property (weak, nonatomic) IBOutlet UITextField *XSSLTextField;
@property (weak, nonatomic) IBOutlet UIButton *KHJSButton;
@property (nonatomic,copy) NSString *isType;
@property (weak, nonatomic) IBOutlet UILabel *BZLabel;

@property (weak, nonatomic) IBOutlet UIButton *GMYHButton;
//收付记录
@property (weak, nonatomic) IBOutlet UIButton *SFJLButton;
//寄卖记录
@property (weak, nonatomic) IBOutlet UIButton *JMJLButton;

@property (nonatomic,assign) BOOL isSearch;

@property (weak, nonatomic) IBOutlet UIButton *upDataButton;
@end
