//
//  AddCustomerView.h
//  奢易购3.0
//
//  Created by Andy on 16/9/29.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCustomerView : UIView<UITextFieldDelegate>

@property (nonatomic,assign) BOOL isAdd;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *weixinTextField;

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic,strong) NSDictionary *dic;


@property (nonatomic,copy) NSString *KHId;




@end
