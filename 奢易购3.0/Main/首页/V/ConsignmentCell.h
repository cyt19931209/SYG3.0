//
//  ConsignmentCell.h
//  奢易购3.0
//
//  Created by guest on 16/7/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsignmentCell : UITableViewCell


@property (nonatomic,strong) NSDictionary *dic;
@property (nonatomic,strong) NSString *dataTime;

@property (nonatomic,strong) NSArray *arr;
@property (weak, nonatomic) IBOutlet UIImageView *imageV1;
@property (weak, nonatomic) IBOutlet UILabel *SPMLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageV2;
@property (weak, nonatomic) IBOutlet UILabel *KHMLabel;
@property (weak, nonatomic) IBOutlet UILabel *KHDSJLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageV3;

@end
