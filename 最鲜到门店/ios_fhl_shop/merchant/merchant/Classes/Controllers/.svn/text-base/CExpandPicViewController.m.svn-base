//
//  CExpandPicViewController.m
//  FHL
//
//  Created by 郏国上 on 14-11-19.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "CExpandPicViewController.h"

@interface CExpandPicViewController () <UIScrollViewDelegate>

@property (nonatomic, assign) float imageWith;
@property (nonatomic, assign) float imageHeight;
@property(retain,nonatomic)UIScrollView *scrollerView;
@property(retain,nonatomic)UIImageView *imageView;
@property(retain,nonatomic)UIImageView *imageViewBG;

@end

@implementation CExpandPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    // Do any additional setup after loading the view from its nib.
    if(_image == nil)
    {
        return;
        //[self dismissViewControllerAnimated:NO completion:nil];
    }
    float iWidth = _image.size.width;
    float iHeight = _image.size.height;
    float rate = 2.0;
    if((iHeight > WINDOW_HEIGHT) || (iWidth > WINDOW_WIDTH))
    {
        //        if((iHeight/WINDOW_HEIGHT) > (iWidth/WINDOW_WIDTH))
        //        {
        //            if(2*WINDOW_HEIGHT > iHeight)
        //            {
        //                rate = 2*WINDOW_HEIGHT/iHeight;
        //            }
        //            else
        //            {
        //                rate = 2.0;
        //            }
        //        }
        //        else
        //        {
        //            if(2*WINDOW_WIDTH > iWidth)
        //            {
        //                rate = 2*WINDOW_WIDTH/iWidth;
        //            }
        //            else
        //            {
        //                rate = 2.0;
        //            }
        //        }
        rate = 2.0;
    }
    else if(WINDOW_WIDTH*1000/iWidth >= (WINDOW_HEIGHT)*1000/iHeight)
    {
        //        rate = WINDOW_HEIGHT/iHeight;
        rate = WINDOW_WIDTH*2.0/iWidth;
        //        if(rate < 2.0)
        //        {
        //            rate = 2.0;
        //        }
    }
    else if(WINDOW_WIDTH*1000/iWidth < (WINDOW_HEIGHT)*1000/iHeight)
    {
        //        rate = WINDOW_WIDTH/iWidth;
        //        if(rate < 2.0)
        //        {
        //            rate = 2.0;
        //        }
        rate = WINDOW_WIDTH*2.0/iHeight;
    }
    
    
    //    float OriWith = 32;
    //    float OriHeight = 32;
    _imageViewBackground.backgroundColor = [UIColor colorWithHex:0x000000 alpha:1.0];
    //    _imageWith = WINDOW_WIDTH - 64;
    //    _imageHeight = iHeight *_imageWith/iWith;
    //    if(_imageHeight >= WINDOW_HEIGHT)
    //    {
    //        _imageHeight = WINDOW_HEIGHT - 64;
    //        _imageWith = iWith *_imageHeight/iHeight;
    //        OriHeight = 32;
    //        OriWith = (WINDOW_WIDTH - _imageWith)/2;
    //    }
    //    else
    //    {
    //        OriWith = 32;
    //        OriHeight = (WINDOW_HEIGHT - _imageHeight)/2;
    //    }
    //
    //    _imageViewExpandPic = [[UIImageView alloc]initWithFrame:CGRectMake(OriWith, OriHeight, _imageWith, _imageHeight)];
    //    _imageViewExpandPic.backgroundColor = [UIColor clearColor];
    //    _imageViewExpandPic.image = _image;
    //    _imageViewExpandPic.userInteractionEnabled = YES;
    //    _imageViewExpandPic.hidden = NO;
    //    [self.view addSubview:_imageViewExpandPic];
    //    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBackGround)];
    //    [_imageViewExpandPic addGestureRecognizer:singleTap];
    //[self.view addSubview:_imageViewBackground];
    
    _imageViewBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)];
    _imageViewBG.backgroundColor = [UIColor colorWithHex:0x000000 alpha:1.0];
    //_imageViewBG.image = _image;
    _imageViewBG.userInteractionEnabled = YES;
    _imageViewBG.hidden = NO;
    
    _scrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)];
    _scrollerView.delegate=self;
    _scrollerView.minimumZoomScale=0.5f;
    _scrollerView.maximumZoomScale= rate;
    
    //    if((iHeight > WINDOW_HEIGHT) || (iWidth > WINDOW_WIDTH))
    {
        if(iWidth * 1000/WINDOW_WIDTH >= iHeight*1000/(WINDOW_HEIGHT))
        {
            iHeight = iHeight*WINDOW_WIDTH/iWidth;
            iWidth = WINDOW_WIDTH;
        }
        else
        {
            iWidth = iWidth * (WINDOW_HEIGHT)/iHeight;
            iHeight = WINDOW_HEIGHT;
        }
    }
    
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((WINDOW_WIDTH - iWidth)/2, (WINDOW_HEIGHT - iHeight)/2, iWidth, iHeight)];
    
    
    _imageView.userInteractionEnabled = YES;
    [_imageView setImage:_image];
    
    
    [_scrollerView addSubview:_imageViewBG];
    [_scrollerView addSubview:_imageView];
    
    [self.view addSubview:_scrollerView];
    
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBackGround)];
    [_imageViewBG addGestureRecognizer:singleTap];
    
    _imageViewBackground.hidden = NO;
    _imageViewBackground.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *bGSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBackGround)];
    [_imageView addGestureRecognizer:bGSingleTap];
    
    UITapGestureRecognizer *backGroundSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBackGround)];
    [_imageViewBackground addGestureRecognizer:backGroundSingleTap];
}

- (UIStatusBarStyle)preferredStatusBarStyle

{
    
    return UIStatusBarStyleLightContent;
    
}

- (BOOL)prefersStatusBarHidden

{
    
    return NO;
    
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (id view in [_scrollerView subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            {
                //                CGPoint centerPoint = self.view.center;
                //                _imageView.center = centerPoint;
                if(_imageView ==  ((UIImageView *)view))
                {
                    return view;
                }
                
            }
        }
    }
    return  nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    
    //FLDDLogDebug(@"_imageView.frame.size.width:%f, _imageView.frame.size.height:%f", _imageView.frame.size.width, _imageView.frame.size.height);
    if((_imageView.frame.size.width <= WINDOW_WIDTH) && (_imageView.frame.size.height <= WINDOW_HEIGHT))
    {
        CGPoint centerPoint = self.view.center;
        _imageView.center = centerPoint;
    }
    
}

- (void)onClickBackGround
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
