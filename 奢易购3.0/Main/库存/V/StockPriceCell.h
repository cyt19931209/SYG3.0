//
//  StockPriceCell.h
//  奢易购3.0
//
//  Created by guest on 16/8/29.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockModel.h"


@interface StockPriceCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *categoryImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageV;

@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) StockModel *model;


@end
