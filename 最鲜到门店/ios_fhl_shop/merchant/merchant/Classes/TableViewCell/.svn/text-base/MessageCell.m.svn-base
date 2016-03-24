//
//  MessageCell.m
//  FHL
//
//  Created by panume on 14-10-28.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "MessageCell.h"

#define CELL_HEIGHT  70

@implementation MessageCell

+ (CGFloat)cellHeight
{
    return CELL_HEIGHT;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        self.icon.backgroundColor = [UIColor clearColor];
        self.icon.image = [UIImage imageNamed:@"unread_messages.png"];
        self.icon.center = CGPointMake(5 + self.icon.bounds.size.width / 2, 10 + self.icon.bounds.size.width /2);
        [self.contentView addSubview:self.icon];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = @"订单消息提醒订单消息提醒订单订单消息提醒订单消息提醒";
        self.titleLabel.font = [UIFont  systemFontOfSize:15];
        [self.titleLabel sizeToFit];
        self.titleLabel.backgroundColor = [UIColor clearColor];
      
        self.titleLabel.bounds = CGRectMake(0, 0, WINDOW_WIDTH-120, self.titleLabel.frame.size.height);
          self.titleLabel.center = CGPointMake(CGRectGetMaxX(self.icon.frame) + 5 + self.titleLabel.bounds.size.width / 2, self.icon.center.y);
        [self.contentView addSubview:self.titleLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.text = @"2014-10-28";
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        [self.timeLabel sizeToFit];
        self.timeLabel.textColor = [UIColor colorWithHex:0xd4d4d4];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.center = CGPointMake(WINDOW_WIDTH - 30 - self.timeLabel.bounds.size.width / 2, self.titleLabel.center.y);
        [self.contentView addSubview:self.timeLabel];
        
        UIImage *arrow = [UIImage imageNamed:@"arrow_details_home.png"];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, arrow.size.width/2, arrow.size.height/2)];
        arrowImageView.center = CGPointMake(CGRectGetMaxX(self.timeLabel.frame) + 5 + arrow.size.width / 2, self.timeLabel.center.y);
        arrowImageView.image = arrow;
        [self.contentView addSubview:arrowImageView];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame), WINDOW_WIDTH - 20 * 2, 40)];
        self.contentLabel.text = @"中华人民共和国！中央总书记。中国军事主席习近平！以及国家重要领导人对你发的说说进行深刻的研究！习近平指出。关于你的说说很深奥，值得中华民族的儿女思考。习近平强调！要时刻学习中国梦。";
        self.contentLabel.font = [UIFont systemFontOfSize:13];
        self.contentLabel.numberOfLines = 2;
        self.contentLabel.textColor = [UIColor lightGrayColor];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.contentLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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

- (void)setType:(MessageCellType)type
{
    _type = type;
    if (_type == MessageCellTypeRead) {
        self.icon.hidden = YES;
    }
    else {
        self.icon.hidden = NO;
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setContent:(NSString *)content
{
    _content = content;
    self.contentLabel.text = _content;
}

- (void)setTime:(NSTimeInterval)time
{
    _time = time;
    self.timeLabel.text = [AppManager dateStringWithFormatter:@"YYYY-MM-dd" timeInterval:_time];
}

@end
