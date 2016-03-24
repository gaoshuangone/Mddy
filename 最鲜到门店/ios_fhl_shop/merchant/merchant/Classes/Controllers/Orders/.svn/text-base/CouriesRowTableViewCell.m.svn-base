//
//  CouriesRowTableViewCell.m
//  merchant
//
//  Created by gs on 15/6/15.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "CouriesRowTableViewCell.h"

@implementation CouriesRowTableViewCell

- (void)awakeFromNib {
    // Initialization code
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
  

    // Configure the view for the selected state
}
-(void)changeImageViewFrameWithImageUrl:(NSString*)iamgeUrl{
//    NSLog(@"%f",CGRectGetMaxX(self.labelDetail.frame));
    [self.labelDetail sizeToFit];

//    NSLog(@"%@",NSStringFromCGRect(self.imageViewCC.frame));
//    NSLog(@"%f",CGRectGetMaxX(self.labelDetail.frame));

 [self.imageViewCC setImageWithURL:[NSURL URLWithString:iamgeUrl] placeholderImage:nil];
    
    self.imageViewCC.center = CGPointMake(CGRectGetMaxX(self.labelDetail.frame)+10+self.imageViewCC.boundsWide/2, self.labelDetail.center.y);
    
//    [SelfUser mddyRequestWIthImageWithWayQuickTypeIconUrl:iamgeUrl withMothed:@"downloadShopGroupICon.htm" withBlock:^(UIImage *image, NSError *error) {
//        
//                        if (image) {
//        
//         self.imageViewCC.image = image;
//         self.imageViewCC.bounds = CGRectMake(0, 0, 19, 21);
//         self.imageViewCC.contentMode = UIViewContentModeScaleToFill;
//       
//                        }
//        
//        
//    }];
    
   

//    NSLog(@"%@",NSStringFromCGRect(self.imageViewCC.frame));
}
@end
