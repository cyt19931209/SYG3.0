//
//  CalculatorView.m
//  奢易购3.0
//
//  Created by guest on 16/7/22.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "CalculatorView.h"

@implementation CalculatorView


//返回
- (IBAction)backAction:(id)sender {
    
    _backBlock();
    
}
//复制数字
- (IBAction)copyAction:(id)sender {
    
    
}

//计算机
- (IBAction)buttonAction:(UIButton *)sender {
    
    if (sender.tag == 100) {
        if ([_numLabel.text isEqualToString:@"0"]||_isEmpty) {
            _numLabel.text = @"(";
        }
        
        
    }else if (sender.tag == 101){
    
    }else if (sender.tag == 102){
        
    }else if (sender.tag == 103){
        
    }else if (sender.tag == 104){
        
    }else if (sender.tag == 105){
        
    }else if (sender.tag == 106){
        
    }else if (sender.tag == 107){
        
    }else if (sender.tag == 108){
        
    }else if (sender.tag == 109){
        
    }else if (sender.tag == 110){
        
    }else if (sender.tag == 111){
        
    }else if (sender.tag == 112){
        
    }else if (sender.tag == 113){
        
    }else if (sender.tag == 114){
        
    }else if (sender.tag == 115){
        
    }else if (sender.tag == 116){
        
    }else if (sender.tag == 117){
        
    }else if (sender.tag == 118){
        
    }else if (sender.tag == 119){
        
    }else if (sender.tag == 120){
        
    }    
    
}
@end
