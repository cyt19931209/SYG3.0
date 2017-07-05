//
//  RowView.m
//  奢易购3.0
//
//  Created by guest on 16/8/2.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "RowView.h"

@implementation RowView




- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.height = 44;
        self.width = kScreenWidth-20;
        self.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, kScreenWidth-20, 1)];
        lineView.backgroundColor = [RGBColor colorWithHexString:@"#999999"];
        [self addSubview:lineView];
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = self.bounds;
        [bt addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bt];
        
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{

    _dataDic = dataDic;
    
    UITextField *label = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2-20, 12, 50, 20)];
    label.textColor = [RGBColor colorWithHexString:@"#333333"];
    label.userInteractionEnabled = NO;
    label.tag = 100+_index;
    label.font = [UIFont systemFontOfSize:16];
    
    [self addSubview:label];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-18-10-20, 12, 18, 21)];
    imageV.tag = 200+_index;
    [self addSubview:imageV];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"删除.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(11, 14, 16, 16);
    button.tag = 300+_index;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];

    label.text = _dataDic[@"category_name"];
    imageV.image = [UIImage imageNamed:_dataDic[@"category_name"]];

    
    if (!imageV.image) {
        imageV.image = [UIImage imageNamed:@"其他"];
    }

    if (![_dataDic[@"shop_id"] isEqualToString:@"0"]) {
        button.hidden = NO;
    }else{
        button.hidden = YES;
    }
}

- (void)selectAction{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectTypeNotification" object:_dataDic];

}

//删除
- (void)buttonAction{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSDictionary *SYGData = [defaults objectForKey:@"SYGData"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:SYGData[@"id"] forKey:@"uid"];

    [params setObject:_dataDic[@"id"] forKey:@"id"];
    
    [DataSeviece requestUrl:delete_categoryhtml params:params success:^(id result) {
        NSLog(@"%@",result);
        if ([result[@"result"][@"code"] isEqualToString:@"1"]) {
            [self removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotifacationTypeSelection" object:nil];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;
}
@end
