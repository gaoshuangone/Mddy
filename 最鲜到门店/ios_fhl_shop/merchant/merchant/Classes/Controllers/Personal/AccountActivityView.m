//
//  AccountActivityView.m
//  merchant
//
//  Created by gs on 15/5/25.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "AccountActivityView.h"

@implementation AccountActivityView
-(instancetype)initWithFrame:(CGRect)frame WithDict:(NSDictionary*)dict withFramLeeft:(CGFloat)left{
    if (self =[super initWithFrame:frame]) {
        self.dict = [NSDictionary dictionaryWithDictionary:dict];
        self.left = left;
         [self initLayuot];
    }
    return self;
    
}
-(void)initLayuot{
    UILabel* label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor grayColor];
    label.text = @"优惠活动";
    [label sizeToFit];
    label.center = CGPointMake(self.left+label.boundsWide/2, 10+label.boundsHeight/2);
    [self addSubview:label];
    
    UILabel* labelActivoty = [[UILabel alloc]init];
    labelActivoty.numberOfLines = 0;
    labelActivoty.bounds = CGRectMake(0, 0, WINDOW_WIDTH-self.left*2, 0);
    labelActivoty.font = [UIFont systemFontOfSize:16];
    labelActivoty.text = [self.dict valueForKey:@"actionDetail"];
    [labelActivoty sizeToFit];
    labelActivoty.center = CGPointMake(CGRectGetMinX(label.frame)+labelActivoty.bounds.size.width/2, CGRectGetMaxY(label.frame)+5+labelActivoty.boundsHeight/2);
    [self addSubview:labelActivoty];
    
//    labelActivoty.backgroundColor = [UIColor redColor];
    
    UILabel* labelTime = [[UILabel alloc]init];
    labelTime.numberOfLines = 0;
    labelTime.textColor = [UIColor grayColor];
    labelTime.bounds = CGRectMake(0, 0, WINDOW_WIDTH-self.left*2, 0);
    labelTime.font = [UIFont systemFontOfSize:14];
    labelTime.text =[NSString stringWithFormat:@"活动时间:%@",[self.dict valueForKey:@"actionTime"]];
    [labelTime sizeToFit];
    labelTime.center = CGPointMake(CGRectGetMinX(label.frame)+labelTime.bounds.size.width/2, CGRectGetMaxY(labelActivoty.frame)+5+labelTime.boundsHeight/2);
    [self addSubview:labelTime];
//  labelTime.backgroundColor = [UIColor orangeColor];

    UILabel* labelBeiZhu = [[UILabel alloc]init];
    labelBeiZhu.numberOfLines = 0;
    labelBeiZhu.textColor = [UIColor grayColor];
    labelBeiZhu.bounds = CGRectMake(0, 0, WINDOW_WIDTH-self.left*2, 0);
    labelBeiZhu.font = [UIFont systemFontOfSize:14];
    labelBeiZhu.text = [self.dict valueForKey:@"actionMemo"];
    [labelBeiZhu sizeToFit];
    labelBeiZhu.center = CGPointMake(CGRectGetMinX(label.frame)+labelBeiZhu.bounds.size.width/2, CGRectGetMaxY(labelTime.frame)+3+labelBeiZhu.boundsHeight/2);
    [self addSubview:labelBeiZhu];
    
    
//    UILabel* labelActivoty = [[UILabel alloc]init];
//    labelActivoty.numberOfLines = 0;
//    labelActivoty.bounds = CGRectMake(0, 0, WINDOW_WIDTH-self.left*2, 0);
//    labelActivoty.font = [UIFont systemFontOfSize:16];
//    labelActivoty.text = [NSString stringWithFormat:@"充%@送%@，多重多送，最多送%@元",[[self.dict valueForKey:@"actionNumberPre"] toString],[[self.dict valueForKey:@"actionNumber"] toString],[[self.dict valueForKey:@"actionNumberLmit"] toString]];
//    [labelActivoty sizeToFit];
//    labelActivoty.center = CGPointMake(CGRectGetMinX(label.frame)+labelActivoty.bounds.size.width/2, CGRectGetMaxY(label.frame)+15);
//    [self addSubview:labelActivoty];
//    
//    UILabel* labelDetail = [[UILabel alloc]init];
//    labelDetail.numberOfLines = 0;
//    labelDetail.textColor = [UIColor grayColor];
//    labelDetail.bounds = CGRectMake(0, 0, WINDOW_WIDTH-self.left*2, 0);
//    labelDetail.font = [UIFont systemFontOfSize:14];
//    labelDetail.text = [NSString stringWithFormat:@"活动时间：%@至%@\n活动期间每个商户可参与%@次，参与时间已支付到账时间为准",[CommonUtils getDateForStringTime:[[self.dict valueForKey:@"startTime"] toString]withFormat:@"yyyy-MM-dd"],[CommonUtils getDateForStringTime:[[self.dict valueForKey:@"endTime"] toString]withFormat:@"yyyy-MM-dd"],[[self.dict valueForKey:@"joinCountLimit"] toString]];
//    [labelDetail sizeToFit];
//    labelDetail.center = CGPointMake(CGRectGetMinX(labelActivoty.frame)+labelDetail.bounds.size.width/2, CGRectGetMaxY(labelActivoty.frame)+10+labelActivoty.bounds.size.height/2);
//    [self addSubview:labelDetail];
    
//    UIView* viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+5, WINDOW_WIDTH, 1)];
//    viewLine.backgroundColor = [UIColor lightGrayColor];
//    viewLine.alpha = 0.35;
//    [self addSubview:viewLine];
//    
//    for (int i= 0; i<=4; i++) {
//        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(viewLine.frame)+5+i*20, WINDOW_WIDTH, 20)];
//        label.tag =i+10;
//        [self addSubview:label];
//        
//    }
    
    
    
}
-(void)setText{
//    for (int i= 0; i<=4; i++) {
//        UILabel* label = (UILabel*)[self viewWithTag:10+i];
//        label.text = @"dsf";
//        
//        if (i==4) {
//            self.labelActivity = [[UILabel alloc]init];
//            self.labelActivity.bounds = CGRectMake(0, 0, WINDOW_WIDTH, CGFLOAT_MIN);
//            self.labelActivity.center = CGPointMake(10+self.labelActivity.frameWidth/2, CGRectGetMaxY(label.frame)+10+self.labelActivity.frameHeight/2);
//            self.labelActivity.text = @"活动时间：2015年1月1日～2015年1月7日\n备注：以上优惠活动每个商户仅可参与一次，参与优惠以支付到账时间为准";
//            self.labelActivity.numberOfLines = 10;
//            self.labelActivity.font = [UIFont systemFontOfSize:12];
//            [self.labelActivity sizeToFit];
//            [self addSubview:self.labelActivity];
//            
//        }
//        
//    }
//    
//    CGRect frame = [self frame];
//    
//    frame.size.height = CGRectGetMaxY(self.labelActivity.frame)+5;
//    self.frame = frame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
