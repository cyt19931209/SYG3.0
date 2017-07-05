//
//  SFJLCell.h
//  奢易购3.0
//
//  Created by guest on 16/7/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFJLCell : UITableViewCell


@property (nonatomic,strong) NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UILabel *SPJJLabel;
@property (weak, nonatomic) IBOutlet UILabel *JSRLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *imageV1;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *SJLabel;
@property (weak, nonatomic) IBOutlet UILabel *BZLabel;

@end
