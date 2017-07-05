//
//  SupplierView.h
//  奢易购3.0
//
//  Created by guest on 16/8/3.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplierView : UIView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{

    UITableView *myTableview;
    
    BOOL isType;
    
    NSInteger page;
    
    NSDictionary *oldDic;
    
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic,copy) NSString *title;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (nonatomic,copy) NSString *idStr;

@property (nonatomic,strong) NSMutableArray *dataArr;


@property (nonatomic,copy) NSString *KHId;

@end
