//
//  CalculatorView.h
//  奢易购3.0
//
//  Created by guest on 16/7/22.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef  void(^BackBlock)();

@interface CalculatorView : UIView


@property (nonatomic,copy) BackBlock backBlock;

//显示Label
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
//是否清空
@property (nonatomic,assign) BOOL isEmpty;
//旧数字
@property (nonatomic,copy) NSString *oldStr;
//记录算法
@property (nonatomic,copy) NSString *recordStr;

@end

