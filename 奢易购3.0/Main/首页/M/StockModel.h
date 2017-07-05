//
//  StockModel.h
//  奢易购3.0
//
//  Created by guest on 16/8/8.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "BaseModel.h"

@interface StockModel : BaseModel



@property (nonatomic,copy) NSString *goods_name;
@property (nonatomic,copy) NSString *cost;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *add_time;
@property (nonatomic,copy) NSString *category_id;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *SPID;
@property (nonatomic,copy) NSString *consighment_id;
@property (nonatomic,copy) NSString *customer_price;
@property (nonatomic,copy) NSString *price;

@property (nonatomic,copy) NSString *goods_sn;
@property (nonatomic,strong) NSArray *photo_list;

@end
