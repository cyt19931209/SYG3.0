//
//  SFJLView.m
//  奢易购3.0
//
//  Created by guest on 16/7/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "SFJLView.h"
#import "SFJLCell.h"

@implementation SFJLView

- (void)awakeFromNib{


    sfjlTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kScreenWidth-20, 300) style:UITableViewStylePlain];

    sfjlTableView.delegate = self;
    sfjlTableView.dataSource = self;
    sfjlTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:sfjlTableView];

    [sfjlTableView registerNib:[UINib nibWithNibName:@"SFJLCell" bundle:nil] forCellReuseIdentifier:@"SFJLCell"];
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    
    if (_isXS) {
     
        NSMutableArray *arr = [NSMutableArray array];
        
        for (NSDictionary *dic in _dataArr) {
            if (![dic[@"type"] isEqualToString:@"1"]) {
                [arr addObject:dic];
            }
        }
        _dataArr  = [arr copy];
    }
    
    [sfjlTableView reloadData];

}

- (IBAction)tureButton:(id)sender {
    
    _backBlock();
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SFJLCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SFJLCell" forIndexPath:indexPath];
    cell.dic = _dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 99;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationSFJLPush" object:_dataArr[indexPath.row][@"id"]];

}

@end
