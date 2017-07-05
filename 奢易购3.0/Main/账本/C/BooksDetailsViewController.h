//
//  BooksDetailsViewController.h
//  奢易购3.0
//
//  Created by Andy on 16/9/19.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksDetailsViewController : UIViewController


@property (nonatomic,copy) NSString *booksId;

@property (weak, nonatomic) IBOutlet UILabel *SPMLabel;
@property (weak, nonatomic) IBOutlet UILabel *SPSLLabel;
@property (weak, nonatomic) IBOutlet UILabel *JELabel;
@property (weak, nonatomic) IBOutlet UILabel *DFXMLabel;
@property (weak, nonatomic) IBOutlet UILabel *FKZHLabel;
@property (weak, nonatomic) IBOutlet UILabel *FKJSRLabel;
@property (weak, nonatomic) IBOutlet UILabel *FKSJLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end
