//
//  consignmentModel.h
//  奢易购3.0
//
//  Created by guest on 16/8/16.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "BaseModel.h"

@interface consignmentModel : BaseModel


@property (nonatomic,strong) NSArray *item;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *customer_name;
@property (nonatomic,copy) NSString *mobile;

@end
