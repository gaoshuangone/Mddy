//
//  BaseViewController.m
//  merchant
//
//  Created by panume on 14-11-2.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeViewController.h"
//#import "InstructionViewController.h"
#import "MessagesViewController.h"
#import "PersonalViewController.h"
#import "LoginViewController.h"
@interface BaseViewController ()<UIActionSheetDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHex:0xfc6605];
    self.swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipLeft)];
    [self.swip setDirection:UISwipeGestureRecognizerDirectionLeft];
    // Do any additional setup after loading the view.
    
    self.swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipLeft)];
    [self.swip setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    
    
#ifdef DEBUG
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
#else
    
#endif

}


- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动结束
    
    if (event.subtype == UIEventSubtypeMotionShake) {
        
        if ([[AppManager valueForKey:@"RootUrlIndex"] isEqualToString:@"测试test"]||[[AppManager valueForKey:@"RootUrlIndex"] isEqualToString:@"小芳芳"]||[[AppManager valueForKey:@"RootUrlIndex"] isEqualToString:@"小灰灰"]||[[AppManager valueForKey:@"RootUrlIndex"] isEqualToString:@"预发"]||[[AppManager valueForKey:@"RootUrlIndex"] isEqualToString:@"测试98"]) {
            UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat:@"目前－%@",[AppManager valueForKey:@"RootUrlIndex"]] delegate:self cancelButtonTitle:@"cancel"  destructiveButtonTitle:nil otherButtonTitles:@"http://test.zuixiandao.cn",@"http://172.16.28.163:8081",@"http://172.16.28.165:8080" ,@"http://pre.zuixiandao.cn",@"http://172.16.28.98/fhl",nil];
            [actionSheet showInView:self.view];
        }
    }
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [AppManager setUserDefaultsValue:@"http://test.zuixiandao.cn/fhl/phone/mddy/" key:@"RootUrl"];
        [AppManager setUserDefaultsValue:@"测试test" key:@"RootUrlIndex"];
        
    }
    else if(buttonIndex == 1){
        [AppManager setUserDefaultsValue:@"http://172.16.28.163:8081/fhl/phone/mddy/" key:@"RootUrl"];
        [AppManager setUserDefaultsValue:@"小芳芳" key:@"RootUrlIndex"];
        
    }else if (buttonIndex == 2){
        [AppManager setUserDefaultsValue:@"http://172.16.28.165:8080/fhl/phone/mddy/" key:@"RootUrl"];
        [AppManager setUserDefaultsValue:@"小灰灰" key:@"RootUrlIndex"];
        
    }else if (buttonIndex == 3){
        [AppManager setUserDefaultsValue:@"http://pre.zuixiandao.cn/fhl/phone/mddy/" key:@"RootUrl"];
        [AppManager setUserDefaultsValue:@"预发" key:@"RootUrlIndex"];
        
    }else if(buttonIndex == 4){
        [AppManager setUserDefaultsValue:@"http://172.16.28.98/fhl/phone/mddy/" key:@"RootUrl"];
        [AppManager setUserDefaultsValue:@"测试98" key:@"RootUrlIndex"];
        
    }
    
    
    if (buttonIndex != 5) {
        sleep(2);
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.baseTabBarController.selectedIndex = 0;
        self.tabBarController.selectedIndex = 0;
        LoginViewController* login = [[LoginViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:login animated:YES];
        exit(0);
    }
    
}

-(void)swipLeft{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSArray *viewControllers = self.tabBarController.viewControllers;
    
    
    if ([viewControllers containsObject:self]) {
        
        if ([self isKindOfClass:[HomeViewController class]]) {
            self.tabBarController.title = @"";
        }
//        else if ([self isKindOfClass:[InstructionViewController class]]) {
//            self.tabBarController.title = @"宝典";
//        }
//        else if ([self isKindOfClass:[SendOrderViewController class]]) {
//            self.tabBarController.title = @"发单";
//        }
        else if ([self isKindOfClass:[MessagesViewController class]]) {
            self.tabBarController.title = @"消息";
        }
        else {
            self.tabBarController.title = @"我的";
        }
        
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithHex:0xfc6605];
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName ,nil];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        
    }
    else {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithHex:0xededed];
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName ,nil];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
