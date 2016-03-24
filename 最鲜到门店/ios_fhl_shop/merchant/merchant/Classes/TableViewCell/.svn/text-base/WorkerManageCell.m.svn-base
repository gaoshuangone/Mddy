//
//  WorkerManageCell.m
//  merchant
//
//  Created by gs on 14/11/3.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "WorkerManageCell.h"

@implementation WorkerManageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 44)];
        self.cellLabel.text = @"dasfasdfaedxfd";
       [self.cellLabel sizeToFit];
        
        self.cellLabel.font = [UIFont systemFontOfSize:16];
        self.cellLabel.center = CGPointMake((iPhone6Plus?+5:0)+15+ self.cellLabel.frame.size.width/2, 22);
        [self.contentView addSubview:self.cellLabel];
        
        self.labelDianZhang = [[UILabel alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-60, 10, 60, 44)];
        self.labelDianZhang.text = @"店长";
        [self.labelDianZhang sizeToFit];
        self.labelDianZhang.hidden = YES;
        self.labelDianZhang.textColor  =UICOLOR(248, 78, 11, 1);
        self.labelDianZhang.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.labelDianZhang];
        
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
