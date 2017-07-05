//
//  EditSNViewController.m
//  奢易购3.0
//
//  Created by Andy on 16/9/26.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "EditSNViewController.h"


@interface EditSNViewController (){

    UITextField *snTextView;
}

@end

@implementation EditSNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"编号编辑";
    
    
    //左边Item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 10, 19);
    [leftBtn setImage:[UIImage imageNamed:@"返回（20x38）.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.view.backgroundColor = [RGBColor colorWithHexString:@"#f1f2fa"];
    
    //右边Item
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 35, 30);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    snTextView = [[UITextField alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 30)];
    snTextView.backgroundColor = [UIColor whiteColor];
    snTextView.font = [UIFont systemFontOfSize:15];
    snTextView.textColor = [RGBColor colorWithHexString:@"#666666"];
    snTextView.keyboardType = UIKeyboardTypeURL;
    [self.view addSubview:snTextView];
    
    if (_dic) {
        if ([_dic[@"type"] isEqualToString:@"HS"]) {
            snTextView.text = _dic[@"goods_sn"];
        }else{
            snTextView.text = _dic[@"goods"][@"goods_sn"];
        }

    }else{
        snTextView.text = _snStr;

    }
    
}

//返回
- (void)leftBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//保存
- (void)editAction{
    
    

    
    if (_dic) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
        
        [params setObject:SYGData[@"id"] forKey:@"uid"];
        
        [params setObject:_goods_id forKey:@"id"];
        
        [params setObject:snTextView.text forKey:@"goods_sn"];
        
        
        [DataSeviece requestUrl:update_goodshtml params:params success:^(id result) {
            
            NSLog(@"%@ %@",result[@"result"][@"msg"],result);
            if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];
                alert.message = @"保存成功";
                [alert show];
                
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];
                alert.message = @"保存失败";
                [alert show];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];

//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
//    
//    [params setObject:SYGData[@"id"] forKey:@"uid"];
//    
//    
//    if ([_dic[@"type"] isEqualToString:@"HS"]) {
//        
//        
//        [params setObject:snTextView.text forKey:@"goods_sn"];
//        [params setObject:_dic[@"id"] forKey:@"id"];
//        [params setObject:@"2" forKey:@"is_pause"];
//        [params setObject:_dic[@"category_id"] forKey:@"category_id"];
//        [params setObject:_dic[@"id"] forKey:@"id"];
//        [params setObject:_dic[@"customer_id"] forKey:@"customer_id"];
//        
//        [params setObject:_dic[@"goods_name"] forKey:@"goods_name"];
//        
//        [params setObject:_dic[@"cost"] forKey:@"cost"];
//        
//        [params setObject:_dic[@"price"] forKey:@"price"];
//        
//        [params setObject:_dic[@"money"] forKey:@"money"];
//        
//        [params setObject:_dic[@"number"] forKey:@"number"];
//        
//        [params setObject:_dic[@"is_new"] forKey:@"is_new"];
//        
//        [params setObject:@"HS" forKey:@"type"];
//        
//        [params setObject:_dic[@"remark"] forKey:@"remark"];
//        
//        
//        NSArray *photo_listArr = _dic[@"photo_list"];
//        
//        if (photo_listArr.count != 0) {
//            NSString *imageStr = @"";
//            
//            for (NSDictionary *dic in photo_listArr) {
//                
//                imageStr = [NSString stringWithFormat:@"%@,%@",imageStr,dic[@"url"]];
//            }
//            
//            imageStr = [imageStr substringFromIndex:1];
//            
//            NSLog(@"%@",imageStr);
//            [params setObject:imageStr forKey:@"photo"];
//        }else{
//            
//            [params setObject:@"" forKey:@"photo"];
//        }
//        
//        NSMutableDictionary *paymentDic = [NSMutableDictionary dictionary];
//        
//        NSArray *paymentArr = _dic[@"payment"];
//        if (paymentArr) {
//            
//            for (int i = 0; i < paymentArr.count; i++) {
//                
//                [paymentDic setObject:paymentArr[i] forKey:[NSString stringWithFormat:@"%d",i]];
//            }
//        }
//        
//        [params setObject:paymentDic forKey:@"payment"];
//        
//        
//        
//    }else{
//        
//        NSArray *photo_listArr = _dic[@"goods"][@"pic"][@"href"];
//        
//        if (photo_listArr.count != 0) {
//            NSString *imageStr = @"";
//            
//            for (NSString *str in photo_listArr) {
//                NSString  *str1 = @"";
//                
//                if ([BaseUrl isEqualToString:@"http://syg.hpdengshi.com/index.php?s=/Api/"]) {
//                  str1 = [str substringFromIndex:23];
//                    
//                }else{
//                    str1 = [str substringFromIndex:23];
//                }
//                
//                imageStr = [NSString stringWithFormat:@"%@,%@",imageStr,str1];
//            }
//            
//            imageStr = [imageStr substringFromIndex:1];
//            
//            NSLog(@"%@",imageStr);
//            [params setObject:imageStr forKey:@"photo"];
//        }else{
//            
//            [params setObject:@"" forKey:@"photo"];
//        }
//        
//
//        
//        [params setObject:_dic[@"goods"][@"goods_id"] forKey:@"id"];
//        
//        [params setObject:_dic[@"goods"][@"category_id"] forKey:@"category_id"];
//        [params setObject:_dic[@"goods"][@"goods_name"] forKey:@"goods_name"];
//        [params setObject:snTextView.text forKey:@"goods_sn"];
//        [params setObject:_dic[@"customer_price"] forKey:@"cost"];
//        [params setObject:_dic[@"price"]  forKey:@"price"];
//        [params setObject:_dic[@"goods"][@"number"] forKey:@"number"];
//        [params setObject:@"JM" forKey:@"type"];
//        [params setObject:_dic[@"customer_id"] forKey:@"customer_id"];
//        [params setObject:_dic[@"remark"] forKey:@"remark"];
//        [params setObject:_dic[@"goods"][@"is_new"] forKey:@"is_new"];
//        [params setObject:@"2" forKey:@"is_pause"];
//        [params setObject:_dic[@"customer_price"] forKey:@"customer_price"];
//        [params setObject:_dic[@"commission"] forKey:@"commission"];
//        
//    }
//    
//
//        [DataSeviece requestUrl:edit_goodshtm params:params success:^(id result) {
//        
//        NSLog(@"%@ %@",result[@"result"][@"msg"],result);
//        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];
//            alert.message = @"保存成功";
//            [alert show];
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"SNEditAction" object:snTextView.text];
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];
//            alert.message = @"保存失败";
//            [alert show];
//            
//        }
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//
    }else{
            
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SNEditAction" object:snTextView.text];
        [self.navigationController popViewControllerAnimated:YES];

    }
}


@end
