//
//  RepertoryPublishCell.m
//  奢易购3.0
//
//  Created by Andy on 2016/10/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "RepertoryPublishCell.h"

@implementation RepertoryPublishCell



- (void)setDic:(NSDictionary *)dic{

    _dic = dic;
    
    if ([_dic[@"img"][@"url"] isEqualToString:@""]) {
        
        _titleImageV.image = [UIImage imageNamed:@"default@2x.png"];
    }else{
        
        [_titleImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]]];

    }
    
    _titleLabel.text = _dic[@"goods_name"];
    _snLabel.text = _dic[@"goods_sn"];
    _priceLabel.text = _dic[@"price"];
    _add_timeLabel.text = _dic[@"add_time"];

}



@end
