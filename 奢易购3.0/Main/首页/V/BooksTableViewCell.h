//
//  BooksTableViewCell.h
//  奢易购3.0
//
//  Created by guest on 16/7/21.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end
