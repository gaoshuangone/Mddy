//
//  CommonUtils+Views.h
//  CommonUtils
//
//  Created by gs on 15/1/22.
//  Copyright (c) 2015年 gaos. All rights reserved.
//

#import "CommonUtils.h"

@interface CommonUtils (Views)
//新加的
+(void)hudShowWithViewcontroller:(id)viewcontroller;//显示活动指示器
+(void)hudHideWithViewcontroller:(id)viewcontroller;//隐藏活动指示器
//+(UIBarButtonItem*)BarButtonItemwithImageName:(NSString*)imageName withTitle:(NSString*)title;


+(NSString *)stringNoNetwork;//没有网络的提示
+(NSString *)stringNoFormat;//获取到的数据格式不正确时的提示
                            //############################设置颜色转换##############################

+(UIColor *) getColor:(NSString *) string;


//############################设置图片##############################
+(UIImageView*)commonImageViewWithFrame:(CGRect)frame withImageName:(NSString*)imageName;


+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

//获取图片
+(UIImageView *) getViewImage:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc;

+(UIImageView *) getViewImage:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc trans:(double) trans;
//设置图片
+(void) setViewImage:(UIView *)view left:(CGFloat)left top:(CGFloat)top imgSrc:(NSString *)imgSrc;










//############################设置UIView#############################################################################################

/*
 返回一条线，主要用作填充tableView上的颜色
 */
+(UIView*)CommonViewLineWithFrame:(CGRect)frame;

//############################设置UIButton#############################################################################################

/*
 UIBarButtonItem返回
 */
+(UIBarButtonItem*)commonButtonItemWithTarget:(id)target withAction:(SEL)action withImageNameIndex:(NSInteger)index;
/*
 隐藏的button，主要用作点击响应
 */
+(UIButton*)commonButtonWithFrame:(CGRect)frame withTarget:(id)target withAction:(SEL)action;
/*
 固定尺寸的button
 */
+(UIButton*)commonButNormalWithFrame:(CGRect)frame withBounds:(CGSize)bounds withOriginX:(CGFloat)x withOriginY:(CGFloat)y isRelativeCoordinate:(BOOL)isRC withTarget:(id)target withAction:(SEL)action;
/*
 调整button属性
 */
+(void)commonButSetWithButton:(UIButton*)button WithImageName:(NSString*)imageName withTitle:(NSString*)title withFontSize:(NSInteger)size withColor:(UIColor*)color;

//############################设置标签文字############################################################################################
/*
 只返回一行的label
 isRelativeCoordinate：是否是相对坐标（即加上自身的Wide，Hight的一半）
 */
+(UILabel *)commonSignleLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize withOriginX:(CGFloat)x withOriginY:(CGFloat)y isRelativeCoordinate:(BOOL)isRC;
/*
 返回多行的label
 相对坐标（即加上自身的Wide，Hight的一半）
 */
+(UILabel *)commonMoreLabelWithText:(NSString*)text withFontSize:(CGFloat)fontSize withBoundsWide:(CGFloat)boundsWide withOriginX:(CGFloat)x withOriginY:(CGFloat)y;













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


