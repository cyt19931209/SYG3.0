//
//  SalesRecordsModel.h
//  奢易购3.0
//
//  Created by guest on 16/8/9.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "BaseModel.h"

@interface SalesRecordsModel : BaseModel


@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *total_price;
@property (nonatomic,copy) NSString *total_profit;
@property (nonatomic,copy) NSArray *list;
@property (nonatomic,copy) NSString *quantity;

@end
