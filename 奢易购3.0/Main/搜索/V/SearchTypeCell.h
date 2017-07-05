//
//  SearchTypeCell.h
//  奢易购3.0
//
//  Created by guest on 16/8/16.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTypeModel.h"

@interface SearchTypeCell : UITableViewCell


@property (nonatomic,strong) SearchTypeModel *model;
@property (nonatomic,copy) NSString *type;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageV1;
@property (weak, nonatomic) IBOutlet UILabel *SPMLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageV2;

@end
