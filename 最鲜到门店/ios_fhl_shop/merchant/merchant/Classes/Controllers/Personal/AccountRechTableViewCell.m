//
//  AccountRechTableViewCell.m
//  merchant
//
//  Created by gs on 15/5/20.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "AccountRechTableViewCell.h"

@implementation AccountRechTableViewCell
+(CGFloat)cellHeight{
    return  64;
}
- (void)awakeFromNib {
    
    // Initialization code
}
-(void)changeColor{
    if (self.isAdd) {
        self.label3.textColor = [UIColor colorWithHex:0xf7563c];
    }else{
        self.label3.textColor = [UIColor colorWithHex:0x81bb3b];
        
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
