//
//  PaymentCell.h
//  奢易购3.0
//
//  Created by Andy on 16/9/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgV1;
@property (weak, nonatomic) IBOutlet UIView *bgV2;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UITextField *ZHTextField;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;


@property (nonatomic,strong) NSDictionary *dic;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) NSString *account_id;

@end
