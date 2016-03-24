//
//  AnimatedView.m
//  FHL
//
//  Created by panume on 14/12/15.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//
#define WIN_WEI_6   375
#import "AnimatedView.h"



@interface AnimatedView ()

@property (nonatomic, strong) UIImage *animateImage;
@property (nonatomic, strong) UIImageView *baseImageView;
@property (nonatomic, strong) UILabel *remarkLabel;
@property (nonatomic, strong) UIImageView *pointImageView;
@end

@implementation AnimatedView

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName remark:(NSString *)remark
{
    self = [super initWithFrame:frame];
    if (self) {
        _remark = remark;
        _imageStr = imageName;
        self.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
        
        [self addTarget:self action:@selector(backgroundTouched:) forControlEvents:UIControlEventTouchUpInside];
        self.userInteractionEnabled = NO;
        
        NSArray *imageNames = @[@"logo_watermark_run1.png", @"logo_watermark_run2.png", @"logo_watermark_run3.png",@"logo_watermark_run4.png", @"logo_watermark_run5.png", @"logo_watermark_run6.png", @"logo_watermark_run7.png", @"logo_watermark_run8.png", @"logo_watermark_run9.png", @"logo_watermark_run10.png", @"logo_watermark_run11.png", @"logo_watermark_run12.png"];
        
        NSMutableArray *images = [NSMutableArray array];
        for (NSString *name in imageNames) {
            [images addObject:[UIImage imageNamed:name]];
        }
        
        UIImage *image = [UIImage imageNamed:@"logo_watermark_run12.png"];
        
        self.baseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH / WIN_WEI_6 * image.size.width, WINDOW_WIDTH / WIN_WEI_6 * image.size.height)];
        
        self.baseImageView.center = CGPointMake(WINDOW_WIDTH / 2, self.bounds.size.height / 2 - image.size.height / 2);
        self.baseImageView.image = image;
        self.baseImageView.animationImages = images;
        self.baseImageView.animationDuration = 11;
        self.baseImageView.animationRepeatCount = 1;
        
        
        self.remarkLabel = [[UILabel alloc] init];
        self.remarkLabel.textColor = [UIColor colorWithHex:0x999999];
        self.remarkLabel.font = [UIFont systemFontOfSize:16];
        self.remarkLabel.text = @"正在努力加载中";
        [self.remarkLabel sizeToFit];
        self.remarkLabel.textAlignment = NSTextAlignmentCenter;
        self.remarkLabel.center = CGPointMake(WINDOW_WIDTH / 2, CGRectGetMaxY(self.baseImageView.frame) + 5 + self.remarkLabel.bounds.size.height / 2);
        [self addSubview:self.remarkLabel];
        self.remarkLabel.text = _remark;
        
        UIImage *processImage = [UIImage imageNamed:@"point_progress-loading_3.png"];
        
        self.pointImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, processImage.size.width, processImage.size.height)];
        self.animateImage = [UIImage animatedImageNamed:@"point_progress-loading_" duration:1.2];
        self.pointImageView.image = self.animateImage;
        self.pointImageView.center = CGPointMake(CGRectGetMaxX(self.remarkLabel.frame) + processImage.size.width / 2, self.remarkLabel.center.y + 5);
        [self addSubview:self.pointImageView];
        
        [self addSubview:self.baseImageView];
        
        [self.baseImageView startAnimating];
    }
    return self;
}

- (void)setRemark:(NSString *)remark
{
    _remark = remark;
    self.remarkLabel.text = _remark;
}

- (void)stopAnimate
{
 
    [self stopAnimateWithState:AnimatedViewStateFailed];
}

- (void)startAnimate
{
    
    UIImage *image = [UIImage imageNamed:@"logo_watermark_run12.png"];

    self.remarkLabel.text = @"正在努力加载中";
    self.baseImageView.image = nil;
    self.baseImageView.image = image;
    [self.baseImageView startAnimating];
    [self.remarkLabel sizeToFit];
    self.pointImageView.hidden = NO;
    self.remarkLabel.center = CGPointMake(WINDOW_WIDTH / 2, CGRectGetMaxY(self.baseImageView.frame) + 5 + self.remarkLabel.bounds.size.height / 2);
    self.userInteractionEnabled = NO;
}

- (void)stopAnimateWithState:(AnimatedViewState)state
{
    NSString *remark = @"";
    switch (state) {
        case AnimatedViewStateLoading:
            remark = @"正在努力加载中";
            break;
        case AnimatedViewStateSuccess:
            remark = @"加载成功";
            break;
        case AnimatedViewStateFailed:
            remark = @"点击屏幕，重新加载";
            
            
            break;
        default:
            break;
    }
    self.remarkLabel.text = remark;
    
    UIImage *image = [UIImage imageNamed:@"logo_watermark_home.png"];
    [self.baseImageView stopAnimating];
    
    self.baseImageView.image = nil;
    self.baseImageView.image = image;
    self.userInteractionEnabled = YES;
    
    self.pointImageView.hidden = YES;
    [self.remarkLabel sizeToFit];
    self.remarkLabel.center = CGPointMake(WINDOW_WIDTH / 2, CGRectGetMaxY(self.baseImageView.frame) + 5 + self.remarkLabel.bounds.size.height / 2);
}

- (IBAction)backgroundTouched:(id)sender
{
    [self.delegate11 doChangeAnimate];
//    if (self.touchAction) {
//        self.touchAction();
//        [self startAnimate];
//    }
//    else {
//        if (<#condition#>) {
//            <#statements#>
//        }
//    }
}

- (void)setAnimatedState:(AnimatedViewState)animatedState
{
    _animatedState = animatedState;
    switch (_animatedState) {
        case AnimatedViewStateLoading:
            [self startAnimate];
            break;
        case AnimatedViewStateSuccess:
        case AnimatedViewStateFailed:
            [self stopAnimateWithState:_animatedState];
            break;
        default:
            break;
    }
}

@end
