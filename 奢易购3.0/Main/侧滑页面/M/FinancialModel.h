//
//  FinancialModel.h
//  奢易购3.0
//
//  Created by guest on 16/8/1.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "BaseModel.h"


@interface FinancialModel : BaseModel


@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *use_name;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *financialId;

@end
