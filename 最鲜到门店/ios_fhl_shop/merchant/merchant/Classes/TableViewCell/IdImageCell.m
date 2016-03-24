//
//  IdImageCell.m
//  FHL
//
//  Created by panume on 14-10-17.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "IdImageCell.h"

#define CELL_HEIGHT  120

@implementation IdImageCell

+ (CGFloat)cellHeight
{
    return CELL_HEIGHT;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(IdImageCellType)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _type = type;
        
        self.frontButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.frontButton.frame = CGRectMake(0, 0, 140, 88);
        self.frontButton.center = CGPointMake(WINDOW_WIDTH / 2 - 15 / 2 - self.frontButton.bounds.size.width / 2, CELL_HEIGHT / 2);
        [self.frontButton setBackgroundImage:[UIImage imageNamed:@"idcard_front.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.frontButton];
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backButton.frame = CGRectMake(0, 0, 140, 88);
        self.backButton.center = CGPointMake(WINDOW_WIDTH / 2 + 15 / 2 + self.frontButton.bounds.size.width / 2, self.frontButton.center.y);
        [self.backButton setBackgroundImage:[UIImage imageNamed:@"idcard_back.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.backButton];
        
        
        if (_type == IdImageCellTypeEditable) {
            self.addFrontButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.addFrontButton.frame = CGRectMake(CGRectGetMaxX(self.frontButton.frame) - 32, CGRectGetMaxY(self.frontButton.frame) - 32, 32, 32);
            [self.addFrontButton setBackgroundImage:[UIImage imageNamed:@"shooting_n.png"] forState:UIControlStateNormal];
            [self.addFrontButton setBackgroundImage:[UIImage imageNamed:@"shooting_p.png"] forState:UIControlStateHighlighted];
            [self.contentView addSubview:self.addFrontButton];
            
            self.addBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.addBackButton.frame = CGRectMake(CGRectGetMaxX(self.backButton.frame) - 32, CGRectGetMaxY(self.backButton.frame) - 32, 32, 32);
            [self.addBackButton setBackgroundImage:[UIImage imageNamed:@"shooting_n.png"] forState:UIControlStateNormal];
            [self.addBackButton setBackgroundImage:[UIImage imageNamed:@"shooting_p.png"] forState:UIControlStateHighlighted];
            [self.contentView addSubview:self.addBackButton];
        }
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
