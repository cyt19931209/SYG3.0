//
//  ConsignmentContractCell.h
//  奢易购3.0
//
//  Created by guest on 16/8/23.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsignmentContractCell : UITableViewCell<UIAlertViewDelegate>


@property (nonatomic,strong) NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UILabel *SPMLabel;
@property (weak, nonatomic) IBOutlet UILabel *KHDSJLabel;
@property (weak, nonatomic) IBOutlet UILabel *isNew;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic,assign) NSInteger index;

@end
