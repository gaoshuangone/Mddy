//
//  PromptView.m
//  FHL
//
//  Created by panume on 15/7/1.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "PromptView.h"

@implementation PromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        float rate = WINDOW_HEIGHT / WIN_HEI_6;

        
        self.backgroundColor = [UIColor colorWithHex:0x000 alpha:0.8];
        UIImage *image1 = [UIImage imageNamed:@"order_num"];
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rate * image1.size.width, rate * image1.size.height)];
        imageView1.image = image1;
        imageView1.center = CGPointMake(WINDOW_WIDTH - 30 - imageView1.bounds.size.width / 2, 42  + imageView1.bounds.size.height / 2);
        [self addSubview:imageView1];
        
        UIImage *image4 = [UIImage imageNamed:@"dismiss_button"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, rate * image4.size.width, rate * image4.size.height);
        button.center = CGPointMake(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2);
        [button setBackgroundImage:image4 forState:UIControlStateNormal];
        [button addTarget:self action:@selector(hideButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];

        
        UIImage *image3 = [UIImage imageNamed:@"quick_order"];
        UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rate * image3.size.width, rate * image3.size.height)];
        imageView3.image = image3;
        imageView3.center = CGPointMake(WINDOW_WIDTH - 21 - imageView3.bounds.size.width / 2, WINDOW_HEIGHT - 17 - imageView3.bounds.size.height / 2);
        [self addSubview:imageView3];
        

        
    }
    return self;
}

- (IBAction)hideButtonPressed:(id)sender
{
    [AppManager setUserBoolValue:YES key:@"HasPrompt"];
    [self removeFromSuperview];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push) name:PUSH object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:PUSH object:self];
}

@end
