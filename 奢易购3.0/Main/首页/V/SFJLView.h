//
//  SFJLView.h
//  奢易购3.0
//
//  Created by guest on 16/7/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFJLView : UIView<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *sfjlTableView;
    
}

@property (nonatomic,assign) BOOL isXS;

@property (weak, nonatomic) IBOutlet UILabel *SFJLLabel;

typedef  void(^BackBlock)();

@property (nonatomic,copy) BackBlock backBlock;

@property (nonatomic,strong) NSArray *dataArr;

@end
