//
//  StorageTureView.m
//  奢易购3.0
//
//  Created by guest on 16/8/10.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "StorageTureView.h"
#import "StorageTureCell.h"

@implementation StorageTureView


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.width = kScreenWidth-20;
        self.height = 472;
        
        UITableView *myTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.backgroundColor = [RGBColor colorWithHexString:@"f7f7fb"];
        
        [self addSubview:myTableView];
        
        [myTableView registerNib:[UINib nibWithNibName:@"StorageTureCell" bundle:nil] forCellReuseIdentifier:@"StorageTureCell"];
        
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 250)];
        footView.backgroundColor = [RGBColor colorWithHexString:@"f7f7fb"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"提示框（确定初始）"] forState:UIControlStateNormal];
        button.frame = CGRectMake(10, 63, kScreenWidth-40, 50);
        [footView addSubview:button];
        myTableView.tableFooterView = footView;
        
    }

    return self;
}


#pragma mark - UITableViewDelegate||UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StorageTureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StorageTureCell" forIndexPath:indexPath];
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"StorageTureHeaderView"];
    
    if (!headerView) {
        
        headerView=[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"StorageTureHeaderView"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 60)];
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [RGBColor colorWithHexString:@"787fc6"];
        label.tag = 100;
        label.textAlignment = NSTextAlignmentCenter;
        [headerView.contentView addSubview:label];
        
    }
    UILabel *label = [headerView.contentView viewWithTag:100];
    
    label.text = [NSString stringWithFormat:@"回收客户%ld:",section+1];
    
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}



@end
