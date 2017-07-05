//
//  ConsignmentContractCell.m
//  奢易购3.0
//
//  Created by guest on 16/8/23.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "ConsignmentContractCell.h"

@implementation ConsignmentContractCell


- (void)setDic:(NSDictionary *)dic{
    _dic = dic;

    _SPMLabel.text = [NSString stringWithFormat:@"名称:%@ x%@",_dic[@"goods_name"],_dic[@"number"]];
    
    _KHDSJLabel.text = [NSString stringWithFormat:@"客户到手价:%@",_dic[@"cost"]];
    
    if ([_dic[@"is_new"] isEqualToString:@"1"]) {
        _isNew.text = @"全新";
    }else{
        _isNew.text = @"二手";
    }
    _cancelButton.tag = 100+_index;
}

- (IBAction)cancelAction:(id)sender {
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertV show];

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        
    }else if (buttonIndex == 1){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotiRemoveCell" object:[NSString stringWithFormat:@"%ld",_index]];
        
    }
    
}

@end
