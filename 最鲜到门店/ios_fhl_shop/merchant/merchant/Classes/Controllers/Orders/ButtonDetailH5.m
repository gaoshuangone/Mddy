//
//  ButtonDetailH5.m
//  merchant
//
//  Created by gs on 15/6/29.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "ButtonDetailH5.h"

@implementation ButtonDetailH5
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageViewbut = [[UIImageView alloc]initWithFrame:CGRectMake(12, -2, frame.size.width, frame.size.height-5)];
        UIImage *image = [UIImage imageNamed:@"prompt_fare_box_card"];
        //UIEdgeInsets insets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
        NSInteger leftCapWidth = image.size.width * 0.5f;
        // 顶端盖高度
        NSInteger topCapHeight = image.size.height * 0.5f;
        // 重新赋值
        image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
        self.imageViewbut.image = image;
        [self addSubview:self.imageViewbut];
        
 
     
        
        self.imageViewbutIcon = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-7, frame.size.height-5 - 2, 8, 4)];
        
        self.imageViewbutIcon.image = [UIImage imageNamed:@"prompt_fare_arrow_card.png"];
        [self addSubview:self.imageViewbutIcon];
        
     
        
        
        self.labelBut = [[UILabel alloc]initWithFrame:self.imageViewbut.frame];
        self.labelBut.text = @"  实际配送125.565公里，应付运费134.34元";
        self.labelBut.font = [UIFont systemFontOfSize:12];
        self.labelBut.center = CGPointMake(self.labelBut.center.x+10, self.labelBut.center.y);
        self.labelBut.textColor = [UIColor whiteColor];
        self.labelBut.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.labelBut];
        
        self.buttonBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonBut setTitle:@"详情" forState:UIControlStateNormal];
        self.buttonBut.frame = CGRectMake(frame.size.width-40 + 15, -4, 44, 44);
        self.buttonBut.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.buttonBut setTitleColor:[UIColor colorWithHex:0x007aff] forState:UIControlStateNormal];
        [self.buttonBut addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
        self.buttonBut.tag = 2;
        
        [self addSubview:self.buttonBut];
        self.tag = 1;
        [self addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return self;
}
-(void)button:(UIButton* )sender{
    if (self.buttonPressed) {
        self.buttonPressed(sender.tag);
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
