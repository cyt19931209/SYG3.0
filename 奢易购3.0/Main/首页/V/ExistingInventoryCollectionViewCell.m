//
//  ExistingInventoryCollectionViewCell.m
//  奢易购3.0
//
//  Created by Andy on 16/10/9.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ExistingInventoryCollectionViewCell.h"

@implementation ExistingInventoryCollectionViewCell

- (void)setModel:(StockModel *)model{
    _model = model;
    
    
    if ([_model.type isEqualToString:@"JM"]) {
        _moneyLabel.text = [NSString stringWithFormat:@"￥%ld",[model.customer_price integerValue]];
        
    }else{
        _moneyLabel.text = [NSString stringWithFormat:@"￥%ld",[model.price integerValue]];
        
    }

    _nameLabel.text = _model.goods_name;
    
    
    if (_model.photo_list.count != 0) {
        
        [_imageV sd_setImageWithURL:[NSURL URLWithString:_model.photo_list[0][@"image_url"]]];
    }else{
        _imageV.image = [UIImage imageNamed:@"TB2zkj1hpXXXXXbXXXXXXXXXXXX_!!2010197355"];
    }

    
}
@end
