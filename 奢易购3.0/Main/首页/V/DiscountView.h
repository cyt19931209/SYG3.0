//
//  DiscountView.h
//  奢易购3.0
//
//  Created by guest on 16/7/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountView : UIView


@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (nonatomic,assign) NSInteger price;

@property (nonatomic,assign) BOOL isTure;

@end
