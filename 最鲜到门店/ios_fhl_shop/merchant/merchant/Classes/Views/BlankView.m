//
//  BlankView.m
//  FHL
//
//  Created by panume on 14-11-10.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "BlankView.h"

#define WIN_HEI_6   667
#define WIN_WEI_6   375

@interface BlankView ()

@property (nonatomic, assign) BOOL show;

@end

@implementation BlankView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image content:(NSString *)content showButton:(BOOL)show
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _show = show;
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        if (image != nil) {
            imageView.frame = CGRectMake(0, 0, WINDOW_WIDTH / WIN_WEI_6 * image.size.width, WINDOW_WIDTH / WIN_WEI_6 * image.size.height);
            imageView.center = CGPointMake(WINDOW_WIDTH / 2, self.bounds.size.height / 2 - image.size.height / 2);
            [self addSubview:imageView];
        }
      
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.text = content;
        contentLabel.font = [UIFont systemFontOfSize:16];
        contentLabel.textColor = [UIColor colorWithHex:0xcacaca];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        [contentLabel sizeToFit];
        
        if (_show) {
            self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.actionButton setTitleColor:[UIColor colorWithHex:0xfc6605] forState:UIControlStateNormal];
            [self.actionButton setTitle:@"点击返回首页抢单" forState:UIControlStateNormal];
            self.actionButton.titleLabel.font = [UIFont systemFontOfSize:18];
            [self.actionButton sizeToFit];
            [self addSubview:self.actionButton];
        }
       
        
        if (image == nil) {
            contentLabel.center = CGPointMake(WINDOW_WIDTH / 2, self.bounds.size.height / 2);
            
            if (_show) {
                contentLabel.center = CGPointMake(WINDOW_WIDTH / 2, self.bounds.size.height / 2 - contentLabel.bounds.size.height - 10);
                self.actionButton.center = CGPointMake(WINDOW_WIDTH / 2, CGRectGetMaxY(contentLabel.frame) + self.actionButton.bounds.size.height / 2);
            }
        }
        else {
            contentLabel.center = CGPointMake(WINDOW_WIDTH / 2, CGRectGetMaxY(imageView.frame) + 5 + contentLabel.bounds.size.height / 2);
        }
        [self addSubview:contentLabel];
        
    }
    return self;
}

@end
