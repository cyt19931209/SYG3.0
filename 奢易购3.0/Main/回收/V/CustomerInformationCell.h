//
//  CustomerInformationCell.h
//  奢易购3.0
//
//  Created by Andy on 16/9/29.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerInformationCell : UITableViewCell


@property (nonatomic,strong) NSDictionary *dic;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weixinLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
