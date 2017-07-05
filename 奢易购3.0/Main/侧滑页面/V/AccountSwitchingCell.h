//
//  AccountSwitchingCell.h
//  奢易购3.0
//
//  Created by Andy on 2016/10/12.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountSwitchingCell : UITableViewCell



@property (nonatomic,strong) NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
