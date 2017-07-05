//
//  PaymentCell.m
//  奢易购3.0
//
//  Created by Andy on 16/9/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "PaymentCell.h"

@implementation PaymentCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _bgV1.layer.cornerRadius = 5;
    _bgV1.layer.masksToBounds = YES;
    _bgV1.layer.borderWidth = 1;
    _bgV1.layer.borderColor = [RGBColor colorWithHexString:@"#999999"].CGColor;
    
    _bgV2.layer.cornerRadius = 5;
    _bgV2.layer.masksToBounds = YES;
    _bgV2.layer.borderWidth = 1;
    _bgV2.layer.borderColor = [RGBColor colorWithHexString:@"#999999"].CGColor;
    
    _ZHTextField.userInteractionEnabled = NO;
    _moneyTextField.delegate = self;
}

- (void)setDic:(NSDictionary *)dic{

    _dic = dic;
    
    _ZHTextField.text = _dic[@"account"];
    
    _account_id = _dic[@"account_id"];
    
    _moneyTextField.text = _dic[@"amount"];
    
    if ([_dic[@"type"] isEqualToString:@"0"]) {
        _imageV.image = [UIImage imageNamed:@"cash@2x"];
    }else if ([_dic[@"type"] isEqualToString:@"1"]){
        _imageV.image = [UIImage imageNamed:@"zhifubao@2x"];
    }else if ([_dic[@"type"] isEqualToString:@"2"]){
        _imageV.image = [UIImage imageNamed:@"wechat@2x"];
    }else if ([_dic[@"type"] isEqualToString:@"3"]){
        _imageV.image = [UIImage imageNamed:@"card@2x"];
    }else if ([_dic[@"type"] isEqualToString:@"4"]){
        _imageV.image = [UIImage imageNamed:@"pos@2x"];
    }else if ([dic[@"type"] isEqualToString:@"5"]){
        _imageV.image = [UIImage imageNamed:@"zhihuan@2x"];
    }
    

}

- (void)setIndex:(NSInteger)index{

    _index = index;
    _moneyTextField.tag = 1000+_index;

}


//删除按钮
- (IBAction)delegeAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"delegePayment" object:[NSString stringWithFormat:@"%ld",_index]];
    
}
//支付方式
- (IBAction)zffsAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"zffsPayment" object:[NSString stringWithFormat:@"%ld",_index]];

}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    if (kScreenHeight > 568) {
        if (_index != 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"EndEditingTextField" object:nil];
        }
        
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EndEditingTextField" object:nil];

    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EndEditingTextFieldOne" object:nil];

    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    if (kScreenHeight > 568) {
        if (_index != 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginEditingTextField" object:nil];
        }
        
    }else{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginEditingTextField" object:nil];
        
    }


    
    return YES;
}

@end
