//
//  RepertoryPublishCell.h
//  奢易购3.0
//
//  Created by Andy on 2016/10/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepertoryPublishCell : UITableViewCell




@property (nonatomic,strong) NSDictionary *dic;

@property (weak, nonatomic) IBOutlet UIImageView *titleImageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *snLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *add_timeLabel;

@end
