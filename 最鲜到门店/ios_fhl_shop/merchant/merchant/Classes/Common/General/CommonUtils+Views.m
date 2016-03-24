//
//  CommonUtils+Views.m
//  CommonUtils
//
//  Created by gs on 15/1/22.
//  Copyright (c) 2015年 gaos. All rights reserved.
//

#import "CommonUtils+Views.h"

@implementation CommonUtils (Views)


//+(UIBarButtonItem*)BarButtonItemwithImageName:(NSString*)imageName withTitle:(NSString*)title;
////    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
////if(imageName= nil){
////        [button setTitle:@"取消" forState:UIControlStateNormal];
////}
////    [button setImage:[UIImage imageNamed:@"backNOTitle.png"] forState:UIControlStateNormal];
////
////    button.frame = CGRectMake(0, 0, 40 , 40);
////    [button setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
////    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
////    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
////    self.navigationItem.leftBarButtonItem = rithtBarItem ;
//
//}


#pragma mark 显示活动指示器
+(void)hudShowWithViewcontroller:(id)viewcontroller
{
    UIViewController* viewc=viewcontroller;
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:viewc.view];
    [viewc.view addSubview:hud];
    hud.labelText = @"加载中...";
    hud.tag =101;
    [hud show:YES];
}
#pragma  mark 隐藏活动指示器
+(void)hudHideWithViewcontroller:(id)viewcontroller
{
    UIViewController* viewc=viewcontroller;
    MBProgressHUD* hud =(MBProgressHUD*)[viewc.view viewWithTag:101];
    [hud hide:YES];
    [hud removeFromSuperview];
    hud = nil;
}

//############################设置颜色转换##############################

+(NSString *)stringNoNetwork
{
    return @"获取信息失败，请检查你的网络是否已连接";
}
+(NSString *)stringNoFormat
{
    return @"获取数据失败，请重试！";
}
+(UIColor *) getColor:(NSString *) string
{
    if([string length]!=7) return nil; //必须为7位 #ff0000;
    NSString *res=[string uppercaseString];//转成大写
    
    int red = 0, green = 0,blue = 0;
    const char *hex_char1=[res UTF8String];
    for(int i=1,k=0;k<3;i++,k++)
    {
        if(k==0)
        {
            red=[self numColor:hex_char1[i] num:2];
            red+=[self numColor:hex_char1[++i] num:1];
        }
        else if(k==1)
        {
            green=[self numColor:hex_char1[i] num:2];
            green+=[self numColor:hex_char1[++i] num:1];
        }
        else if(k==2)
        {
            blue=[self numColor:hex_char1[i] num:2];
            blue+=[self numColor:hex_char1[++i] num:1];
        }
        
    }
    
    UIColor *color=[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    return color;
}

//1为个位,2为十位
+(int) numColor:(char)c num:(int)num
{
    int int_ch1;
    //如果为个位
    if(num==1)
    {
        if(c >= '0' && c <='9')
            int_ch1 = c-48;   //// 0 的Ascll - 48
        else if(c >= 'A' && c <='F')
            int_ch1 = c-55; //// A 的Ascll - 65
        else
            return -1;
    }
    else if(num==2)
    {
        if(c >= '0' && c <='9')
            int_ch1 = (c-48)*16;   //// 0 的Ascll - 48
        else if(c >= 'A' && c <='F')
            int_ch1 = (c-55)*16; //// A 的Ascll - 65
        else
            return 0;
    }
    return int_ch1;
}
//############################设置图片###############################
//等比例缩放图片
+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

//获取图片
+(UIImageView *) getViewImage:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc
{
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(left, top, 0, 0)];
    imgView.image=[UIImage imageNamed:imgSrc];
    [imgView sizeToFit];
    return imgView;
}

//获取图片
+(UIImageView *) getViewImage:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc trans:(double) trans
{
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(left, top, 0, 0)];
    UIImage *image=[UIImage imageNamed:imgSrc];
    imgView.image=[self scaleImage:image toScale:trans];
    [imgView sizeToFit];
    return imgView;
    
    // imgView.transform=CGAffineTransformMakeScale(trans,trans);
    
}

//设置图片
+(void) setViewImage:(UIView *)view left:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc
{
    [view addSubview:[self getViewImage:left top:top imgSrc:imgSrc]];
}

//############################设置UIButton#############################################################################################

/*
 UIBarButtonItem返回
 */

+(UIBarButtonItem*)commonButtonItemWithTarget:(id)target withAction:(SEL)action withImageNameIndex:(NSInteger)index{
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (index==0) {
            [button setImage:[UIImage imageNamed:@"memu_home_n.png"] forState:UIControlStateNormal];
         button.frame = CGRectMake(0, 0, 20, 20);
    }
   else if (index==1) {
        [button setImage:[UIImage imageNamed:@"navigation_returnback.png"] forState:UIControlStateNormal];
           button.frame = CGRectMake(0, 0, 20, 20);
   }else{
       
   }


    
    UIBarButtonItem* leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return leftBarItem;

}
//############################设置UIView#############################################################################################

/*
 返回一条线，主要用作填充tableView上的颜色
 */
+(UIView*)CommonViewLineWithFrame:(CGRect)frame{
    UIView* view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.35;
    return view;
}

/*
 隐藏的button，主要用作点击响应
 */
+(UIButton*)commonButtonWithFrame:(CGRect)frame withTarget:(id)target withAction:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom]; //创建button
    [btn setFrame:frame]; //设置button的frame
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
/*
 固定尺寸的button
 */
+(UIButton*)commonButNormalWithFrame:(CGRect)frame withBounds:(CGSize)bounds withOriginX:(CGFloat)x withOriginY:(CGFloat)y isRelativeCoordinate:(BOOL)isRC withTarget:(id)target withAction:(SEL)action{
    
    UIButton* button = [CommonUtils commonButtonWithFrame:frame withTarget:target withAction:action];
    
    button.bounds = CGRectMake(0, 0, bounds.width, bounds.height);
    if (isRC) {
        button.center = CGPointMake(x+button.bounds.size.width/2, y+button.bounds.size.height/2);
    }else{
        button.center = CGPointMake(x,y);
    }

    return button;
    
}
/*
 调整button属性
 */
+(void)commonButSetWithButton:(UIButton*)button WithImageName:(NSString*)imageName withTitle:(NSString*)title withFontSize:(NSInteger)size withColor:(UIColor*)color{
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        return;
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (size) {
        button.titleLabel.font =[UIFont systemFontOfSize:size];
    }
    if (color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
}

//############################设置图片###############################
+(UIImageView*)commonImageViewWithFrame:(CGRect)frame withImageName:(NSString*)imageName{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    return imageView;
    
    
}


//############################设置文字###############################
/*
 只返回一行的label
 isRelativeCoordinate：是否是相对坐标（即加上自身的Wide，Hight的一半）
 */
+(UILabel *)commonSignleLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize withOriginX:(CGFloat)x withOriginY:(CGFloat)y isRelativeCoordinate:(BOOL)isRC{
    UILabel* label =[[UILabel alloc]init];
    label.text =text;
    label.font = [UIFont systemFontOfSize:fontSize];
    [label sizeToFit];
    if (isRC) {
        label.center = CGPointMake(x+label.bounds.size.width/2, y+label.bounds.size.height/2);
    }else{
        label.center = CGPointMake(x,y);
    }
    return label;
    
}
/*
 返回多行的label
 相对坐标（即加上自身的Wide，Hight的一半）
 */
+(UILabel *)commonMoreLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize withBoundsWide:(CGFloat)boundsWide withOriginX:(CGFloat)x withOriginY:(CGFloat)y{
    UILabel* label =[[UILabel alloc]init];
    label.text =text;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.bounds = CGRectMake(0, 0, boundsWide, MAXFLOAT);
    [label sizeToFit];
    label.center = CGPointMake(x+label.bounds.size.width/2, y+label.bounds.size.height/2);
    
    return label;
    
}













+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top text:(NSString *)text
{
    UIFont *font=[UIFont fontWithName:@"Arial" size:14];
    return [self getViewLabel:left top:top text:text font:font];
}


+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font
{
//    CGSize labelSize=[text sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT,MAXFLOAT)];
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){MAXFLOAT, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize labelSize = rect.size;
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(left, top, labelSize.width, labelSize.height)];
    label.text=text;
    [label setFont:font];
    return label;
}

+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top width:(CGFloat)width text:(NSString *)text font:(UIFont *)font
{
//    CGSize labelSize=[text sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT,MAXFLOAT)];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){MAXFLOAT, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize labelSize = rect.size;
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(left, top, width,labelSize.height)];
    label.text=text;
    [label setFont:font];
    return label;
}

+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height text:(NSString *)text font:(UIFont *)font
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(left, top, width,height)];
    label.text=text;
    [label setFont:font];
    return label;
}

//设置字体色
+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font fontColor:(UIColor *)fontColor
{
    UILabel *label=[self getViewLabel:left top:top text:text font:font];
    label.textColor=fontColor;
    return label;
}

//设置字体色，背景色的，
+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font fontColor:(UIColor *)fontColor bgColor:(UIColor *)bgColor
{
    UILabel *label=[self getViewLabel:left top:top text:text font:font fontColor:fontColor];
    [label setBackgroundColor:bgColor];
    return label;
}


+(void) setViewLabel:(UIView *)view left:(CGFloat)left top:(CGFloat)top text:(NSString *)text
{
    
    [view addSubview:[self getViewLabel:left top:top text:text]];
}

+(void) setViewLabel:(UIView *)view left:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font
{
    
    [view addSubview:[self getViewLabel:left top:top text:text font:font]];
}

//设置字体色
+(void) setViewLabel:(UIView *)view left:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font fontColor:(UIColor *)fontColor
{
    
    [view addSubview:[self getViewLabel:left top:top text:text font:font fontColor:fontColor]];
}

//设置界面上的文字标签 //设置字体色，背景色的，
+(void) setViewLabel:(UIView *)view left:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font fontColor:(UIColor *)fontColor bgColor:(UIColor *)bgColor
{
    
    [view addSubview:[self getViewLabel:left top:top text:text font:font fontColor:fontColor bgColor:bgColor]];
}

///////////金黄色提交的按钮
+(UIButton *)getViewSubmitButton:(CGFloat)left top:(CGFloat)top width:(CGFloat)width text:(NSString *)text
{
    return [self getViewSubmitButton:left top:top width:width height:45 text:text];
}

+(UIButton *)getViewSubmitButton:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height text:(NSString *)text
{
    UIFont *font=[UIFont fontWithName:@"Arial" size:16];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(left, top, width, height);
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font=font;
    [btn setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    return btn;
}

//获取到图片的按钮
+(UIButton *)getImageButton:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom]; //创建button
    UIImage *image=[UIImage imageNamed:imgSrc];
    [btn setFrame:CGRectMake(left, top, image.size.width, image.size.height)]; //设置button的frame
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    return btn;
}

//短的金黄色提交按钮
+(UIButton *)getBtnSubmit:(CGFloat)left top:(CGFloat)top text:(NSString *)text
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(left, top, 103, 34);
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_submit.png"] forState:UIControlStateNormal];
    return btn;
}
//长的金黄色提交按钮
+(UIButton *)getBtnSubmitLong:(CGFloat)left top:(CGFloat)top text:(NSString *)text
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(left, top, 280, 48);
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:20];

    [btn setBackgroundImage:[UIImage imageNamed:@"btnLong.png"] forState:UIControlStateNormal];
    return btn;
}

//长的金黄色提交按钮
+(UIButton *)getBtnSubmitLong2:(CGFloat)left top:(CGFloat)top width:(CGFloat)width text:(NSString *)text
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(left, top, width, 35)];
    [btn setBackgroundImage:[UIImage imageNamed:@"m_btn2.png"] forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn.titleLabel setShadowOffset:CGSizeMake(1, 1)];
    return btn;
}

//短的浅色取消按钮
+(UIButton *)getBtnCancel:(CGFloat)left top:(CGFloat)top text:(NSString *)text
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(left, top, 103, 34);
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[self getColor:@"CCCCCC"] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_canncel.png"] forState:UIControlStateNormal];
    return btn;
}
///会员中心框架
+(UIView *)getMmbTitle:(NSString *)text  imgSrc:(NSString *)imgSrc top:(CGFloat)top height:(CGFloat)height
{
    CGRect rect=CGRectMake(10, top, 300, height);
    UIView *mainView=[[UIView alloc] initWithFrame:rect];
    [[mainView layer] setBorderWidth:0.5f];
    [[mainView layer] setBorderColor:[UIColor grayColor].CGColor];
    [[mainView layer] setCornerRadius:6];
    [CommonUtils setViewImage:mainView left:10 top:10 imgSrc:imgSrc];
    [CommonUtils setViewLabel:mainView left:45 top:13 text:text font:[UIFont systemFontOfSize:20]];
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 45, 300, 1)];
    [line setBackgroundColor:[UIColor darkGrayColor]];
    [mainView addSubview:line];
    
    return mainView;
}

///优惠活动框架
+(UIView *)getFavorableTitle:(NSString *)text top:(CGFloat)top height:(CGFloat)height
{
    CGRect rect=CGRectMake(10, top, 300, height);
    UIView *mainView=[[UIView alloc] initWithFrame:rect];
    [[mainView layer] setBorderWidth:0.5f];
    [[mainView layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    [[mainView layer] setCornerRadius:6];
    [CommonUtils setViewLabel:mainView left:20 top:10 text:text font:[UIFont systemFontOfSize:16]];
    
    return mainView;
}

//获取一根直线
+(UIView *)getLine:(CGFloat)left top:(CGFloat)top
{
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(left, top, 300, 1)];
    [line setBackgroundColor:[self getColor:@"#bbbbbb"]];
    return line;
}

//文本框样式
+(UITextField *)getButton:(CGRect) rect
{
    
    UITextField *textField=[[UITextField alloc] initWithFrame:rect];
    [self setTextField:textField];
    return textField;
}
+(void)setTextField:(UITextField *) textField
{
    UILabel *pad=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 5, 30)];
    textField.layer.borderWidth=1;
    textField.layer.borderColor=[UIColor grayColor].CGColor;
    [textField setReturnKeyType:UIReturnKeyDone];
    textField.leftView=pad;
    textField.leftViewMode=UITextFieldViewModeAlways;
    textField.rightView=pad;
    textField.rightViewMode=UITextFieldViewModeAlways;
    UIFont *font=[UIFont fontWithName:@"Arial" size:16.0f];
    textField.textColor=[UIColor blackColor];
    textField.font=font;
    textField.backgroundColor=[UIColor whiteColor];
    textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
}

//获取文字的高度
+(float)getLabelHeight:(NSString *)text width:(float)width font:(UIFont *)font
{
//    CGSize size=CGSizeMake(width, 2000);
//    CGSize labelSize=[text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, 2000}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize labelSize = rect.size;
    
    return labelSize.height;
}
@end


