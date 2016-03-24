//
//  DirectionView1.m
//  merchant
//
//  Created by gs on 15/2/11.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "DirectionView1.h"

@implementation DirectionView1
-(id)initWithFrame:(CGRect)rect withImageArray:(NSArray*)imageArray{
    self=[super initWithFrame:rect];
    if (self) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:rect];
        self.scrollView.scrollEnabled = YES;
        self.scrollView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.bounces = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        
        CGSize size;
      
        for (int i = 0; i < imageArray.count; i ++) {
            UIImage *image =  [UIImage imageNamed:[imageArray objectAtIndex:i]];
            
            size = image.size;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, WINDOW_HEIGHT*i, WINDOW_WIDTH, WINDOW_HEIGHT)];
//            height = image.size.height * (WINDOW_WIDTH / image.size.width);
            imageView.backgroundColor = [UIColor clearColor];
            
            imageView.image = image;
            
            [self.scrollView addSubview:imageView];
        }
        
        [self.scrollView setContentSize:CGSizeMake(WINDOW_WIDTH, WINDOW_HEIGHT* imageArray.count)];
      
        self.button =[UIButton buttonWithType:UIButtonTypeCustom];
//        self.button.backgroundColor = [UIColor redColor];
          self.button.hidden =YES;
        self.button.frame = CGRectMake(0, 10, 160, 50);
        self.button.center = CGPointMake(WINDOW_WIDTH/2, WINDOW_HEIGHT/7*6);
        [self.button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];

    }
        
    
    return self;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int page = scrollView.contentOffset.y / WINDOW_HEIGHT;
    
    if (page == 0) {
        self.button.hidden =YES;
    }
    if (page == 1) {
        self.button.hidden =YES;
    }
    if (page==2) {
        self.button.hidden = NO;
    }
    
}
-(void)buttonPressed{
    if (self.DismissAction) {
        self.DismissAction();
    }
    if (self) {
        [self removeFromSuperview];
        [AppManager setUserBoolValue:YES key:@"HasLaunchedOnce"];
    }
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
