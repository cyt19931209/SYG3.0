//
//  RowView.h
//  奢易购3.0
//
//  Created by guest on 16/8/2.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RowView : UIView<UITextFieldDelegate>



@property (nonatomic,strong) NSDictionary *dataDic;

@property (nonatomic,assign) NSInteger index;

@end
