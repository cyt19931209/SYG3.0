//
//  TypeSelectionView.h
//  奢易购3.0
//
//  Created by guest on 16/7/27.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeSelectionView : UIView<UIAlertViewDelegate>{
    
    UIScrollView *typeScrollView;
}

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (nonatomic,strong) NSArray *dataArr;

@end
