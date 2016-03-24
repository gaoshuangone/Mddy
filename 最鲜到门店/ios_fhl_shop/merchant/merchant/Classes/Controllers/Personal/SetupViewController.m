//
//  SetupViewController.m
//  FHL
//
//  Created by panume on 14-10-29.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "SetupViewController.h"
#import "FeedbackViewController.h"
#import "AboutViewController.h"
#import "LoginViewController.h"
#import "ChangePwd.h"
typedef NS_ENUM(NSUInteger, TABLE_VIEW_SECTION) {
    TABLE_VIEW_SECTION_NOTICE,
    TABLE_VIEW_SECTION_ABOUT,
    TABLE_VIEW_SECTION_LOGINOUT,
    TABLE_VIEW_SECTION_COUNT
};

typedef NS_ENUM(NSUInteger, TABLE_VIEW_ROW) {
    TABLE_VIEW_ROW_FIRST,
    TABLE_VIEW_ROW_SECOND,
    TABLE_VIEW_ROW_COUNT
};

typedef NS_ENUM(NSUInteger, NoticeType) {
    NoticeTypeSound,
    NoticeTypeShock
};
@interface SetupViewController ()<UIAlertViewDelegate>

@property (nonatomic, assign) NoticeType type;

@end

@implementation SetupViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"设置";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self addTableViewWithStyle:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - 64);
    self.tableView.bounces = NO;
//    BOOL shock = [AppManager boolValueForKey:@"shock"];
//    if (shock) {
//        self.type = NoticeTypeShock;
//        
//    }
//    else {
//        self.type = NoticeTypeSound;
//        
//    }
     [self.view addGestureRecognizer:self.swip];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (IBAction)switchValueChanged:(id)sender
{
    
    if ([sender isKindOfClass:[UIButton class]]) {
        
        self.type = self.type == NoticeTypeSound ? NoticeTypeShock : NoticeTypeSound;
        UIImage *image = [[UIImage alloc] init];
//        image = self.type == NoticeTypeSound ? [UIImage imageNamed:@"switch_remind_left.png"] : [UIImage imageNamed:@"switch_remind_right.png"];
     
        
//        if (self.type == NoticeTypeShock) {
//            [AppManager setUserBoolValue:YES key:@"shock"];
//        }
//        else {
//            [AppManager setUserBoolValue:NO key:@"shock"];
//        }
        
        if ([AppManager boolValueForKey:@"shock"]) {
              [AppManager setUserBoolValue:NO key:@"shock"];
//              image =  [UIImage imageNamed:@"switch_remind_right.png"];
            image =  [UIImage imageNamed:@"switch_remind_left.png"];
            
        }else{
            [AppManager setUserBoolValue:YES key:@"shock"];
            
           
// image =  [UIImage imageNamed:@"switch_remind_left.png"];
               image =  [UIImage imageNamed:@"switch_remind_right.png"];
            
      
        }
        
           [sender setBackgroundImage:image forState:UIControlStateNormal];
    }
//    else {
//        UISwitch *switcher = (UISwitch *)sender;
//        
//        if (switcher.on) {
//            NSString *userId = [AppManager valueForKey:@"bindUserId"];
//            NSString *channelId = [AppManager valueForKey:@"bindChannelId"];
//            
//            NSString *bind = [userId stringByAppendingString:@";"];
//            bind = [bind stringByAppendingString:channelId];
//            
////            [self setBindPushWithParams:bind];
//            
//        }
//        else {
//            
//            //BPUSH unbind???
////            [self setBindPushWithParams:@""];
//        }
//    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TABLE_VIEW_SECTION_COUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( section == TABLE_VIEW_SECTION_ABOUT ) {
        return TABLE_VIEW_ROW_COUNT;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == TABLE_VIEW_SECTION_NOTICE) {
        if (indexPath.row == TABLE_VIEW_ROW_FIRST) {
            static NSString *cellIdentifier = @"StyleCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
                cell.textLabel.text = @"提醒方式";
                cell.textLabel.font = [UIFont systemFontOfSize:15];


                UIButton *switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *image = [[UIImage alloc] init];
                if ([AppManager boolValueForKey:@"shock"]) {
                   image = [UIImage imageNamed:@"switch_remind_right.png"];
                }else{
                  image =
                    [UIImage imageNamed:@"switch_remind_left.png"];
                }
                
//                image = self.type == NoticeTypeSound ? [UIImage imageNamed:@"switch_remind_left.png"] : [UIImage imageNamed:@"switch_remind_right.png"];

         

                switchButton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
                [switchButton setBackgroundImage:image forState:UIControlStateNormal];
                
                [switchButton addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventTouchUpInside];
                cell.accessoryView = switchButton;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
        }
        else {
//            static NSString *cellIdentifier = @"NotificationCell";
//            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//            if (!cell) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//                
//                cell.textLabel.text = @"接受新通知";
//                cell.textLabel.font = [UIFont systemFontOfSize:15];
//
//                UISwitch *switcher = [[UISwitch alloc] init];
////                switcher.tag = 1002;
//                switcher.onTintColor = [UIColor colorWithHex:0xfc6605];
//                [switcher addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
//                cell.accessoryView = switcher;
//            }
//
        }
    }
//     else if (indexPath.section == TABLE_VIEW_SECTION_ABOUT) {
//         static NSString *cellIdentifier = @"SuggestCell";
//         cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//         if (!cell) {
//             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//             
//             cell.textLabel.text = @"修改密码";
//             cell.textLabel.font = [UIFont systemFontOfSize:15];
//             
//             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//         }
//
//         
//     }
    
    else if (indexPath.section == TABLE_VIEW_SECTION_ABOUT) {
        if (indexPath.row == TABLE_VIEW_ROW_FIRST) {
            static NSString *cellIdentifier = @"SuggestCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
                cell.textLabel.text = @"建议与反馈";
                cell.textLabel.font = [UIFont systemFontOfSize:15];

                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
        else {
            static NSString *cellIdentifier = @"AboutCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
                cell.textLabel.text = @"关于最鲜到";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
               
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
        }
    }
    else {
        static NSString *cellIdentifier = @"LoginOutCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            UILabel *label = [[UILabel alloc] init];
            label.text = @"退出";
            label.font = [UIFont systemFontOfSize:15];
            [label sizeToFit];
            label.center = CGPointMake(WINDOW_WIDTH / 2, 44 / 2);
            [cell.contentView addSubview:label];
        }
    }
    
    return cell;
}

#pragma  mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
        
    
//    if (indexPath.section == TABLE_VIEW_SECTION_ABOUT )
//    {
//        ChangePwd* changePwd = [[ChangePwd alloc]initWithNibName:nil bundle:nil];
//        [self.navigationController pushViewController:changePwd animated:YES];
//    }else
    if (indexPath.section == TABLE_VIEW_SECTION_ABOUT )
    {
        if (indexPath.row == TABLE_VIEW_ROW_FIRST) {
            FeedbackViewController *feedbackViewController = [[FeedbackViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
            [self.navigationController presentViewController:navigationController animated:YES completion:nil];
        }
        else {
            AboutViewController *aboutViewController = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:aboutViewController animated:YES];
        }
        
    }else if (indexPath.section == TABLE_VIEW_SECTION_NOTICE )
    {
        
    }else{// 退出
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"确认退出" message:@"退出后下次需要重新登录才能使用，确认退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [alert show];
        
        
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
//        [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
              [SelfUser hudShowWithViewcontroller:self];
        [SelfUser mddyRequestWithMethodName:@"logoutJsonPhone.htm" withParams:@{@"cmdCode" : g_logoutCmd} withBlock:^(id responseObject, NSError *error) {
//            [SVProgressHUD dismiss ];
//            [SelfUser hudHideWithViewcontroller:self];
            [MBProgressHUD hudHideWithViewcontroller:self];

            [SelfUser currentSelfUser].isNeedReturnLanShou = YES;
            if (!error) {
                [[NSNotificationCenter defaultCenter] postNotificationName:HIT_HEART_NOTIFICATION object:nil userInfo:@{@"beginHit" : @(NO)}];
                [[UIApplication sharedApplication] unregisterForRemoteNotifications];
                @try {
                    FLDDLogDebug(@"%@",responseObject);
                    
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                //                [AppManager setUserDefaultsValue:@"" key:@"blankPhone"];
//                [AppManager setUserDefaultsValue:@"" key:@"telephone"];
                [AppManager setUserDefaultsValue:@"" key:@"password"];
                [AppManager setUserBoolValue:YES key:@"NeedRefreshMes"];
                
                
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                delegate.baseTabBarController.selectedIndex = 0;
                self.tabBarController.selectedIndex = 0;
                LoginViewController* login = [[LoginViewController alloc]initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:login animated:YES];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:HIT_HEART_NOTIFICATION object:nil userInfo:@{@"beginHit" : @(NO)}];
                [[UIApplication sharedApplication] unregisterForRemoteNotifications];
                
//                [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
                [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
//                [AppManager setUserDefaultsValue:@"" key:@"telephone"];
                [AppManager setUserDefaultsValue:@"" key:@"password"];
                [AppManager setUserBoolValue:YES key:@"NeedRefreshMes"];
                
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                delegate.baseTabBarController.selectedIndex = 0;
                LoginViewController* login = [[LoginViewController alloc]initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:login animated:YES];
            }
            
        }];

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16;
}

@end
