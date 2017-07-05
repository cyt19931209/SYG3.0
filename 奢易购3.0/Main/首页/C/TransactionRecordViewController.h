//
//  TransactionRecordViewController.h
//  奢易购3.0
//
//  Created by guest on 16/7/21.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionRecordViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UIImageView *LXImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *QXESLabel;
@property (weak, nonatomic) IBOutlet UILabel *XMLabel;
@property (weak, nonatomic) IBOutlet UILabel *MJLabel;
@property (weak, nonatomic) IBOutlet UILabel *JJLabel;
@property (weak, nonatomic) IBOutlet UILabel *LRLabel;
@property (weak, nonatomic) IBOutlet UILabel *JHSJLabel;
@property (weak, nonatomic) IBOutlet UILabel *JSRLabel;
@property (weak, nonatomic) IBOutlet UILabel *MCSJLabel;

@property (weak, nonatomic) IBOutlet UIButton *THButton;
@property (weak, nonatomic) IBOutlet UILabel *ZTLabel;
@property (weak, nonatomic) IBOutlet UILabel *HHLabel;

@property (nonatomic,copy) NSString *sales_id;
@property (nonatomic,strong) NSArray *arr;

@property (weak, nonatomic) IBOutlet UILabel *GHFLabel;
@end
