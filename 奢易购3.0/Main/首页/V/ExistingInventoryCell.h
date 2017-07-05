//
//  ExistingInventoryCell.h
//  奢易购3.0
//
//  Created by Andy on 16/10/9.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockModel.h"

@interface ExistingInventoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *HHLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (nonatomic,strong) StockModel *model;

@end
