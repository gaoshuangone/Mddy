//
//  ViewHelper.h
//  chesudi
//
//  Created by zly on 13-1-9.
//  Copyright (c) 2013年 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuartzCore/QuartzCore.h"
//#import "FTCoreTextView.h"
@interface ViewHelper : NSObject

+(NSString *)stringNoNetwork;//没有网络的提示
+(NSString *)stringNoFormat;//获取到的数据格式不正确时的提示
//############################设置颜色转换##############################

+(UIColor *) getColor:(NSString *) string;


//############################设置图片##############################
+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

//获取图片
+(UIImageView *) getViewImage:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc;

+(UIImageView *) getViewImage:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc trans:(double) trans;
//设置图片
+(void) setViewImage:(UIView *)view left:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc;


//############################设置标签文字##############################

+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top text:(NSString *)text;

+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font;

+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top width:(CGFloat)width text:(NSString *)text font:(UIFont *)font;

+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height text:(NSString *)text font:(UIFont *)font;

+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font fontColor:(UIColor *)fontColor;

//设置字体色，背景色的，
+(UILabel *) getViewLabel:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font fontColor:(UIColor *)fontColor bgColor:(UIColor *)bgColor;


+(void) setViewLabel:(UIView *)view left:(CGFloat)left top:(CGFloat)top text:(NSString *)text;


+(void) setViewLabel:(UIView *)view left:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font;

+(void) setViewLabel:(UIView *)view left:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font fontColor:(UIColor *)fontColor;

//设置界面上的文字标签 //设置字体色，背景色的，
+(void) setViewLabel:(UIView *)view left:(CGFloat)left top:(CGFloat)top text:(NSString *)text font:(UIFont *)font fontColor:(UIColor *)fontColor bgColor:(UIColor *)bgColor;

///////////金黄色提交的按钮
+(UIButton *)getViewSubmitButton:(CGFloat)left top:(CGFloat)top width:(CGFloat)width text:(NSString *)text;

+(UIButton *)getViewSubmitButton:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height text:(NSString *)text;
//获取到图片的按钮
+(UIButton *)getImageButton:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc;

//短的金黄色提交按钮
+(UIButton *)getBtnSubmit:(CGFloat)left top:(CGFloat)top text:(NSString *)text;

//长的金黄色提交按钮
+(UIButton *)getBtnSubmitLong:(CGFloat)left top:(CGFloat)top text:(NSString *)text;

//长的金黄色提交按钮
+(UIButton *)getBtnSubmitLong2:(CGFloat)left top:(CGFloat)top width:(CGFloat)width text:(NSString *)text;


//短的浅色取消按钮
+(UIButton *)getBtnCancel:(CGFloat)left top:(CGFloat)top text:(NSString *)text;

///会员中心框架
+(UIView *)getMmbTitle:(NSString *)text  imgSrc:(NSString *)imgSrc top:(CGFloat)top height:(CGFloat)height;

///优惠活动框架
+(UIView *)getFavorableTitle:(NSString *)text top:(CGFloat)top height:(CGFloat)height;

//获取一根直线
+(UIView *)getLine:(CGFloat)left top:(CGFloat)top;

//文本框样式
+(UITextField *)getButton:(CGRect) rect;
+(void)setTextField:(UITextField *) textField;


+(float)getLabelHeight:(NSString *)text width:(float)width font:(UIFont *)font;
@end
