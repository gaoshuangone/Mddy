//
//  MessageCell.h
//  FHL
//
//  Created by panume on 14-10-28.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MessageCellType) {
    MessageCellTypeUnRead,
    MessageCellTypeRead
};

@interface MessageCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, assign) MessageCellType type;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, strong) NSString *content;

+ (CGFloat)cellHeight;

@end
