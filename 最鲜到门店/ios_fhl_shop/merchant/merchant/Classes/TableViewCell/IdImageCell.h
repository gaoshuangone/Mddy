//
//  IdImageCell.h
//  FHL
//
//  Created by panume on 14-10-17.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IdImageCellType) {
    IdImageCellTypeEditable,
    IdImageCellTypeUneditable
};

@interface IdImageCell : UITableViewCell

@property (nonatomic, assign) IdImageCellType type;
@property (nonatomic, strong) UIButton *frontButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *addFrontButton;
@property (nonatomic, strong) UIButton *addBackButton;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(IdImageCellType)type;

+ (CGFloat)cellHeight;

@end
