//
//  InputAddressssCell.m
//  merchant
//
//  Created by gs on 15/7/9.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "InputAddressssCell.h"

@implementation InputAddressssCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)initViewWithAddress:(NSString*)address withCityQu:(NSString*)city WithQu:(NSString*)qu{
    NSLog(@"%@",city);
    self.labelAddress = [CommonUtils  commonSignleLabelWithText:address withFontSize:18 withOriginX:15 withOriginY:10 isRelativeCoordinate:YES];
    self.labelAddress.bounds = CGRectMake(10, 0, WINDOW_WIDTH-10, self.labelAddress.bounds.size.height);
    self.labelAddress.center = CGPointMake(15+self.labelAddress.bounds.size.width/2, 10+self.labelAddress.bounds.size.height/2);
    [self.contentView addSubview:self.labelAddress];

    NSString* str = nil;
    if ([city toString].length>=1 && [qu toString].length>=1) {
      
        str =[NSString stringWithFormat:@"%@-%@",city,qu];
    }else{
        if ([city toString].length>=1 || [qu toString].length>=1) {
            if ([city toString].length>=1) {
                str = city;
            }else{
                str = qu;
            }
            
          
        }else{
        str = @"";
            
        }
    }
//    self.labelCityQU = [CommonUtils  commonSignleLabelWithText:str withFontSize:14 withOriginX:15 withOriginY:CGRectGetMaxY(self.labelAddress.frame)+10 isRelativeCoordinate:YES];
    self.labelCityQU = [CommonUtils commonMoreLabelWithText:str withFontSize:14 withBoundsWide:WINDOW_WIDTH-20 withOriginX:15 withOriginY:CGRectGetMaxY(self.labelAddress.frame)+10 ];
    
    
    [self.contentView addSubview:self.labelCityQU];

    self.labelCityQU.textColor =[UIColor grayColor];
    if ([str isEqualToString:@""]) {
        self.frame = CGRectMake(0, 0, WINDOW_WIDTH, 135/4);
    }else{
        self.frame = CGRectMake(0, 0, WINDOW_WIDTH, 135/2);
  
    }

    if (self.labelCityQU.boundsHeight>33) {
         self.labelAddress.center = CGPointMake(15+self.labelAddress.bounds.size.width/2, 5+self.labelAddress.bounds.size.height/2);
        self.labelCityQU.bounds = CGRectMake(10, 0, WINDOW_WIDTH-20, 40);
        self.labelCityQU.center = CGPointMake(15+self.labelCityQU.bounds.size.width/2,self.frame.size.height-5- self.labelCityQU.boundsHeight/2);
        
    }

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
