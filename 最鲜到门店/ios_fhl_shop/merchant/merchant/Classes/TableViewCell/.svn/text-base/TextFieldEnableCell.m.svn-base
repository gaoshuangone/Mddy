//
//  TextFieldEnableCell.m
//  FHL
//
//  Created by panume on 14-10-17.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "TextFieldEnableCell.h"

@implementation TextFieldEnableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH - 50, 30)];
        self.textField.center = CGPointMake(20 + self.textField.bounds.size.width / 2, 20);
        self.textField.font = [UIFont systemFontOfSize:15.0f];
        self.textField.enabled = NO;
        [self.contentView addSubview:self.textField];
        
        UIImage *image = [UIImage imageNamed:@"dropdown_boom_n.png"];
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        self.icon.image = image;
        self.icon.center = CGPointMake(WINDOW_WIDTH - 20, self.textField.center.y);
        [self.contentView addSubview:self.icon];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setDistrict:(NSString *)district
{
    _district = district;
    self.textField.text = _district;
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
