//
//  HomeModel.h
//  奢易购3.0
//
//  Created by guest on 16/8/28.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel

@property (nonatomic,copy) NSString *SPID;
@property (nonatomic,copy) NSString *quantity;
@property (nonatomic,copy) NSString *goods_name;
@property (nonatomic,copy) NSString *category_id;
@property (nonatomic,copy) NSString *unpay;
@property (nonatomic,copy) NSString *customer_name;
@property (nonatomic,copy) NSString *sales_id;
@property (nonatomic,copy) NSString *goods_id;


@end
