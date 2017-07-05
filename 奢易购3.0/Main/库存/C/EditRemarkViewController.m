//
//  EditRemarkViewController.m
//  奢易购3.0
//
//  Created by Andy on 16/9/26.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "EditRemarkViewController.h"
#import "MBProgressHUD.h"


@interface EditRemarkViewController (){

    UITextView *BZTextView;
}

@end

@implementation EditRemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (_text_id) {
        
        self.navigationItem.title = @"自定义编辑";

    }else{
        self.navigationItem.title = @"备注编辑";

    }
    
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
    
    UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 195)];
    
    bgV.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bgV];

    UILabel *BZLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 19, kScreenWidth - 20, 20)];
    if (_text_id) {
        BZLabel.text = [NSString stringWithFormat:@"%@:",_text_title];
    }else{
        BZLabel.text = @"备注:";
    }
    BZLabel.font = [UIFont systemFontOfSize:15];
    BZLabel.textColor = [RGBColor colorWithHexString:@"#666666"];
    
    [bgV addSubview:BZLabel];
    
    
    BZTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 39, kScreenWidth - 70, 150)];
    BZTextView.font = [UIFont systemFontOfSize:15];
    BZTextView.textColor = [RGBColor colorWithHexString:@"#666666"];
    BZTextView.text = _remarktext;
    [bgV addSubview:BZTextView];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    editButton.frame = CGRectMake(kScreenWidth - 57, 170 - 37, 37, 37);
    
    [editButton setImage:[UIImage imageNamed:@"BZbtn@2x"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(remarkAction) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:editButton];
    
    UILabel *editLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 57, 170, 50, 20)];
    
    editLabel.textColor = [RGBColor colorWithHexString:@"#999999"];
    editLabel.text = @"一键复制";
    editLabel.font = [UIFont systemFontOfSize:12];
    [bgV addSubview:editLabel];
    
}


- (void)remarkAction{

    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = BZTextView.text;
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText = @"复制成功";
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"done@2x"]];
    
    [self.view addSubview:hud];
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];

}

//返回
- (void)leftBtnAction{

    [self.navigationController popViewControllerAnimated:YES];
    
}

//保存
- (void)editAction{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:_goods_id forKey:@"id"];
    
    if (_text_id) {
        [params setObject:@{@"1":@{@"attribute_id":_text_id,@"attribute_value":BZTextView.text}} forKey:@"attribute_list"];
    }else{
       [params setObject:BZTextView.text forKey:@"remark"];
    }
    [DataSeviece requestUrl:update_goodshtml params:params success:^(id result) {
        
        NSLog(@"%@ %@",result[@"result"][@"msg"],result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];
            alert.message = @"保存成功";
            [alert show];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RemarkEditAction" object:BZTextView.text];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];
            alert.message = @"保存失败";
            [alert show];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

    
//    if ([_dic[@"type"] isEqualToString:@"HS"]) {
//        
//        [params setObject:_dic[@"goods_sn"] forKey:@"goods_sn"];
//        [params setObject:_dic[@"id"] forKey:@"id"];
//        [params setObject:_dic[@"is_pause"] forKey:@"is_pause"];
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
//        [params setObject:BZTextView.text forKey:@"remark"];
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
//                    str1 = [str substringFromIndex:23];
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
//        [params setObject:_dic[@"goods"][@"goods_id"] forKey:@"id"];
//        [params setObject:_dic[@"goods"][@"category_id"] forKey:@"category_id"];
//        [params setObject:_dic[@"goods"][@"goods_name"] forKey:@"goods_name"];
//        [params setObject:_dic[@"goods"][@"goods_sn"] forKey:@"goods_sn"];
//        [params setObject:_dic[@"customer_price"] forKey:@"cost"];
//        [params setObject:_dic[@"price"]  forKey:@"price"];
//        [params setObject:_dic[@"goods"][@"number"] forKey:@"number"];
//        [params setObject:@"JM" forKey:@"type"];
//        [params setObject:_dic[@"customer_id"] forKey:@"customer_id"];
//        [params setObject:BZTextView.text forKey:@"remark"];
//        [params setObject:_dic[@"goods"][@"is_new"] forKey:@"is_new"];
//        [params setObject:@"2" forKey:@"is_pause"];
//        [params setObject:_dic[@"customer_price"] forKey:@"customer_price"];
//        [params setObject:_dic[@"commission"] forKey:@"commission"];
//
//    }
//    
//    [DataSeviece requestUrl:edit_goodshtm params:params success:^(id result) {
//        
//        NSLog(@"%@ %@",result[@"result"][@"msg"],result);
//        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil ,nil];
//            alert.message = @"保存成功";
//            [alert show];
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"RemarkEditAction" object:BZTextView.text];
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
    
    
    

}


@end
