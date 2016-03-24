//
//  InputAddressNODataView.m
//  merchant
//
//  Created by gs on 15/7/9.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "InputAddressNODataView.h"

@implementation InputAddressNODataView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    
        
        self.labelNoti = [CommonUtils commonSignleLabelWithText:@"抱歉，未能找到此地址" withFontSize:14 withOriginX:self.center.x withOriginY:self.center.y-30 isRelativeCoordinate:NO];
        self.labelNoti.textColor  = [UIColor lightGrayColor];
        [self addSubview:self.labelNoti];
        
        self.labelDetail = [CommonUtils commonSignleLabelWithText:@"请输入小区、学校、写字楼、街道等全称" withFontSize:14 withOriginX:self.center.x withOriginY:self.center.y isRelativeCoordinate:NO];
         self.labelDetail.textColor  = [UIColor lightGrayColor];
        [self addSubview:self.labelDetail];

        self.buttonBut = [CommonUtils commonButtonWithFrame:CGRectMake(self.center.x-40, self.center.y+10, 100, 40) withTarget:self withAction:@selector(button)];
         [self.buttonBut setTitle:@"去地图上找找" forState:UIControlStateNormal];
          self.buttonBut.titleLabel.font = [UIFont systemFontOfSize:14];
              [self.buttonBut setTitleColor:[UIColor colorWithHex:0x007aff] forState:UIControlStateNormal];
        [self addSubview:self.buttonBut];
        
    
         self.labelNoti.userInteractionEnabled = YES;
        self.labelDetail.userInteractionEnabled = YES;
        self.buttonBut.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)button{
    if (self.buttonPressed) {
        self.buttonPressed();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
