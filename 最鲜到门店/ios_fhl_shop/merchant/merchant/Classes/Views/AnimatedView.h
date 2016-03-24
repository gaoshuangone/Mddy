//
//  AnimatedView.h
//  FHL
//
//  Created by panume on 14/12/15.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AnimateDelegate <NSObject>

-(void)doChangeAnimate;

@end
typedef NS_ENUM(NSUInteger, AnimatedViewState) {
    AnimatedViewStateLoading,
    AnimatedViewStateFailed,
    AnimatedViewStateSuccess
};

@interface AnimatedView : UIControl

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName remark:(NSString *)remark;

- (void)stopAnimate;
- (void)startAnimate;

@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *imageStr;
@property (nonatomic, assign) AnimatedViewState animatedState;
@property (strong, nonatomic) id<AnimateDelegate> delegate11;

//@property (nonatomic, copy) void(^touchAction)(void);

@end


