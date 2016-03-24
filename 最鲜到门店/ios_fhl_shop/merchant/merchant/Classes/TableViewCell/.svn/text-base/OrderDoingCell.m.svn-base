//
//  OrderDoingCell.m
//  merchant
//
//  Created by gs on 14/11/6.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "OrderDoingCell.h"

@implementation OrderDoingCell
#define CELL_HEIGHT 120
+ (CGFloat)cellHeight
{
    return CELL_HEIGHT;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_AVAILABLE_IOS(3_0)
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(8, 6, WINDOW_WIDTH - 16, 110);
        view.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:view];
        
        self.backgroundColor = [UIColor clearColor];
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH - 16, 115)];
        
        UIImage *background = [UIImage imageNamed:@"card_bg.png"];
        background = [background stretchableImageWithLeftCapWidth:background.size.width * 0.5 topCapHeight:background.size.height * 0.5];
        backgroundImageView.image = background;
        [view addSubview:backgroundImageView];
        
  
        
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        UILabel* labelJinE = [[UILabel alloc]init];
        labelJinE.text = @"订单金额:";
        labelJinE.font =UIFontHome(16);
        [labelJinE sizeToFit];
     
        labelJinE.center = CGPointMake(10+labelJinE.bounds.size.width/2, CGRectGetMinY(view.frame)+15+3+(iphone6_6P_isYES?-4:0));
        [view addSubview:labelJinE];
     
        self.labelPrice = [[UILabel alloc]init];
        self.labelPrice.text = @"24.00元";
        [self.labelPrice sizeToFit];
        self.labelPrice.font = UIFontHome(16);
           self.labelPrice.textColor = UICOLOR(248, 78, 11, 1);
        self.labelPrice.center=CGPointMake(CGRectGetMaxX(labelJinE.frame)+15+self.labelPrice.bounds.size.width/2,CGRectGetMidY(labelJinE.frame)+2);
        self.labelPrice.textAlignment = NSTextAlignmentLeft;
        [view addSubview:self.labelPrice];
        
        
        
        UILabel* labelFaDan = [[UILabel alloc]init];
        labelFaDan.text = @"发单时间:";
        labelFaDan.font = UIFontHome(16);
        [labelFaDan sizeToFit];
        labelFaDan.center = CGPointMake(10+labelFaDan.bounds.size.width/2, CGRectGetMaxY(labelJinE.frame)+5+labelFaDan.bounds.size.height/2);
        [view addSubview:labelFaDan];
        
        self.labelSend = [[UILabel alloc]init];
        self.labelSend.text = @"12月24日 23:56";
        self.labelSend.font = UIFontHome(16);
        [self.labelSend sizeToFit];
        self.labelSend.center = CGPointMake(CGRectGetMaxX(labelFaDan.frame)+15+self.labelSend.bounds.size.width/2, CGRectGetMidY(labelFaDan.frame));
        self.labelSend.textAlignment = NSTextAlignmentLeft;
        [view addSubview:self.labelSend];
        
        
        self.labelStatusTime= [[UILabel alloc]init];
                self.labelStatusTime.text = @"完成时间:";
                self.labelStatusTime.font = UIFont(16);
        [        self.labelStatusTime sizeToFit];
                self.labelStatusTime.center = CGPointMake(10+        self.labelStatusTime.bounds.size.width/2, CGRectGetMaxY(labelFaDan.frame)+6+        self.labelStatusTime.bounds.size.height/2);
        [view addSubview:        self.labelStatusTime];
        
        self.labelSuccessed = [[UILabel alloc]init];
        self.labelSuccessed.text = @"12月24日 23:58";
        self.labelSuccessed.font = UIFontHome(16);
        [self.labelSuccessed sizeToFit];
        self.labelSuccessed.center = CGPointMake(CGRectGetMaxX(        self.labelStatusTime.frame)+15+self.labelSuccessed.bounds.size.width/2, CGRectGetMidY(        self.labelStatusTime.frame));
        self.labelSuccessed.textAlignment = NSTextAlignmentLeft;
        [view addSubview:self.labelSuccessed];
        
        
        
        UILabel* labelAddress = [[UILabel alloc]init];
        labelAddress.text = @"收货地址:";
        labelAddress.font = UIFont(16);
        [labelAddress sizeToFit];
        labelAddress.center = CGPointMake(10+labelAddress.bounds.size.width/2, CGRectGetMaxY(self.labelStatusTime.frame)+6+labelAddress.bounds.size.height/2);
        [view addSubview:labelAddress];
        
        self.labelAddressed = [[UILabel alloc]init];
        if (iPhone6Plus) {
            self.labelAddressed.text = @"收货地址大 dafadsfasdfaedfdfasdfa0000";
        }else{
            self.labelAddressed.text = @"收货地址大 dafadsfasdfaedfdfasdfa";
        }
        self.labelAddressed.font = UIFontHome(16);
        [self.labelAddressed sizeToFit];
        self.labelAddressed.bounds = CGRectMake(0, 0, WINDOW_WIDTH-120, 40);
        self.labelAddressed.textAlignment = NSTextAlignmentLeft;
//        FLDDLogDebug(@"####################################################################self.labelAddressed.bounds.size.width/2 : %f, self.labelAddressed.bounds.size.width : %f", self.labelAddressed.bounds.size.width/2, self.labelAddressed.bounds.size.width)
        self.labelAddressed.center = CGPointMake(CGRectGetMaxX(labelAddress.frame)+15+self.labelAddressed.bounds.size.width/2, CGRectGetMidY(labelAddress.frame));
        
        [view addSubview:self.labelAddressed];
        
        //        CGRectMake(WINDOW_WIDTH-100, 8, 85, 85)];
        NSInteger wide;
        if(iPhone4 || iPhone5){
            wide =  35;
        }else{
            wide = 0;
        }
        self.imageViewStatus = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-130, 8, 85, 85) ];
//                                CGRectMakeIphone(WINDOW_WIDTH-130+10+wide, 8, 120 , 120)];
        
        [view addSubview:self.imageViewStatus];
        view = nil;
        
    }
    return self;
    
}
-(void)changImageView:(ORDER_DOING_STATUS)status
{
    if(status == ORDER_EORDER_DOING_CANCEL){
        self.imageViewStatus.image =[UIImage imageNamed:@"cancelleding_seal_normal.png"];
             self.labelStatusTime.text =@"取消时间:";
       
    }
    if(status == ORDER_ORDER_DOING_JUSHOU){

        self.imageViewStatus.image =    [UIImage imageNamed:@"declineding_seal_normal.png"];
         self.labelStatusTime.text =@"拒收时间:";
    }
}
- (void)awakeFromNib {
    
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
