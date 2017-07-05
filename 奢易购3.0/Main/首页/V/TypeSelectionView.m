//
//  TypeSelectionView.m
//  奢易购3.0
//
//  Created by guest on 16/7/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "TypeSelectionView.h"
#import "RowView.h"

@implementation TypeSelectionView


- (void)awakeFromNib{
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 73, kScreenWidth-20, 1)];
    lineView.backgroundColor = [RGBColor colorWithHexString:@"#999999"];
    [self addSubview:lineView];
    
    typeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 74, kScreenWidth-20, 250)];
    typeScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:typeScrollView];

}

- (void)setDataArr:(NSArray *)dataArr{

    _dataArr = dataArr;
    
    for (UIView *view in typeScrollView.subviews) {
        [view removeFromSuperview];
    }

    for (int i = 0; i<_dataArr.count; i++) {
        
        RowView *rowView = [[RowView alloc]initWithFrame:CGRectMake(0, 44*i, kScreenWidth-20, 44)];
        rowView.index = i;
        rowView.dataDic = _dataArr[i];
        [typeScrollView addSubview:rowView];
    }
    
    typeScrollView.contentSize = CGSizeMake(kScreenWidth-20, 44*(_dataArr.count));
}

- (IBAction)addAction:(id)sender {
    
    
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入商品类型" delegate:self cancelButtonTitle:@"添加" otherButtonTitles:nil, nil];
    
    alertV.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alertV show];

    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    
    UITextField *textField = [alertView textFieldAtIndex:0];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];
    
    [params setObject:textField.text forKey:@"category_name"];
    
    [DataSeviece requestUrl:add_categoryhtml params:params success:^(id result) {
        
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotifacationTypeSelection" object:nil];
            
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];

}


@end
