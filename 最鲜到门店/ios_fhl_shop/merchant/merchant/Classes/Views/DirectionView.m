//
//  DirectionView.m
//  FHL
//
//  Created by panume on 14-11-12.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "DirectionView.h"

@interface DirectionView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *dismissButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSString *desc;

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *contents;
@end

@implementation DirectionView

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images contents:(NSArray *)contents
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        
        _images = images;
        _contents = contents;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.scrollEnabled = YES;
        self.scrollView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.bounces = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        CGSize size;
        CGFloat height = 0.0;
        CGFloat pageControlOriD = 18;
        CGFloat dismissButtonOriD = 38;
        CGFloat desLabelOriD = 25;
        
        
        for (int i = 0; i < _images.count; i ++) {
            UIImage *image = [_images objectAtIndex:i];
            
            size = image.size;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WINDOW_WIDTH * i, 0, WINDOW_WIDTH, image.size.height * (WINDOW_WIDTH / image.size.width))];
            height = image.size.height * (WINDOW_WIDTH / image.size.width);
            imageView.backgroundColor = [UIColor clearColor];
            
            imageView.image = image;
            
            [self.scrollView addSubview:imageView];
        }
        
        [self.scrollView setContentSize:CGSizeMake(WINDOW_WIDTH * _images.count, WINDOW_HEIGHT)];
        if(iPhone6)
        {
            pageControlOriD = 18;
            dismissButtonOriD = 38;
            desLabelOriD = 25;
        }
        else if(iPhone5)
        {
            pageControlOriD = 18;
            dismissButtonOriD = pageControlOriD * 568/667;
            desLabelOriD = pageControlOriD * 568/667;
        }
        else
        {
            pageControlOriD = 18;
            dismissButtonOriD = pageControlOriD * 480/667 - 10;
            desLabelOriD = pageControlOriD * 480/667 - 10;
        }
        //        pageControlOriD = pageControlOriD * height/(667 - height);
        //        dismissButtonOriD = pageControlOriD * height/(667 - height);
        //        desLabelOriD = pageControlOriD * height/(667 - height);
        //        FLDDLogDebug(@"d: %f", (WINDOW_WIDTH - height) - (pageControlOriD + dismissButtonOriD + desLabelOriD + 42 + 50 + 10));
        //        if((WINDOW_WIDTH - height) - (pageControlOriD + dismissButtonOriD + desLabelOriD + 42 + 25 + 10)  < 10)
        //        {
        //            dismissButtonOriD = dismissButtonOriD - 10;
        //            desLabelOriD = desLabelOriD - 10;
        //        }
        
        
        UIImage *normalImage = [UIImage imageNamed:@"button_wel_n.png"];
        UIImage *highlightImage = [UIImage imageNamed:@"button_wel_p.png"];
        
        highlightImage = [highlightImage stretchableImageWithLeftCapWidth:highlightImage.size.width * 0.5 topCapHeight:highlightImage.size.height * 0.5];
        normalImage = [normalImage stretchableImageWithLeftCapWidth:normalImage.size.width * 0.5 topCapHeight:normalImage.size.height * 0.5];
        
        self.dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.dismissButton.frame = CGRectMake(0, 0, WINDOW_WIDTH - 68, 42);
//        [self.dismissButton setBackgroundImage:normalImage forState:UIControlStateNormal];
//        [self.dismissButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//        [self.dismissButton setTitle:@"立即体验" forState:UIControlStateNormal];
//        [self.dismissButton setBackgroundColor:[UIColor redColor]];
        
        [self.dismissButton addTarget:self action:@selector(dismissButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        //self.dismissButton.center = CGPointMake(WINDOW_WIDTH / 2, WINDOW_HEIGHT - WINDOW_HEIGHT * 90 / 667 + self.dismissButton.bounds.size.height / 2);
//        self.dismissButton.center = CGPointMake(WINDOW_WIDTH / 2, WINDOW_HEIGHT - (pageControlOriD + dismissButtonOriD + 10 + 21));
           self.dismissButton.center = CGPointMake(WINDOW_WIDTH / 2, WINDOW_HEIGHT - (pageControlOriD + dismissButtonOriD + 10 + +10));
        self.dismissButton.hidden = YES;
        //[self.dismissButton setFont:[UIFont systemFontOfSize:16]];
        self.dismissButton.titleLabel.font = [UIFont systemFontOfSize: 16.0];
        //[self.dismissButton setFont:[UIFont systemFontSize:16]]
        //self.dismissButton.titleLabel.textColor =[UIColor colorWithHex:0xfc6605];
        [self.dismissButton setTitleColor:[UIColor colorWithHex:0xfc6605] forState:UIControlStateNormal];
        [self addSubview:self.dismissButton];
        
//        self.desLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH - 32, 50)];
//        self.desLabel.text = @"为商家提供配送服务\n一键发单";
//        self.desLabel.font = [UIFont systemFontOfSize:20];
//        self.desLabel.textColor = [UIColor colorWithHex:0x737373];
//        self.desLabel.textAlignment = NSTextAlignmentCenter;
//        self.desLabel.backgroundColor = [UIColor clearColor];
        
        FLDDLogDebug(@"%lf",WINDOW_HEIGHT - CGRectGetMinY(self.dismissButton.frame) - height);
        self.desLabel.numberOfLines = 0;
        //self.desLabel.center = CGPointMake(self.bounds.size.width / 2, height + (CGRectGetMinY(self.dismissButton.frame) - height) / 2.5 );
        self.desLabel.center = CGPointMake(self.bounds.size.width / 2, WINDOW_HEIGHT - (pageControlOriD + dismissButtonOriD + desLabelOriD + 42 + 25 + 10));
        [self addSubview:self.desLabel];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 84, 10)];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHex:0xfc6605];
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithHex:0xcdcdcd];
        //self.pageControl.center = CGPointMake(WINDOW_WIDTH / 2, (CGRectGetMaxY(self.desLabel.frame) + CGRectGetMinY(self.dismissButton.frame)) / 2 - 3);
        self.pageControl.center = CGPointMake(WINDOW_WIDTH / 2, WINDOW_HEIGHT - pageControlOriD + 5);
        self.pageControl.currentPage = 2;
        self.pageControl.numberOfPages = _images.count;
        [self addSubview:self.pageControl];
        
        
        
        
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    int page = scrollView.contentOffset.x / WINDOW_WIDTH;
//    
//    self.pageControl.currentPage = page;
//    for (int i = 0 ; i < self.contents.count; i ++) {
//        if (page == i) {
//            self.desc = self.contents[i];
//        }
//        NSLog(@"%d",self.contents.count - 1);
//        if(page == self.contents.count - 1)
//        {
//            self.dismissButton.hidden = NO;
//        }
//        else
//        {
//            self.dismissButton.hidden = YES;
//        }
//    }
    int page = scrollView.contentOffset.x / WINDOW_WIDTH;
    
    self.pageControl.currentPage = page;
    for (int i = 0 ; i < self.images.count; i ++) {
        if (page == i) {
            self.desc = self.images[i];
        }
        NSLog(@"%ld",(long)(self.images.count - 1));
        if(page == self.images.count - 1)
        {
            self.dismissButton.hidden = NO;
        }
        else
        {
            self.dismissButton.hidden = YES;
        }
    }
}

- (void)setDesc:(NSString *)desc
{
    _desc = desc;
    
//    CGSize size = [_desc sizeWithFont:self.desLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, WINDOW_WIDTH - 80) lineBreakMode:NSLineBreakByWordWrapping];
//    size [_desc boundingRectWithSize:CGSizeMake(MAXFLOAT, WINDOW_WIDTH - 80)  options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : self.desLabel.font} context:nil];
    
//    self.desLabel.frame = CGRectMake(self, 0, <#CGFloat width#>, <#CGFloat height#>)
    
    self.desLabel.text = _desc;
}

- (IBAction)dismissButtonPressed:(id)sender
{
    if (self.DismissAction) {
        self.DismissAction();
    }
    if (self) {
        [self removeFromSuperview];
        [AppManager setUserBoolValue:YES key:@"HasLaunchedOnce"];
    }


}

@end
