//
//  OrderCell.m
//  FHL
//
//  Created by panume on 14-10-21.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "OrderWaitLanShouCell.h"
#import "UIImageView+Circle.h"

#define CELL_HEIGHT  145


@implementation OrderWaitLanShouCell

+ (CGFloat)cellHeight
{
    if ([[SelfUser currentSelfUser].strStatus isEqualToString:@"lanshou"]) {
        return CELL_HEIGHT;
    }else{
        return CELL_HEIGHT+24;
    }
    
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
        
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH - 16, 140)];
        
        if ([[SelfUser currentSelfUser].strStatus isEqualToString:@"lanshou"]) {
            
        }else{
            backgroundImageView.frame =CGRectMake(0, 0, WINDOW_WIDTH - 16, 140+24);
        }
        
        
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
        self.labelPrice.text = @"14:00444444444444元";
        self.labelPrice.font =UIFontHome(16);
        [self.labelPrice sizeToFit];
        self.labelPrice.textColor  =UICOLOR(248, 78, 11, 1);
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
//        self.labelAddr.bounds = CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)
        [self.labelAddr sizeToFit];
        self.labelAddr.center = CGPointMake(CGRectGetMaxX(labelWishShouHuo.frame)+15+self.labelAddr.bounds.size.width/2, CGRectGetMidY(labelWishShouHuo.frame));
        [view addSubview:self.labelAddr];
        
        
        UILabel* labelSongDaTime= [[UILabel alloc]init];
        labelSongDaTime.text = @"送达时间:";
        labelSongDaTime.font = UIFontHome(16);
        [labelSongDaTime sizeToFit];
       
        if ([[SelfUser currentSelfUser].strStatus isEqualToString:@"lanshou"]) {
            labelSongDaTime.center = CGPointMake(8+labelSongDaTime.bounds.size.width/2, CGRectGetMaxY(labelWishShouHuo.frame)+8+labelSongDaTime.bounds.size.height/2);
        }else{
            
            self.labelLanshouGUDing= [[UILabel alloc]init];
            self.labelLanshouGUDing.text = @"揽收时间:";
            self.labelLanshouGUDing.font = UIFontHome(16);
            [ self.labelLanshouGUDing sizeToFit];
            self.labelLanshouGUDing.center = CGPointMake(8+labelWishShouHuo.bounds.size.width/2,CGRectGetMaxY(labelWishShouHuo.frame)+8+labelWishShouHuo.bounds.size.height/2);
            [view addSubview: self.labelLanshouGUDing];
            
            self.labelLanShou = [[UILabel alloc]init];
            self.labelLanShou.text = @"09:36erew232132132r";
            self.labelLanShou.font = UIFontHome(16);
            [self.labelLanShou sizeToFit];
            self.labelLanShou.center = CGPointMake(CGRectGetMaxX( self.labelLanshouGUDing.frame)+15+self.labelLanShou.bounds.size.width/2, CGRectGetMidY( self.labelLanshouGUDing.frame));
            labelSongDaTime.center = CGPointMake(8+labelSongDaTime.bounds.size.width/2, CGRectGetMaxY(self.labelLanshouGUDing.frame)+8+labelSongDaTime.bounds.size.height/2);
            self.labelSongDaTime.textAlignment = NSTextAlignmentLeft;
            [view addSubview:self.labelLanShou];
            

        }

        [view addSubview:labelSongDaTime];
        
        
        self.labelSongDaTime = [[UILabel alloc]init];
        self.labelSongDaTime.text = @"14:322323236";
        self.labelSongDaTime.font = UIFontHome(16);
        [self.labelSongDaTime sizeToFit];
         self.labelSongDaTime.textColor = UICOLOR(248, 78, 11, 1);
        self.labelSongDaTime.center = CGPointMake(CGRectGetMaxX(labelWishShouHuo.frame)+15+self.labelSongDaTime.bounds.size.width/2, CGRectGetMidY(labelSongDaTime.frame));
        self.labelSongDaTime.textAlignment = NSTextAlignmentLeft;
        [view addSubview:self.labelSongDaTime];
        
        
        
        
        
        UIView* viewLine1 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelSongDaTime.frame)+13, view.frame.size.width-20, 1)];
        viewLine1.backgroundColor = [UIColor lightGrayColor];
        viewLine1.alpha = 0.35;
        [view  addSubview:viewLine1];
        
        
        
        
        self.buttonTEL = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonTEL setTitle:@"配送员:  周星星" forState:UIControlStateNormal];
        self.buttonTEL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.buttonTEL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.buttonTEL.titleLabel.font = [ UIFont systemFontOfSize:13];
        self.buttonTEL.frame = CGRectMake(16, iphone6_6P_isYES?viewLine1.frame.origin.y+4:  viewLine1.frame.origin.y+12.5-3, 160, 40);
//        self.buttonTEL .backgroundColor = [UIColor redColor];
        [self addSubview:self.buttonTEL];
      
        
       self.imageViewPhone = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.buttonTEL.frame)-80,  CGRectGetMidY(self.buttonTEL.frame)-18, 24, 24  )];
        
        self.imageViewPhone.image = [UIImage imageNamed:@"orders_phone_n.png"];
        
        [view addSubview:self.imageViewPhone];
        
        
        self.imageViewWait = [[UIImageView alloc]initWithFrame:CGRectMake(view.bounds.size.width-70, CGRectGetMidY(self.buttonTEL.frame)-13, 16, 16)];
        self.imageViewWait.image = [UIImage imageNamed:@"receipt_card.png"];
        
        [view addSubview:self.imageViewWait];
        
        
        
        
        
        
        self.labelWaitStatus = [[UILabel alloc]init];
        
        self.labelWaitStatus.text = @"待签收";
        
        self.labelWaitStatus.font = [ UIFont systemFontOfSize:13];
        [ self.labelWaitStatus sizeToFit];
        self.labelWaitStatus.textColor = UICOLOR(248, 78, 11, 1);
        self.labelWaitStatus.center = CGPointMake(CGRectGetMaxX(self.imageViewWait.frame)+3+ self.labelWaitStatus.bounds.size.width/2, CGRectGetMidY(self.buttonTEL.frame)-3.5);
        [view addSubview: self.labelWaitStatus];
        
        
        
        
        view = nil;
        
        
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}
-(void)setFrame1{
    FLDDLogDebug(@"%@",self.buttonTEL.titleLabel.text);
    CGSize size = CGSizeMake(300, MAXFLOAT);
   NSDictionary *attrbute = @{NSFontAttributeName:self.buttonTEL.titleLabel.font};
//    CGSize labelsize = [self.buttonTEL.titleLabel.text  sizeWithFont:self.buttonTEL.titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
      CGRect labelsize = [self.buttonTEL.titleLabel.text  boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil];
    
    self.imageViewPhone.frame = CGRectMake(16+labelsize.size.width-6, self.imageViewPhone.frame.origin.y, self.imageViewPhone.frame.size.width, self.imageViewPhone.frame.size.height);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

\
@end
