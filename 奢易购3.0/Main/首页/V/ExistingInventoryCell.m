//
//  ExistingInventoryCell.m
//  奢易购3.0
//
//  Created by Andy on 16/10/9.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ExistingInventoryCell.h"

@implementation ExistingInventoryCell


- (void)setModel:(StockModel *)model{
    _model = model;
    
    _nameLabel.text = _model.goods_name;
    
    _numberLabel.text = [NSString stringWithFormat:@"x%@",_model.number];

    if ([_model.type isEqualToString:@"JM"]) {
        _imageV.image = [UIImage imageNamed:@"jm@2x"];
        _moneyLabel.text = [NSString stringWithFormat:@"￥%ld",[model.customer_price integerValue]];
        
    }else{
        _imageV.image = [UIImage imageNamed:@"hs@2x"];
        _moneyLabel.text = [NSString stringWithFormat:@"￥%ld",[model.price integerValue]];
        
    }
    
    _HHLabel.text = [NSString stringWithFormat:@"货号:%@",_model.goods_sn];
    
}

@end
