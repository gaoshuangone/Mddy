//
//  TextFieldCell.m
//  FHL
//
//  Created by panume on 14-10-17.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "TextFieldCell.h"

#define CELL_HEIGHT 44

@implementation TextFieldCell

+ (CGFloat)cellHeight
{
    return CELL_HEIGHT;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = @"推荐人手";
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.titleLabel sizeToFit];
        self.titleLabel.center = CGPointMake(16 + self.titleLabel.bounds.size.width / 2, CELL_HEIGHT / 2);
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:self.titleLabel];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH - CGRectGetMaxX(self.titleLabel.frame) - 32, 30)];
        self.textField.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + self.textField.bounds.size.width / 2 + 5, self.titleLabel.center.y);
        self.textField.font = [UIFont systemFontOfSize:15.0f];
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:self.textField];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
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
