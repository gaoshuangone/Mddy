//
//  OrderWaitQianShouCell.m
//  merchant
//
//  Created by gs on 14/11/5.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "OrderWaitQianShouCell.h"

@implementation OrderWaitQianShouCell
#define CELL_HEIGHT  133
+ (CGFloat)cellHeight
{
   
    return CELL_HEIGHT;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(8, 6, WINDOW_WIDTH - 16, 110);
        view.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:view];
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH - 16, 128)];
        
        UIImage *background = [UIImage imageNamed:@"card_bg.png"];
        background = [background stretchableImageWithLeftCapWidth:background.size.width * 0.5 topCapHeight:background.size.height * 0.5];
        backgroundImageView.image = background;
        [view addSubview:backgroundImageView];
        
        
        UILabel* labelAddr= [[UILabel alloc]initWithFrame:CGRectMake(8, 13, 100, 30)];
        labelAddr.text = @"订单金额:";
        labelAddr.font = UIFontHome(16);
        [labelAddr sizeToFit];
        [view addSubview:labelAddr];
        
        self.labelPrice = [[UILabel alloc]init];
     
             self.labelPrice.text = @"12.50343434333333元";
    
      
        self.labelPrice.font =UIFontHome(16);
        [self.labelPrice sizeToFit];
        self.labelPrice.textColor = UICOLOR(248, 78, 11, 1);
        self.labelPrice.bounds =CGRectMake(0, 0, view.bounds.size.width-80, 30);
        self.labelPrice.center = CGPointMake(CGRectGetMaxX(labelAddr.frame)+15+self.labelPrice.bounds.size.width/2, CGRectGetMidY(labelAddr.frame));
        [view addSubview:self.labelPrice];
        
        
        
        UILabel* labelWishShouHuo= [[UILabel alloc]init];
        labelWishShouHuo.text = @"收货地址:";
        labelWishShouHuo.font = UIFontHome(16);
        [labelWishShouHuo sizeToFit];
        labelWishShouHuo.center = CGPointMake(8+labelWishShouHuo.bounds.size.width/2, CGRectGetMaxY(labelAddr.frame)+8+labelWishShouHuo.bounds.size.height/2);
        [view addSubview:labelWishShouHuo];
        
        self.labelAddr = [[UILabel alloc]init];
    if (iPhone6Plus) {
        self.labelAddr.text = @"收货地址大 dafadsfasdfaedfdfasdfa0000";
    }else{
          self.labelAddr.text = @"收货地址大 dafadsfasdfaedfdfasdfa";
    }
    
        self.labelAddr.font = UIFontHome(16);
        [self.labelAddr sizeToFit];
        self.labelAddr.center = CGPointMake(CGRectGetMaxX(labelWishShouHuo.frame)+15+self.labelAddr.bounds.size.width/2, CGRectGetMidY(labelWishShouHuo.frame));
        [view addSubview:self.labelAddr];
        
        
        
        UILabel* labelSongDaTime= [[UILabel alloc]init];
        labelSongDaTime.text = @"送达时间:";
        labelSongDaTime.font = UIFontHome(16);
        [labelSongDaTime sizeToFit];
        labelSongDaTime.center = CGPointMake(8+labelSongDaTime.bounds.size.width/2, CGRectGetMaxY(labelWishShouHuo.frame)+8+labelSongDaTime.bounds.size.height/2);
        [view addSubview:labelSongDaTime];
        
        
        self.labelSongDaTIme = [[UILabel alloc]init];
        self.labelSongDaTIme.text = @"14:00324324333332元";
        self.labelSongDaTIme.font = UIFontHome(16);
        [self.labelSongDaTIme sizeToFit];
        self.labelSongDaTIme.textColor = UICOLOR(248, 78, 11, 1);
        self.labelSongDaTIme.center = CGPointMake(CGRectGetMaxX(labelWishShouHuo.frame)+15+self.labelSongDaTIme.bounds.size.width/2, CGRectGetMidY(labelSongDaTime.frame));
        [view addSubview:self.labelSongDaTIme];

        
        
//        self.labelLanshouGUDing= [[UILabel alloc]init];
//         self.labelLanshouGUDing.text = @"揽收时间:";
//         self.labelLanshouGUDing.font = UIFontHome(16);
//        [ self.labelLanshouGUDing sizeToFit];
//         self.labelLanshouGUDing.center = CGPointMake(CGRectGetMaxX(self.labelWishShouHuo.frame)+ self.labelLanshouGUDing.bounds.size.width/2+13,CGRectGetMidY(self.labelWishShouHuo.frame));
//        [view addSubview: self.labelLanshouGUDing];
//        
//        self.labelLanShou = [[UILabel alloc]init];
//        self.labelLanShou.text = @"09:00";
//        self.labelLanShou.font = UIFontHome(16);
//        [self.labelLanShou sizeToFit];
//        self.labelLanShou.center = CGPointMake(CGRectGetMaxX( self.labelLanshouGUDing.frame)+8+self.labelLanShou.bounds.size.width/2, CGRectGetMidY( self.labelLanshouGUDing.frame));
//        [view addSubview:self.labelLanShou];
        
        
        UIView* viewLine1 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelSongDaTIme.frame)+10, view.frame.size.width-20, 1)];
        viewLine1.backgroundColor = [UIColor lightGrayColor];
        viewLine1.alpha = 0.35;
        [view  addSubview:viewLine1];
        
        
        UIImageView* imageVIewWait = [[UIImageView alloc]initWithFrame:CGRectMake(view.bounds.size.width-70, CGRectGetMidY(viewLine1.frame)+6+2.5, 16, 16)];
        imageVIewWait.image = [UIImage imageNamed:@"grab_card.png"];
        [view addSubview:imageVIewWait];
        
        UILabel* labelWait = [[UILabel alloc]init];
        labelWait.text = @"待接单";
        labelWait.font = [UIFont systemFontOfSize:13];
        [labelWait sizeToFit];
        labelWait.textColor = [UIColor grayColor];
        labelWait.center = CGPointMake(CGRectGetMaxX(imageVIewWait.frame)+3+labelWait.bounds.size.width/2, CGRectGetMidY(imageVIewWait.frame));
        [view addSubview:labelWait];
        
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        view = nil;
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
