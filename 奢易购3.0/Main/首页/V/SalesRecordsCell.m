//
//  SalesRecordsCell.m
//  奢易购3.0
//
//  Created by guest on 16/7/21.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SalesRecordsCell.h"

@implementation SalesRecordsCell


- (void)setDic:(NSDictionary *)dic{

    _dic = dic;
    
    NSLog(@"%@",_dic);
    
    _nameLabel.text = [NSString stringWithFormat:@"%@ x%@",_dic[@"goods_name"],_dic[@"quantity"]] ;
    
//    _numLabel.text = ;
    
    _MJLabel.text = [NSString stringWithFormat:@"%ld",[_dic[@"total_price"] integerValue]];
    
    _LRLabel.text = [NSString stringWithFormat:@"%ld",[_dic[@"total_profit"] integerValue]];

    if ([_dic[@"on_the_way"] isEqualToString:@"1"]) {
        
        _GDImageV.image = [UIImage imageNamed:@"jxz@2x.png"];
        
    }else{
    
        _GDImageV.image = nil;
    }
    
    for (NSDictionary *dic in _arr) {
        if ([dic[@"id"] isEqualToString:_dic[@"category_id"]]) {
            
            _LXImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",dic[@"category_name"]]];
        }
    }
    
    if (!_LXImageV.image) {
        _LXImageV.image = [UIImage imageNamed:@"其他"];
    }

}


@end
