//
//  PresonalInfoCell.m
//  merchant
//
//  Created by gs on 14/11/3.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "PresonalInfoCell.h"

#define CELL_HEIGHT     155
#define PORTRAIT_SIZE   70
@implementation PresonalInfoCell
+ (CGFloat)cellHeight
{
    return CELL_HEIGHT;
}
- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cellImageView = [UIImageView circleImageViewFrame:CGRectMake(0, 0, PORTRAIT_SIZE, PORTRAIT_SIZE) Radius:PORTRAIT_SIZE / 2];

  
//    [UIImageView circleImageViewFrame:CGRectMake(0, 0, PORTRAIT_SIZE, PORTRAIT_SIZE) Radius:PORTRAIT_SIZE / 2];
    self.cellImageView.image =[UIImage imageNamed:@"business_default_photo_normal"];
    self.cellImageView.center = CGPointMake((iPhone6Plus?+5:0)+16 + self.cellImageView.bounds.size.width / 2, 50);
    [self.contentView addSubview:self.cellImageView];

   
    
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.text = @"绝味鸭脖00000";
    self.labelTitle.font = [UIFont systemFontOfSize:20];
    self.labelTitle.backgroundColor = [UIColor clearColor];
    self.labelTitle.frame= CGRectMake(0, 0,WINDOW_WIDTH-(CGRectGetMaxX(self.cellImageView.frame) + 16+30+24), 50);
//    [self.labelTitle sizeToFit];
    self.labelTitle.center = CGPointMake(CGRectGetMaxX(self.cellImageView.frame) + 16 + self.labelTitle.bounds.size.width / 2, CGRectGetMidY(self.cellImageView.frame));
    [self.contentView addSubview:self.labelTitle];

//    self.labelTitleAddress = [[UILabel alloc] init];
//    self.labelTitleAddress.text = @"天目山路店";
//    self.labelTitleAddress.textColor = [UIColor grayColor];
//    self.labelTitleAddress.font = [UIFont systemFontOfSize:15];
//    self.labelTitleAddress.backgroundColor = [UIColor clearColor];
//    [self.labelTitleAddress sizeToFit];
//    self.labelTitleAddress.center = CGPointMake(CGRectGetMaxX(self.cellImageView.frame) + 16 + self.labelTitleAddress.bounds.size.width / 2, CGRectGetMaxY(self.labelTitle.frame)+18);
//    [self.contentView addSubview:self.labelTitleAddress];
    
    
    
    
    UIView* view = [[UIView alloc]init];
    view.backgroundColor  =[ UIColor lightGrayColor];
    view.alpha = 0.35;
    view.frame = CGRectMake(20, CGRectGetMaxY(self.cellImageView.frame)+13, WINDOW_WIDTH-40, 1);
    [self.contentView addSubview:view];
    
    UIImageView* imageViewPhone = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
    imageViewPhone.image = [UIImage imageNamed:@"call_my_icon.png"];
    imageViewPhone.center = CGPointMake((iPhone6Plus?+5:0)+ CGRectGetMinX(view.frame) + imageViewPhone.bounds.size.width / 2, CGRectGetMidY(view.frame)+16);
    [self.contentView addSubview:imageViewPhone];
    
    UIImageView* imageLocation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
    imageLocation.image = [UIImage imageNamed:@"local_my_icon.png"];
    imageLocation.center = CGPointMake((iPhone6Plus?+5:0)+ CGRectGetMinX(view.frame) + imageViewPhone.bounds.size.width / 2, CGRectGetMaxY(imageViewPhone.frame)+16);
    [self.contentView addSubview:imageLocation];
    
    
    self.labelPhoneNumber = [[UILabel alloc]init];
    self.labelPhoneNumber.text = @"138 0057 0571";
    self.labelPhoneNumber.font = [UIFont systemFontOfSize:13];
    self.labelPhoneNumber.backgroundColor = [UIColor clearColor];
    [self.labelPhoneNumber sizeToFit];
    self.labelPhoneNumber.center = CGPointMake(CGRectGetMaxX(imageViewPhone.frame)+55,CGRectGetMidY(imageViewPhone.frame));
    [self.contentView addSubview:self.labelPhoneNumber];
    
    self.labelTitleAddress = [[UILabel alloc]init];
    self.labelTitleAddress.text = @"杭州市西湖区天目山路238号华鸿大厦A座302室天目山路238号华鸿大厦A座302室天目山路238号华鸿大厦A座302室";
    self.labelTitleAddress.font = [UIFont systemFontOfSize:13];
    self.labelTitleAddress.backgroundColor = [UIColor clearColor];
    self.labelTitleAddress.bounds = CGRectMake(0, 0,WINDOW_WIDTH-50, 30);
//    [self.labelTitleAddress sizeToFit];
    self.labelTitleAddress.center = CGPointMake(CGRectGetMaxX(imageLocation.frame)+10+self.labelTitleAddress.bounds.size.width/2,CGRectGetMidY(imageLocation.frame));
    [self.contentView addSubview:self.labelTitleAddress];

    
    
    
    
    // Initialization code
}
-(void)setImageViewYouWithIndex:(NSInteger)index{
    
    [SelfUser mddyRequestWIthImageWithWayQuickTypeIconUrl:[AppManager valueForKey:@"shopGroupIconUrl"] withMothed:@"downloadShopGroupICon.htm" withBlock:^(UIImage *image, NSError *error) {
        if (!error) {
            
            if (image != nil) {
                self.imageViewYou = [[ UIImageView alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
                self.imageViewYou.image = image;
                self.imageViewYou.center = CGPointMake(CGRectGetMaxX(self.cellImageView.frame) + 22 , CGRectGetMidY(self.cellImageView.frame));
                self.labelTitle.center = CGPointMake(CGRectGetMaxX(self.cellImageView.frame) + 16+22 + self.labelTitle.bounds.size.width / 2, CGRectGetMidY(self.cellImageView.frame));
                [self.contentView addSubview:self.imageViewYou];
                
            }
            else {
              
            }
        }else {
            
           
            
            
            
        }
        
    }];
    
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
