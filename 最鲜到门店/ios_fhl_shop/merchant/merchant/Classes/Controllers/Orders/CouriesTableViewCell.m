//
//  CouriesTableViewCell.m
//  merchant
//
//  Created by gs on 15/6/11.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "CouriesTableViewCell.h"

@implementation CouriesTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
 
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setImageWithTel:(NSString*)tel{
    
    [SelfUser mddyRequestWIthImageWithWayQuickTypeIconUrl:tel withMothed:@"downloadShopGroupICon.htm" withBlock:^(UIImage *image, NSError *error) {
        
                        if (image) {
        
        self.imageViewIC.image = image;
        self.imageViewIC.layer.cornerRadius = 35;
        self.imageViewIC.layer.masksToBounds = YES;
        //        imageView.bounds = CGRectMake(0, 0, 15, 15);
        //        imageView.contentMode = UIViewContentModeScaleToFill;
                        }else{
                            
                        }
        
        
    }];

    
    
   }




@end
