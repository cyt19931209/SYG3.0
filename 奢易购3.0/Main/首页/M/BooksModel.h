//
//  BooksModel.h
//  奢易购3.0
//
//  Created by guest on 16/8/15.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "BaseModel.h"

@interface BooksModel : BaseModel


@property (nonatomic,strong) NSArray *item;

@property (nonatomic,copy) NSString *day;
@property (nonatomic,copy) NSString *input;
@property (nonatomic,copy) NSString *out1;
@property (nonatomic,copy) NSString *is_read;

@end
