//
//  HSJLView.m
//  奢易购3.0
//
//  Created by guest on 16/9/2.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "HSJLView.h"

@implementation HSJLView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame] ) {
        
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 33, kScreenWidth-20, 20)];
        _title.textColor = [RGBColor colorWithHexString:@"#016fba"];
        _title.text = @"回收记录";
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
            label.text = [NSString stringWithFormat:@"商品名称:%@",_dic[@"goods_name"]];
        }else if (i == 1){
            label.text = [NSString stringWithFormat:@"回收数量:%@",_dic[@"number"]];
        }else if (i == 2){
            label.text = [NSString stringWithFormat:@"回收单品成本:%@",_dic[@"cost"]];
        }else if (i == 3){
            label.text = [NSString stringWithFormat:@"商品备注:%@",_remark];
        }
    }
}


- (void)tureAction{
    
    _backBlock();
    
}
@end
