//
//  AboutViewController.m
//  FHL
//
//  Created by panume on 14-10-30.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "AboutViewController.h"
#import "WebViewController.h"

@interface AboutViewController ()

@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIView *tableFooterView;
@property (nonatomic, assign) BOOL needUpdate;

@end

@implementation AboutViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"关于最鲜到";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.tableView.tableHeaderView = self.tableHeaderView;
    [self addTableViewWithStyle:UITableViewStylePlain];
    self.tableView.tableFooterView = self.tableFooterView;
    self.tableView.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - 64);
    
    self.tableView.scrollEnabled = NO;
    
    self.needUpdate = NO;
    [self checkUpdate];
     [self.view addGestureRecognizer:self.swip];
    //    self.tableView.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - 64);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, WINDOW_HEIGHT/5-50, WINDOW_WIDTH, 200)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_logo.png"]];
        imageView.center = CGPointMake(WINDOW_WIDTH / 2, 40 + imageView.bounds.size.height / 2);
        [view addSubview:imageView];
        
        UILabel *versionLabel = [[UILabel alloc] init];
        // ***BEGIN***  V1.1.1 merchant 郏国上 2014/11/17 modify
        //versionLabel.text = @"版本1.0.10 Dev";
        versionLabel.text = [[NSString alloc] initWithString:[NSString stringWithFormat:@"版本%@", g_versionSNO]];
        // ***END***    V1.1.1 merchant 郏国上2014/11/17 modify
        versionLabel.font = [UIFont systemFontOfSize:18];
        versionLabel.textColor = [UIColor lightGrayColor];
        versionLabel.backgroundColor = [UIColor clearColor];
        [versionLabel sizeToFit];
        versionLabel.center = CGPointMake(WINDOW_WIDTH / 2, CGRectGetMaxY(imageView.frame) + 10 + versionLabel.bounds.size.height / 2);
        [view addSubview:versionLabel];
        
        _tableHeaderView = view;
        return view;
    }
    
    return _tableHeaderView;
    
}

- (UIView *)tableFooterView
{
    if (!_tableFooterView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, self.tableView.bounds.size.height - self.tableHeaderView.bounds.size.height)];
        view.backgroundColor = [UIColor clearColor];
        NSString *policy = @"使用条款和隐私政策";
        
        UIButton *policyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
//        CGSize size = [policy sizeWithFont:policyButton.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 30) lineBreakMode:NSLineBreakByWordWrapping];
        CGRect stringRect = [policy boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:policyButton.titleLabel.font,NSFontAttributeName, nil] context:nil];
        
        policyButton.frame =stringRect;
//        CGRectMake(0, 0, size.width + 10, 30);
        
        [policyButton setTitle:policy forState:UIControlStateNormal];
        [policyButton setTitleColor:[UIColor colorWithHex:0x007aff] forState:UIControlStateNormal];
        policyButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [policyButton addTarget:self action:@selector(policyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        policyButton.center = CGPointMake(WINDOW_WIDTH / 2, view.bounds.size.height - 60 - policyButton.bounds.size.height / 2);
        [view addSubview:policyButton];
        
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.text = @"最鲜到 版权所有";
        label1.font = [UIFont systemFontOfSize:12];
        //        label1.textAlignment = NSTextAlignmentCenter
        label1.textColor = [UIColor colorWithHex:0x949494];
        [label1 sizeToFit];
        label1.center = CGPointMake(WINDOW_WIDTH / 2, CGRectGetMaxY(policyButton.frame) + 10 + label1.bounds.size.height / 2);
        [view addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.text = @"Copyright © 2014-2015";
        label2.font = [UIFont systemFontOfSize:12];
        label2.textColor = [UIColor colorWithHex:0x949494];
        [label2 sizeToFit];
        label2.center = CGPointMake(WINDOW_WIDTH / 2, CGRectGetMaxY(label1.frame)  + label2.bounds.size.height / 2);
        [view addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] init];
        label3.text = @"All Rights Reserved";
        label3.font = [UIFont systemFontOfSize:12];
        label3.textColor = [UIColor colorWithHex:0x949494];
        [label3 sizeToFit];
        label3.center = CGPointMake(WINDOW_WIDTH / 2, CGRectGetMaxY(label2.frame) + label3.bounds.size.height / 2);
        [view addSubview:label3];
        
        
        _tableFooterView = view;
        return _tableFooterView;
        
    }
    return _tableFooterView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (IBAction)policyButtonPressed:(id)sender
{
    WebViewController *webViewController = [[WebViewController alloc] init];
    webViewController.type = WebViewTypePolicy;
    webViewController.title = @"隐私政策";
    [self.navigationController pushViewController:webViewController animated:YES];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UpdateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell.contentView addSubview:_tableHeaderView];
        cell.backgroundColor = [UIColor clearColor];
      cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.textLabel.text = @"检查新版本";
//        cell.textLabel.font = [UIFont systemFontOfSize:15];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.textLabel.backgroundColor = [UIColor redColor];
//        
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_about.png"]];
//        imageView.center = CGPointMake(95 + imageView.bounds.size.width / 2, cell.contentView.center.y);
//        [cell addSubview:imageView];
//        _imageViewVersion = imageView;
//        
//        if((self.needUpdate) || ((VERSION_STATE_FORCE_UPDATE == [User currentUser].g_versionState) || (VERSION_STATE_REMIND_UPDATE == [User currentUser].g_versionState)))
//        {
//            _imageViewVersion.hidden = NO;
//        }
//        else
//        {
//            _imageViewVersion.hidden = YES;
//        }
        
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // ***BEGIN***  V1.1.1 merchant 郏国上 2014/11/17 add
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    if([cellText isEqualToString:@"检查新版本"])
    {
        //[[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_VERSION_NOTIFICATION object:nil];
        //[[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_VERSION_PROMPT_NOTIFICATION object:nil];
        [self updateVersionPrompt];
    }
    FLDDLogDebug(@"cellText :%@, cellText == @\"检查新版本\" :%d", cellText, [cellText isEqualToString:@"检查新版本"]);
    // ***END***    V1.1.1 merchant 郏国上2014/11/17 add
}



- (void)updateVersionPrompt
{
    [User currentUser].g_versionState = VERSION_STATE_INIT;
    [User currentUser].g_bVersionUpdatePrompt = NO;
    [User currentUser].g_newVersionURL = nil;
    //    NSString *userState = [User currentUser].state;
    //    if (![userState isEqualToString:@"0"] && ![userState isEqualToString:@"1"] && userState != nil)
    {
        NSMutableDictionary *paramsList = [NSMutableDictionary dictionary];
        [paramsList setObject:g_versionSNO forKey:@"version"];
        FLDDLogDebug(@"paramsList:%@", paramsList);
        
        [User getVersionSNOWithParams:paramsList block:^(NSError *error) {
            
            if (!error)
            {
                if((VERSION_STATE_FORCE_UPDATE == [User currentUser].g_versionState) && ([User currentUser].g_newVersionURL != nil))
                {
                    self.needUpdate = YES;
                    _imageViewVersion.hidden = NO;
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"版本更新" message:@"检测到最新版本，请及时更新" delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil,nil];
                    alert.tag = 100;
                    @try
                    {
                        [alert show];
                        [User currentUser].g_bVersionUpdatePrompt = YES;
                    }
                    @catch (NSException *exception) {
                    }
                }
                else if((VERSION_STATE_REMIND_UPDATE == [User currentUser].g_versionState) && ([User currentUser].g_newVersionURL != nil))
                {
                    self.needUpdate = YES;
                    _imageViewVersion.hidden = NO;
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"版本更新" message:@"检测到最新版本，请及时更新" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"更新",nil];
                    alert.tag = 101;
                    @try
                    {
                        [alert show];
                    }
                    @catch (NSException *exception) {
                    }
                }
                else
                {
                    self.needUpdate = NO;
                    _imageViewVersion.hidden = YES;
//                    [SVProgressHUD showSuccessWithStatus:@"已经是最新版本。"];
                    [MBProgressHUD hudShowWithStatus:self :@"已经是最新版本。"];
                }
            }
            else
            {
                FLDDLogInfo(@"err:%@", error);
//                [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
                [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
                [User currentUser].g_versionState = VERSION_STATE_FETCH_FAIL;
            }
        }];
        
    }
}


- (void)checkUpdate
{
//    [User currentUser].g_versionState = VERSION_STATE_INIT;
//    [User currentUser].g_bVersionUpdatePrompt = NO;
//    [User currentUser].g_newVersionURL = nil;
    NSMutableDictionary *paramsList = [NSMutableDictionary dictionary];
    [paramsList setObject:g_versionSNO forKey:@"version"];
    FLDDLogDebug(@"paramsList:%@", paramsList);
    
//    
//    
//    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [paramsList setObject:g_checkUpdateCmd forKey:@"cmdCode"];
    
    [[API shareAPI] GET:@"hasNewVersionIOSJsonPhone.htm" params:paramsList success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try {
            NSDictionary *responseBody = [responseObject objectForKey:@"body"];
            //FLDDLogDebug(@"%@", responseBody);
            
            
            [User currentUser].g_newVersionURL = nil;
            NSString *hasNewVersion= [[responseBody objectForKey:@"hasNewVersion"] toString];
            if([hasNewVersion isEqualToString:@"0"])
            {
                self.needUpdate = NO;
//                [User currentUser].g_versionState = VERSION_STATE_NO_UPDATE;
            }
            else
            {
                self.needUpdate = YES;
                NSString *needUpgrade= [[responseBody objectForKey:@"needUpgrade"] toString];
                if([needUpgrade isEqualToString:@"1"])
                {
                    g_needUpgrade = 1;
                    NSString *downloadUrl= [[responseBody objectForKey:@"downloadUrl"] toString];
                    [User currentUser].g_newVersionURL = downloadUrl;
//                    [User currentUser].g_versionState = VERSION_STATE_FORCE_UPDATE;
                }
//                else
//                {
//                    [User currentUser].g_versionState = VERSION_STATE_REMIND_UPDATE;
//                }
            }
            
            [self.tableView reloadData];
        }
        @catch (NSException *exception) {
//            NSDictionary *responseBody = [responseObject objectForKey:@"body"];
//            FLDDLogError(@"%@", responseBody);
        }
        
        
//        //[User currentUser].g_versionState = VERSION_STATE_FORCE_UPDATE;
//        //[User currentUser].g_newVersionURL = @"https://itunes.apple.com/cn/app/ccms/id862895482?l=zh&ls=1&mt=8";
//        
//        if (block) {
//            block (nil);
//        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.needUpdate = 0;
//        if (block) {
//            //[User currentUser].g_newVersionURL = @"https://itunes.apple.com/cn/app/ccms/id862895482?l=zh&ls=1&mt=8";
//            //[User currentUser].g_versionState = VERSION_STATE_FORCE_UPDATE;
//            [User currentUser].g_versionState = VERSION_STATE_FETCH_FAIL;
//            block(error);
//        }
    }];
//    [User getVersionSNOWithParams:paramsList block:^(NSError *error) {
//        
//    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([alertView tag] == 100)
    {
        switch (buttonIndex) {
                //            case 0://NO应该做的事
                //            {
                //                [User currentUser].g_bVersionUpdatePrompt = NO;
                //                exit(0);
                //                break;
                //            }
            case 0: //YES应该做的事
            {
                [User currentUser].g_bVersionUpdatePrompt = NO;
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[User currentUser].g_newVersionURL]];
                break;
            }
        }
        return;
    }
    else if([alertView tag] == 101)
    {
        switch (buttonIndex) {
            case 0://NO应该做的事
            {
                //[User currentUser].g_bVersionUpdatePrompt = NO;
                break;
            }
            case 1: //YES应该做的事
            {
                //[User currentUser].g_bVersionUpdatePrompt = NO;
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[User currentUser].g_newVersionURL]];
                break;
            }
                
        }
        return;
    }
    
}

@end
