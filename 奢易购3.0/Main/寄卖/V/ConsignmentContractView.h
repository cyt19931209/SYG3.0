//
//  ConsignmentContractView.h
//  奢易购3.0
//
//  Created by guest on 16/8/23.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsignmentContractView : UIView<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>



@property (nonatomic,strong) UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@end
