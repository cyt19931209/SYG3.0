//
//  JMJLView.h
//  奢易购3.0
//
//  Created by guest on 16/9/1.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMJLView : UIView

typedef  void(^BackBlock)();

@property (nonatomic,copy) BackBlock backBlock;

@property (nonatomic,strong) NSDictionary *dic;

@property (nonatomic,strong) UILabel *title;

@property (nonatomic,strong)NSDictionary *HSDic;

@end
