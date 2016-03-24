//
//  ViewHelper.m
//  chesudi
//
//  Created by zly on 13-1-9.
//  Copyright (c) 2013年 Rocky. All rights reserved.
//

#import "ViewHelper.h"

@implementation ViewHelper

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
    
    int red,green,blue;
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



//############################设置文字###############################

+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top text:(NSString *)text
{
    UIFont *font=[UIFont fontWithName:@"Arial" size:14];
    return [self getViewLabel:left top:top text:text font:font];
}


+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font
{
    CGSize labelSize=[text sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT,MAXFLOAT)];    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(left, top, labelSize.width, labelSize.height)];
    label.text=text;
    [label setFont:font];
    return label;
}

+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top width:(CGFloat)width text:(NSString *)text font:(UIFont *)font
{
    CGSize labelSize=[text sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT,MAXFLOAT)]; 
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
    [ViewHelper setViewImage:mainView left:10 top:10 imgSrc:imgSrc];
    [ViewHelper setViewLabel:mainView left:45 top:13 text:text font:[UIFont systemFontOfSize:20]];
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
    [ViewHelper setViewLabel:mainView left:20 top:10 text:text font:[UIFont systemFontOfSize:16]];
    
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
    CGSize size=CGSizeMake(width, 2000);
    CGSize labelSize=[text sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return labelSize.height;
}
@end
