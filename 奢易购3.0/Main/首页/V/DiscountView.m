//
//  DiscountView.m
//  奢易购3.0
//
//  Created by guest on 16/7/25.
//  Copyright © 2016年 cyt. All rights reserved.
//

#import "DiscountView.h"

@implementation DiscountView


- (void)awakeFromNib{
    _discountLabel.text = @"0";

    
    

}


- (void)setPrice:(NSInteger)price{
    _price = price;

    _moneyLabel.text = [NSString stringWithFormat:@"%ld",_price];
}





//0
- (IBAction)ZeroAction:(id)sender {

    if (![_discountLabel.text isEqualToString:@"0"]) {
        _discountLabel.text  = [_discountLabel.text stringByAppendingString:@"0"];
    }else if (_isTure){
        _discountLabel.text = @"0";
        _isTure = NO;
    }
}
//.
- (IBAction)DAction:(id)sender {
    
    _discountLabel.text  = [_discountLabel.text stringByAppendingString:@"."];
    
}
//1
- (IBAction)OneAction:(id)sender {
    if ([_discountLabel.text isEqualToString:@"0"]) {
        _discountLabel.text = @"1";
    }else if (_isTure){
        _discountLabel.text = @"1";
        _isTure = NO;
    }else{
        _discountLabel.text = [_discountLabel.text stringByAppendingString:@"1"];
    }
    
}
//2
- (IBAction)twoAction:(id)sender {
    if ([_discountLabel.text isEqualToString:@"0"]) {
        _discountLabel.text = @"2";
    }else if (_isTure){
        _discountLabel.text = @"2";
        _isTure = NO;
    }else{
        _discountLabel.text = [_discountLabel.text stringByAppendingString:@"2"];
    }

}
//3
- (IBAction)ThreeAction:(id)sender {
    if ([_discountLabel.text isEqualToString:@"0"]) {
        _discountLabel.text = @"3";
    }else if (_isTure){
        _discountLabel.text = @"3";
        _isTure = NO;
    }else{
        _discountLabel.text = [_discountLabel.text stringByAppendingString:@"3"];
    }

}
//4
- (IBAction)fourAction:(id)sender {
    if ([_discountLabel.text isEqualToString:@"0"]) {
        _discountLabel.text = @"4";
    }else if (_isTure){
        _discountLabel.text = @"4";
        _isTure = NO;
    }else{
        _discountLabel.text = [_discountLabel.text stringByAppendingString:@"4"];
    }
}
//5
- (IBAction)fiveAction:(id)sender {
    if ([_discountLabel.text isEqualToString:@"0"]) {
        _discountLabel.text = @"5";
    }else if (_isTure){
        _discountLabel.text = @"5";
        _isTure = NO;
    }else{
        _discountLabel.text = [_discountLabel.text stringByAppendingString:@"5"];
    }

}
//6
- (IBAction)sixAction:(id)sender {
    if ([_discountLabel.text isEqualToString:@"0"]) {
        _discountLabel.text = @"6";
    }else if (_isTure){
        _discountLabel.text = @"6";
        _isTure = NO;
    }else{
        _discountLabel.text = [_discountLabel.text stringByAppendingString:@"6"];
    }

}
//7
- (IBAction)sevenAction:(id)sender {
    if ([_discountLabel.text isEqualToString:@"0"]) {
        _discountLabel.text = @"7";
    }else if (_isTure){
        _discountLabel.text = @"7";
        _isTure = NO;
    }else{
        _discountLabel.text = [_discountLabel.text stringByAppendingString:@"7"];
    }

}
//8
- (IBAction)eightAction:(id)sender {
    if ([_discountLabel.text isEqualToString:@"0"]) {
        _discountLabel.text = @"8";
    }else if (_isTure){
        _discountLabel.text = @"8";
        _isTure = NO;
    }else{
        _discountLabel.text = [_discountLabel.text stringByAppendingString:@"8"];
    }

}
//9
- (IBAction)nineAction:(id)sender {
    if ([_discountLabel.text isEqualToString:@"0"]) {
        _discountLabel.text = @"9";
    }else if (_isTure){
        _discountLabel.text = @"9";
        _isTure = NO;
    }else{
        _discountLabel.text = [_discountLabel.text stringByAppendingString:@"9"];
    }

}
//确定
- (IBAction)tureAction:(id)sender {
    
    double money = _price * [_discountLabel.text floatValue]/10.0;
    
    NSLog(@"%lf %@",money,_discountLabel.text);
    
    _moneyLabel.text = [NSString stringWithFormat:@"%.0lf",money];
    _isTure = YES;
}
//回删
- (IBAction)deleteAction:(id)sender {
    if (_discountLabel.text.length == 1) {
        _discountLabel.text = @"0";
    }else{
        _discountLabel.text = [_discountLabel.text substringWithRange:NSMakeRange(0, [_discountLabel.text  length] - 1)];
    }
    
}
//原价
- (IBAction)priceAction:(id)sender {
    
    _moneyLabel.text = [NSString stringWithFormat:@"%ld",_price];
    _discountLabel.text = @"0";
    
}

@end
