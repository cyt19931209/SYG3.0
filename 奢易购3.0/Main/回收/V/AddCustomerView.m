//
//  AddCustomerView.m
//  奢易购3.0
//
//  Created by Andy on 16/9/29.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "AddCustomerView.h"

@implementation AddCustomerView


- (void)awakeFromNib{

    
    //隐藏键盘
    UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleAction)];;
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    singleRecognizer.cancelsTouchesInView = NO;
    
    //给self.view添加一个手势监测；
    
    [self addGestureRecognizer:singleRecognizer];

}

- (void)singleAction{
    
    [_nameTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_weixinTextField resignFirstResponder];

}


- (void)setIsAdd:(BOOL)isAdd{
    _isAdd = isAdd;
    
    if (_isAdd == NO) {
        
        [_addButton setTitle:@"确定" forState:UIControlStateNormal];
    }

    _addButton.layer.cornerRadius = 5;
    _addButton.layer.masksToBounds = YES;
    
    _nameTextField.delegate = self;
    _phoneTextField.delegate = self;
    _weixinTextField.delegate = self;
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;

    _nameTextField.text = _dic[@"name"];
    _phoneTextField.text = _dic[@"mobile"];
    _weixinTextField.text =  _dic[@"wechat"];
    
    
}


- (IBAction)addAction:(id)sender {
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    if ([_nameTextField.text isEqualToString:@""]) {
        alertV.message = @"客户姓名不能为空";
        [alertV show];
        return;
    }
    
    
    if (_isAdd) {
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params setObject:_nameTextField.text forKey:@"name"];
        
        [params setObject:_phoneTextField.text forKey:@"mobile"];
        
        [params setObject:_weixinTextField.text forKey:@"wechat"];
        
        [DataSeviece requestUrl:add_customerhtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {

                NSDictionary *dic = @{@"mobile":_phoneTextField.text,@"name":_nameTextField.text,@"id":result[@"result"][@"data"][@"id"],@"wechat":_weixinTextField.text};
                
                
//                NSMutableArray *oldArr = [NSMutableArray arrayWithArray:[defaults objectForKey:SYGData[@"id"]]];
//                
//                if (oldArr == nil) {
//                    oldArr = [NSMutableArray array];
//                }
//                int index = 6;
//                for (int i = 0; i < oldArr.count; i++) {
//                    NSDictionary *dic1 = oldArr[i];
//                    if ([dic1[@"id"] isEqualToString:dic[@"id"]]) {
//                        index = i;
//                    }
//                }
//
//                if (index != 6) {
//                    [oldArr removeObjectAtIndex:index];
//                    
//                }
//                if (oldArr.count == 5) {
//                    [oldArr removeObjectAtIndex:4];
//                }
//                [oldArr insertObject:dic atIndex:0];
//                [defaults setObject:[oldArr mutableCopy] forKey:SYGData[@"id"]];
//                [defaults synchronize];

                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierTureNotification" object:dic];

            }else{
                
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];

        
    }else{
    
        if ([_KHId isEqualToString:_dic[@"id"]]) {
           
            alertV.message = @"选择客户不能和出售客户相同";
            [alertV show];
            
        }else{
        
        if ([_dic[@"name"] isEqualToString:_nameTextField.text]&&[_dic[@"mobile"] isEqualToString:_phoneTextField.text]&&[_dic[@"wechat"] isEqualToString:_weixinTextField.text]) {
            
            
             NSDictionary *dic = @{@"mobile":_phoneTextField.text,@"name":_nameTextField.text,@"id":_dic[@"id"],@"wechat":_dic[@"wechat"]};

            
            
//            NSMutableArray *oldArr = [NSMutableArray arrayWithArray:[defaults objectForKey:SYGData[@"id"]]];
//            
//            if (oldArr == nil) {
//                oldArr = [NSMutableArray array];
//            }
//            int index = 6;
//            for (int i = 0; i < oldArr.count; i++) {
//                NSDictionary *dic1 = oldArr[i];
//                if ([dic1[@"id"] isEqualToString:_dic[@"id"]]) {
//                    index = i;
//                }
//            }
//            NSLog(@"%@",oldArr);
//            NSLog(@"%d",index);
//            
//            if (index != 6) {
//                [oldArr removeObjectAtIndex:index];
//                
//            }
//            if (oldArr.count == 5) {
//                [oldArr removeObjectAtIndex:4];
//            }
//            [oldArr insertObject:_dic atIndex:0];
//            [defaults setObject:[oldArr mutableCopy] forKey:SYGData[@"id"]];
//            [defaults synchronize];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierTureNotification" object:dic];

        }else{
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params setObject:_nameTextField.text forKey:@"name"];
        
        [params setObject:_phoneTextField.text forKey:@"mobile"];
        
        [params setObject:_weixinTextField.text forKey:@"wechat"];
            
        [params setObject:_dic[@"id"] forKey:@"id"];

        [DataSeviece requestUrl:edit_customerhtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result,result[@"result"][@"msg"]);
            
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                
                NSDictionary *dic = @{@"mobile":_phoneTextField.text,@"name":_nameTextField.text,@"id":_dic[@"id"],@"wechat":_weixinTextField.text};
                
                
//                NSMutableArray *oldArr = [NSMutableArray arrayWithArray:[defaults objectForKey:SYGData[@"id"]]];
//                
//                if (oldArr == nil) {
//                    oldArr = [NSMutableArray array];
//                }
//                int index = 6;
//                for (int i = 0; i < oldArr.count; i++) {
//                    NSDictionary *dic1 = oldArr[i];
//                    if ([dic1[@"id"] isEqualToString:dic[@"id"]]) {
//                        index = i;
//                    }
//                }
//                NSLog(@"%@",oldArr);
//                NSLog(@"%d",index);
//                
//                if (index != 6) {
//                    [oldArr removeObjectAtIndex:index];
//                }
//                if (oldArr.count == 5) {
//                    [oldArr removeObjectAtIndex:4];
//                }
//                
//                NSLog(@"%@",dic);
//                [oldArr insertObject:dic atIndex:0];
//                [defaults setObject:[oldArr mutableCopy] forKey:SYGData[@"id"]];
//                [defaults synchronize];
                
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SupplierTureNotification" object:dic];

                
            }else{
                
                alertV.message = result[@"result"][@"msg"];
                [alertV show];
            }
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
            
        }];

        }
            
        }
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
@end
