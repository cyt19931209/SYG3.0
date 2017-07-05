//
//  ExistingInventoryCollectionViewCell.h
//  奢易购3.0
//
//  Created by Andy on 16/10/9.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockModel.h"


@interface ExistingInventoryCollectionViewCell : UICollectionViewCell


@property (nonatomic,strong) StockModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
