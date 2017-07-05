//
//  SFJLCell.m
//  奢易购3.0
//
//  Created by guest on 16/7/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SFJLCell.h"

@implementation SFJLCell


- (void)setDic:(NSDictionary *)dic{

    _dic = dic;
    
    _SPJJLabel.text = [NSString stringWithFormat:@"金额:%@",_dic[@"amount"]];

    _JSRLabel.text = @"";
    
    _BZLabel.text = [NSString stringWithFormat:@"备注:%@",_dic[@"remark"]];
    
    NSTimeInterval time=[dic[@"add_time"] doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];

    _SJLabel.text = currentDateStr;
    
    if ([_dic[@"type"] isEqualToString:@"1"]) {
        _imageV1.image = [UIImage imageNamed:@"付款1"];
    }else{
        _imageV1.image = [UIImage imageNamed:@"收款1"];

    }
    
    if ([_dic[@"use_name"] isKindOfClass:[NSNull class]]||[_dic[@"use_name"] isEqualToString:@""]) {
        _phoneLabel.text = _dic[@"account"];

    }else{
        _phoneLabel.text = _dic[@"use_name"];

    }
    
    
    if ([_dic[@"account_type"] isEqualToString:@"1"]) {
        _imageV.image = [UIImage imageNamed:@"支付宝"];
    }else if ([_dic[@"account_type"] isEqualToString:@"2"]){
        _imageV.image = [UIImage imageNamed:@"微信支付"];
    }else if([_dic[@"account_type"] isEqualToString:@"3"]){
        _imageV.image = [UIImage imageNamed:@"银行卡"];
    }else{
        _imageV.image = [UIImage imageNamed:@""];
    }
    _JSRLabel.text = [NSString stringWithFormat:@"经手人:%@",_dic[@"operation_user_name"]];
    
}


@end
