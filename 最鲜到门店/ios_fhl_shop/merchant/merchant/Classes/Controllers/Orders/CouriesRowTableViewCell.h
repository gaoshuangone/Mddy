//
//  CouriesRowTableViewCell.h
//  merchant
//
//  Created by gs on 15/6/15.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouriesRowTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDetail;
@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCC;
-(void)changeImageViewFrameWithImageUrl:(NSString*)iamgeUrl;
@end
