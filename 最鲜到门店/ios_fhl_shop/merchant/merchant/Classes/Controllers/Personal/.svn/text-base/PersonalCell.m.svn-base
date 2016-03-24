//
//  PersonalCell.m
//  FHL
//
//  Created by panume on 14-10-28.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "PersonalCell.h"

#define CELL_HEIGHT 44

@implementation PersonalCell

+ (CGFloat)cellHeight
{
    return CELL_HEIGHT;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        self.icon.backgroundColor = [UIColor clearColor];
        self.icon.center = CGPointMake((iPhone6Plus?+5:0)+16 + self.icon.bounds.size.width / 2, CELL_HEIGHT / 2);
        [self.contentView addSubview:self.icon];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = @"客服电话：400-875-1717";
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.titleLabel sizeToFit];
        self.titleLabel.center = CGPointMake(CGRectGetMaxX(self.icon.frame) + 16 + self.titleLabel.bounds.size.width / 2, self.icon.center.y);
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
