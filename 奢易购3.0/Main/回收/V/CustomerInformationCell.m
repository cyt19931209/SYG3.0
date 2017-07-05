//
//  CustomerInformationCell.m
//  奢易购3.0
//
//  Created by Andy on 16/9/29.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "CustomerInformationCell.h"

@implementation CustomerInformationCell


- (void)setDic:(NSDictionary *)dic{
    
    _dic = dic;
    
    _nameLabel.text = _dic[@"name"];
    _phoneLabel.text = _dic[@"mobile"];
    
    _weixinLabel.text =  _dic[@"wechat"];
    
}

@end
