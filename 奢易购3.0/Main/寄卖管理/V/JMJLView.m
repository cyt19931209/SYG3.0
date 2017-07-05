//
//  JMJLView.m
//  奢易购3.0
//
//  Created by guest on 16/9/1.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "JMJLView.h"

@implementation JMJLView


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame] ) {
        
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 33, kScreenWidth-20, 20)];
        _title.textColor = [RGBColor colorWithHexString:@"#016fba"];
        _title.text = @"寄卖记录";
        _title.textAlignment = NSTextAlignmentCenter;
    
        [self addSubview:_title];
        
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(12, 377, kScreenWidth-45, 44);
        [button setImage:[UIImage imageNamed:@"确定初始.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tureAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    
    return self;
}



- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, i*20+70, kScreenWidth - 30, 20)];
        
        label.textColor = [RGBColor colorWithHexString:@"#999999"];
        
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        
        if (i == 0) {
            label.text = [NSString stringWithFormat:@"商品名称:%@",_dic[@"goods"][@"goods_name"]];
        }else if (i == 1){
            label.text = [NSString stringWithFormat:@"标价:%@",_dic[@"price"]];
        }else if (i == 2){
            label.text = [NSString stringWithFormat:@"数量:%@",_dic[@"goods"][@"number"]];
        }else if (i == 3){
            label.text = [NSString stringWithFormat:@"编号:%@",_dic[@"goods"][@"goods_sn"]];
        }

    }
    

}

- (void)setHSDic:(NSDictionary *)HSDic{
    _HSDic = HSDic;
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, i*20+70, kScreenWidth - 30, 20)];
        
        label.textColor = [RGBColor colorWithHexString:@"#999999"];
        
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        
        if (i == 0) {
            label.text = [NSString stringWithFormat:@"商品名称:%@",_HSDic[@"goods_name"]];
        }else if (i == 1){
            label.text = [NSString stringWithFormat:@"标价:%@",_HSDic[@"price"]];
        }else if (i == 2){
            label.text = [NSString stringWithFormat:@"数量:%@",_HSDic[@"number"]];
        }else if (i == 3){
            label.text = [NSString stringWithFormat:@"编号:%@",_HSDic[@"goods_sn"]];
        }
        
    }


}


- (void)tureAction{

    _backBlock();

}



@end
