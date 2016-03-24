//
//  AuthCodeViewController.h
//  FHL
//
//  Created by panume on 14-9-22.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, AuthCodeType) {
    AuthCodeTypeRegister,
    AuthCodeTypeResetPassword
};

@interface AuthCodeViewController : BaseViewController

@property (nonatomic, assign) AuthCodeType type;
@property (strong,nonatomic) NSString* strPhone;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (nonatomic, strong) IBOutlet UITextField *checkCodeText;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (nonatomic, strong) NSString *telephoneStr;
@property (nonatomic, strong) NSString *checkCode;
@property (strong, nonatomic)NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIButton *getCheckCodeBtn;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end
