//
//  SalesRecordsCell.h
//  奢易购3.0
//
//  Created by guest on 16/7/21.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalesRecordsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *LXImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *MJLabel;
@property (weak, nonatomic) IBOutlet UIImageView *GDImageV;
@property (weak, nonatomic) IBOutlet UILabel *LRLabel;

@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,strong) NSArray *arr;

@end
