//
//  OrderSuccessdCell.m
//  merchant
//
//  Created by gs on 14/11/4.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "OrderSuccessdCell.h"

@implementation OrderSuccessdCell
#define CELL_HEIGHT 115
+ (CGFloat)cellHeight
{
    return CELL_HEIGHT;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_AVAILABLE_IOS(3_0)
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
            NSInteger height;
        if(iPhone4||iPhone5){
            height = 3;
        }else{
            height = 0;
        }
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 0, WINDOW_WIDTH - 14, 110)];
        
        
        
        UIImage *background = [UIImage imageNamed:@"card_bg.png"];
        background = [background stretchableImageWithLeftCapWidth:background.size.width * 0.5 topCapHeight:background.size.height * 0.5];
        backgroundImageView.image = background;
        [self  addSubview:backgroundImageView];


        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        UILabel* labelJinE = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, 200, 20)];
        labelJinE.text = @"订单金额:";
        labelJinE.font = UIFont(16);
        [self addSubview:labelJinE];
//        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(10, 24, WINDOW_WIDTH-20, 1)];
//        view.backgroundColor = [UIColor lightGrayColor];
//        view.alpha = 0.35;
//        [self addSubview:view];
        
        self.labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(iphone6_6P_isYES? 100:88, 8, 200, 20)];
        self.labelPrice.text = @"24.00元24324";
        [self.labelPrice sizeToFit];
        self.labelPrice.font = UIFont(16);
        [self addSubview:self.labelPrice];
       
    
        
     
        UILabel* labelFaDan = [[UILabel alloc]init];
        labelFaDan.text = @"发单时间:";
        labelFaDan.font = UIFont(16);
        [labelFaDan sizeToFit];
        labelFaDan.center = CGPointMake(15+labelFaDan.bounds.size.width/2, CGRectGetMaxY(labelJinE.frame)+2+labelFaDan.bounds.size.height/2+height);
        [self addSubview:labelFaDan];
        
        self.labelSend = [[UILabel alloc]init];
        self.labelSend.text = @"2014-12-10 12:10";
        self.labelSend.font = UIFont(16);
        [self.labelSend sizeToFit];
        self.labelSend.center = CGPointMake(CGRectGetMaxX(labelFaDan.frame)+15+self.labelSend.bounds.size.width/2, CGRectGetMidY(labelFaDan.frame));
        [self addSubview:self.labelSend];
        
        
        UILabel* labelSuceessed = [[UILabel alloc]init];
        labelSuceessed.text = @"完成时间:";
        labelSuceessed.font = UIFont(16);
        [labelSuceessed sizeToFit];
        labelSuceessed.center = CGPointMake(15+labelSuceessed.bounds.size.width/2, CGRectGetMaxY(labelFaDan.frame)+6+labelSuceessed.bounds.size.height/2);
        [self addSubview:labelSuceessed];
        
        self.labelSuccessed = [[UILabel alloc]init];
        self.labelSuccessed.text = @"2014-12-10 12:12";
        self.labelSuccessed.font = UIFont(16);
        [self.labelSuccessed sizeToFit];
        self.labelSuccessed.center = CGPointMake(CGRectGetMaxX(labelSuceessed.frame)+15+self.labelSuccessed.bounds.size.width/2, CGRectGetMidY(labelSuceessed.frame));
        [self addSubview:self.labelSuccessed];
        
        
        
        UILabel* labelAddress = [[UILabel alloc]init];
        labelAddress.text = @"收货地址:";
        labelAddress.font = UIFont(16);
        [labelAddress sizeToFit];
        labelAddress.center = CGPointMake(15+labelAddress.bounds.size.width/2, CGRectGetMaxY(labelSuceessed.frame)+6+labelAddress.bounds.size.height/2);
        [self addSubview:labelAddress];

        self.labelAddressed = [[UILabel alloc]init];
        self.labelAddressed.text = @"杭州市西湖区天目山路238号华鸿大厦";
        self.labelAddressed.font = UIFont(16);
        [self.labelAddressed sizeToFit];
          self.labelAddressed.bounds = CGRectMake(0, 0, WINDOW_WIDTH-100, 40);
        self.labelAddressed.center = CGPointMake(CGRectGetMaxX(labelAddress.frame)+15+self.labelAddressed.bounds.size.width/2, CGRectGetMidY(labelAddress.frame));
      
        [self addSubview:self.labelAddressed];
        
        
        self.imageViewStatus = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-100, 8, 85, 85)];
//       self.imageViewStatus.image = [UIImage imageNamed:@"completed_seal_big.png"];
        [self addSubview:self.imageViewStatus ];
        
        
    }
    return self;
        
}
- (void)awakeFromNib {
    
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
