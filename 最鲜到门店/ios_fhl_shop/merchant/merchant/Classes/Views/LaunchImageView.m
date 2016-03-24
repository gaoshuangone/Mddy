//
//  LaunchImageView.m
//  FHL
//
//  Created by panume on 14/12/15.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//
#define WIN_HEI_6   667
#define WIN_WEI_6   375
#define WIN_HEI_5   568
#define WIN_HEI_4   480
#define WIN_HEI_6P  736
#import "LaunchImageView.h"

@interface LaunchImageView()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIView *netView;
@property (nonatomic, strong) UIImageView *animateView;
@end

@implementation LaunchImageView

- (instancetype)initWithFrame:(CGRect)frame remind:(NSString *)remind
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor orangeColor];
        
        _remind = remind;

        UIImage *image = nil;
        
        if (WINDOW_HEIGHT == WIN_HEI_4) {
            image = [UIImage imageNamed:@"business_loading_wel_4s.png"];
        }
        
        if (WINDOW_HEIGHT == WIN_HEI_5) {
            image = [UIImage imageNamed:@"business_loading_wel_5s.png"];
        }
        
        if (WINDOW_HEIGHT == WIN_HEI_6) {
            image = [UIImage imageNamed:@"business_loading_wel_6-1.png"];
        }
        
        if (WINDOW_HEIGHT == WIN_HEI_6P) {
            image = [UIImage imageNamed:@"business_loading_wel_6-1.png"];
        }
        
        self.imageView = [[UIImageView alloc] initWithImage:image];
        self.imageView.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT);
        [self addSubview:self.imageView];
        
        
        self.remindLabel = [[UILabel alloc] init];
        self.remindLabel.text = _remind;
        self.remindLabel.textColor = [UIColor colorWithHex:0xfec2ad];
        self.remindLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.remindLabel sizeToFit];
        self.remindLabel.center  = CGPointMake(WINDOW_WIDTH / 2 - 20, WINDOW_HEIGHT * 275 / WIN_HEI_6);
        [self addSubview:self.remindLabel];
        
        UIImage *animateImage = [UIImage animatedImageNamed:@"point_loading_" duration:1.2];
        
        self.animateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, animateImage.size.width, animateImage.size.height)];
        self.animateView.image = animateImage;
        self.animateView.center = CGPointMake(CGRectGetMaxX(self.remindLabel.frame) + 2 + self.animateView.bounds.size.width / 2, self.remindLabel.center.y);
        [self addSubview:self.animateView];
        
    }
    return self;
}






@end
