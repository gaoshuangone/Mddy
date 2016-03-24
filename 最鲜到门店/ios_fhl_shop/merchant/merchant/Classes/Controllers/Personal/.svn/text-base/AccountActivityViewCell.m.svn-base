//
//  AccountActivityViewCell.m
//  merchant
//
//  Created by gs on 15/5/21.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "AccountActivityViewCell.h"
#import "UIView+convenience.h"
@implementation AccountActivityViewCell
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    return self;
}
-(void)initLayuot{
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WINDOW_WIDTH, 30)];
    label.text = @"优惠活动";
    [self addSubview:label];
    
    UIView* viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+5, WINDOW_WIDTH, 1)];
    viewLine.backgroundColor = [UIColor lightGrayColor];
    viewLine.alpha = 0.35;
    [self addSubview:viewLine];
    
    for (int i= 0; i<=4; i++) {
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(viewLine.frame)+5+i*20, WINDOW_WIDTH, 20)];
        label.tag =i+10;
        [self addSubview:label];
        
    }
   
    
    
}
-(void)setText{
     for (int i= 0; i<=4; i++) {
         UILabel* label = (UILabel*)[self viewWithTag:10+i];
         label.text = @"dsf";
         
         if (i==4) {
             self.labelActivity = [[UILabel alloc]init];
             self.labelActivity.bounds = CGRectMake(0, 0, WINDOW_WIDTH, CGFLOAT_MIN);
             self.labelActivity.center = CGPointMake(10+self.labelActivity.frameWidth/2, CGRectGetMaxY(label.frame)+10+self.labelActivity.frameHeight/2);
             self.labelActivity.text = @"活动时间：2015年1月1日～2015年1月7日\n备注：以上优惠活动每个商户仅可参与一次，参与优惠以支付到账时间为准";
             self.labelActivity.numberOfLines = 10;
             self.labelActivity.font = [UIFont systemFontOfSize:12];
             [self.labelActivity sizeToFit];
             [self addSubview:self.labelActivity];
             
         }

     }
    
    CGRect frame = [self frame];
    
    frame.size.height = CGRectGetMaxY(self.labelActivity.frame)+5;
    self.frame = frame;
}
- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
