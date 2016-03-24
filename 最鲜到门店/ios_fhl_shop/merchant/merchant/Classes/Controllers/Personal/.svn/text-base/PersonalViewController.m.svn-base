//
//  PersonalViewController.m
//  merchant
//
//  Created by panume on 14-11-1.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "PersonalViewController.h"
#import "PresonalInfoCell.h"
#import "PersonalCell.h"
#import "WorkerManageViewController.h"
#import "OrderSuccessedViewController.h"
#import "SetupViewController.h"
#import "CExpandPicViewController.h"
#import "PersonalMessageCell.h"
#import "MessagesViewController.h"
#import "UIView+convenience.h"


#import "AccountRechargeViewController.h"



#define SERVICE_PHONE_SHOW @"400-686-7000"
#define SERVICE_PHONE @"4006867000"

@interface PersonalViewController ()
@property (strong, nonatomic)NSDictionary* dictData;
@property (nonatomic, strong) UIImage *portraitImage;
@property (nonatomic, strong) PersonalMessageCell *pMcellInfo;
@property (nonatomic,strong) UILabel* labelAccountReach;
@property (strong, nonatomic) NSString* strAccluntReach;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self addTableViewWithStyle:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - 64) ;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    
    //    self.tableView.scrollEnabled = NO;
    // Do any additional setup after loading the view from its nib.
//    [self.view addGestureRecognizer:self.swip];
}
-(void )viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"backWithTitle.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 53, 19);
    
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rithtBarItem ;
    self.title  = @"我的";
    //    if ([SelfUser currentSelfUser].shopName.length == 0) {
    //        [self getPresonalInfo];
    //    }
    [self getMessageCountInfo];
    FLDDLogDebug(@"%@",[SelfUser currentSelfUser].dictPresonInfo);
    self.dictData =[SelfUser currentSelfUser].dictPresonInfo;
}

-(void)getMessageCountInfo{
    [SelfUser mddyRequestWithMethodName:@"shopAccountBlanceJsonPhone.htm" withParams:@{@"cmdCode":g_shopAccountBlanceJsonPhoneCountCmd} withBlock:^(id responseObject, NSError *error) {
        
        FLDDLogDebug(@"%@",responseObject);
        
        if (!error) {
            @try {
                self.strAccluntReach = [[responseObject valueForKey:@"accountBlance"] toString];
                
                self.labelAccountReach.text = [NSString stringWithFormat:@"%@元",self.strAccluntReach];
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }else{
            
        }
    }];
    
    [SelfUser mddyRequestWithMethodName:@"notifyUnreadCountWithoutTypeJsonPhone.htm" withParams:@{@"cmdCode":g_notifyUnreadCountCmd} withBlock:^(id responseObject, NSError *error) {
        FLDDLogDebug(@"%@",responseObject);
        
        
        if (!error) {
            @try {
                int count = [[responseObject valueForKey:@"count1"] intValue] + [[responseObject valueForKey:@"count2"] intValue];
                
                if (count == 0) {
                    _bPrompt = YES;
                }else{
                    _bPrompt = NO;
                }
                if((_pMcellInfo != nil) &&(_pMcellInfo.imageIcon != nil))
                {
                    _pMcellInfo.imageIcon.hidden = _bPrompt;
                }
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }else{
            _bPrompt = YES;
        }
    }];
}
//
//-(void)getPresonalInfo{
////    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
//    [SelfUser shopInfoWithBlock:^(id resongseObjec, NSError *error) {
////           [SVProgressHUD dismiss ];
//        [MBProgressHUD hudHideWithViewcontroller:self];
//        if (!error) {
//            @try {
//                FLDDLogDebug(@"%@",resongseObjec);
//                self.dictData = resongseObjec;
////                [SelfUser currentSelfUser].shopName = [[resongseObjec objectForKey:@"shopName"] toString];
//                [AppManager setUserDefaultsValue:[[resongseObjec objectForKey:@"shopName"] toString] key:@"shopName"];
//            }
//            @catch (NSException *exception) {
//
//            }
//            @finally {
//
//            }
//            [self.tableView reloadData];
////            [self getMddyImageWithBtrandId:[[resongseObjec valueForKey:@"brandIdUrl"] toString]];
//        }else{
////                [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
//            [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
//        }
//
//    }];
//
//
//
//
//}
-(void)getMddyImageWithBtrandId:(NSString*)brandId {
    
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    if ([self.dictData allKeys].count>0) {
    //        return 4;
    //    }
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:{
            return 1;
        }
        case 2:
            if ([[[SelfUser currentSelfUser].Clerktype toString] isEqualToString:@"1"]) {
                return 2;
            }else{
                return 1;
            }
            
            
            break;
        case 3:
            return 1;
        case 4:
            return 2;
            
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell* cell = nil;
    if (indexPath.section == 0) {
        static NSString* strINTI = @"cell1";
        PresonalInfoCell* cellInfoCell = (PresonalInfoCell*)[tableView dequeueReusableCellWithIdentifier:strINTI];
        if (!cellInfoCell) {
            UINib * nibCell = [UINib nibWithNibName:@"PresonalInfoCell" bundle:nil];
            [tableView registerNib:nibCell forCellReuseIdentifier:strINTI];
            cellInfoCell = (PresonalInfoCell*)[tableView dequeueReusableCellWithIdentifier:strINTI];
            
            
        }
        
        
        cellInfoCell.labelTitle.text = [self.dictData valueForKey:@"shopName"];
        cellInfoCell.labelTitleAddress.text = [self.dictData valueForKey:@"shopAddress"];
        if ( [[self.dictData valueForKey:@"shopTel"] toString].length !=11 ) {
            FLDDLogDebug(@"%@",[[self.dictData valueForKey:@"shopTel"] toString]);
            cellInfoCell.labelPhoneNumber.text=[[self.dictData valueForKey:@"shopTel"] toString];
        }else{
            cellInfoCell.labelPhoneNumber.text = [CommonUtils changePhoneNumberWithNumber:[[self.dictData valueForKey:@"shopTel"] toString] withType:@" "];
        }
        [cellInfoCell.labelPhoneNumber sizeToFit];
        
        if (self.dictData.count==0) {
            cellInfoCell.labelTitle.text=[AppManager valueForKey:@"shopName"];
            cellInfoCell.labelTitleAddress.text = [AppManager valueForKey:@"shopAddress"];
            [cellInfoCell.labelTitleAddress sizeToFit];
            
            
            if ( [[AppManager valueForKey:@"shopTel"] toString].length !=11 ) {
                //                FLDDLogDebug(@"%@",[[self.dictData valueForKey:@"shopTel"] toString]);
                cellInfoCell.labelPhoneNumber.text=[[AppManager valueForKey:@"shopTel"] toString];
            }else{
                cellInfoCell.labelPhoneNumber.text = [CommonUtils changePhoneNumberWithNumber:[[AppManager valueForKey:@"shopTel"] toString] withType:@" "];
            }
            [cellInfoCell.labelPhoneNumber sizeToFit];
        }
        
        //        FLDDLogDebug(@"%@",[[self.dictData valueForKey:@"brandIdUrl"] toString]);
        if ([self.dictData.allKeys containsObject:@"brandIdUrl"]) {
            
            NSString* str = nil;
            if ([AppManager valueForKey:@"telephone"]!=nil) {
                NSLog(@"%@",[AppManager valueForKey:@"telephone"]);
                str = [AppManager valueForKey:[AppManager valueForKey:@"telephone"]];
                NSLog(@"!@#%@",str);
            }
            if (str.length >0) {
                UIImage* imageLogo =[UIImage imageWithData:[AppManager readDataFromDocumentWithName:str]];
                if (imageLogo) {
                    cellInfoCell.cellImageView.image =imageLogo;
                }else{
                    cellInfoCell.cellImageView.image = [UIImage imageNamed:@"business_default_photo_small"];
                }
                
            }else{
                cellInfoCell.cellImageView.image = [UIImage imageNamed:@"business_default_photo_small"];
                
            }
            //        [SelfUser mddyRequestWIthImageWithBrandID:[[self.dictData valueForKey:@"brandIdUrl"] toString] withBlock:^(UIImage * image, NSError *error) {
            //            if (!error) {
            //
            //                if (image == nil) {
            //                    cellInfoCell.cellImageView.image = [UIImage imageNamed:@"business_default_photo_normal"];
            //                    return ;
            //                }
            //                else {
            //                    cellInfoCell.cellImageView.image = image;
            //                    _portraitImage = image;
            //                    cellInfoCell.cellImageView.userInteractionEnabled = YES;
            //                    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImageButtonPressed:)];
            //                    [cellInfoCell.cellImageView addGestureRecognizer:singleTap];
            //
            //                }
            //            }else {
            //
            //            }
            //        }];
            [cellInfoCell setImageViewYouWithIndex:0 ];
            
        }
        cell = cellInfoCell;
        cellInfoCell = nil;
    }else if (indexPath.section == 2){
        
        
        static NSString* strInti = @"cell2";
        PersonalCell*cellInfo = [tableView dequeueReusableCellWithIdentifier:strInti];
        if (!cellInfo) {
            cellInfo = [[PersonalCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strInti];
        }
        
        if (indexPath.row == 0) {
            cellInfo.icon.image = [UIImage imageNamed:@"orders_done_icon.png"];
            cellInfo.titleLabel.text = @"已完成订单";
        }else{
            cellInfo.icon.image = [UIImage imageNamed:@"clerk_icon.png"];
            cellInfo.titleLabel.text = @"店员管理";
            
        }
        
        cell = cellInfo;
        cellInfo = nil;
        
    }
    else if (indexPath.section == 3 || indexPath.section==1)
    {
        if (indexPath.section == 3 ) {
            
            
            static NSString* strInti = @"cell3";
            PersonalMessageCell *cellInfo = [tableView dequeueReusableCellWithIdentifier:strInti];
            if (!cellInfo) {
                cellInfo = [[PersonalMessageCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strInti];
            }
            
            cellInfo.icon.image = [UIImage imageNamed:@"new01"];
            cellInfo.titleLabel.text = @"消息";
            if(cellInfo.imageIcon != nil)
            {
                cellInfo.imageIcon.image = [UIImage imageNamed:@"new_prompt"];
            }
            //        cellInfo.accessoryType =UITableViewCellAccessoryNone;
            cellInfo.imageIcon.hidden = _bPrompt;
            cell = cellInfo;
            _pMcellInfo = cellInfo;
            cellInfo = nil;
        }else{
            static NSString* strIntit = @"cell11";
            PersonalMessageCell *cellInfo = [tableView dequeueReusableCellWithIdentifier:strIntit];
            if (!cellInfo) {
                cellInfo = [[PersonalMessageCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIntit];
            }
            
            cellInfo.icon.image = [UIImage imageNamed:@"jine.png"];
//            cellInfo.icon.center = CGPointMake((iPhone6Plus?+5:0)+16 +cellInfo.icon.bounds.size.width / 2, cellInfo.center.y);
            
            cellInfo.titleLabel.text = @"账户余额";
//            [cellInfo.titleLabel sizeToFit];
//            cellInfo.titleLabel.center = CGPointMake(cellInfo.titleLabel.center.x, cellInfo.center.y);
            
            
            if (self.labelAccountReach== nil) {
                
                self.labelAccountReach = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH-200, 44)];
                if (self.strAccluntReach != nil) {
                    self.labelAccountReach.text = [NSString stringWithFormat:@"%@元",self.strAccluntReach];
                }else{
                    self.labelAccountReach.text = @"";
                }
                self.labelAccountReach.font = [UIFont systemFontOfSize:14];
                self.labelAccountReach.textColor = [UIColor grayColor];
                self.labelAccountReach.textAlignment = NSTextAlignmentRight;
                self.labelAccountReach.center = CGPointMake(WINDOW_WIDTH-15-self.labelAccountReach.boundsWide/2, 22);
                [cellInfo addSubview:self.labelAccountReach];
            }
            cellInfo.accessoryType = UITableViewCellAccessoryNone;
            cell = cellInfo;
            
            
            
            cellInfo = nil;
            
        }
        
        
        
    }
    else {
        
        static NSString* strInti = @"cell4";
        PersonalCell*cellInfo = [tableView dequeueReusableCellWithIdentifier:strInti];
        if (!cellInfo) {
            cellInfo = [[PersonalCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strInti];
        }
        
        if (indexPath.row == 0) {
            cellInfo.icon.image = [UIImage imageNamed:@"call_icon.png"];
            cellInfo.titleLabel.text = @"客服电话：400-686-7000";
            [cellInfo.titleLabel sizeToFit];
            cellInfo.accessoryType =UITableViewCellAccessoryNone;
            //            UILabel *callLabel = [[UILabel alloc] init];
            //            callLabel.text = @"拨打";
            //            callLabel.font = [UIFont boldSystemFontOfSize:13];
            //            callLabel.textColor = [UIColor lightGrayColor];
            //            [callLabel sizeToFit];
            //
            //            cellInfo.accessoryView = callLabel;
        }else{
            cellInfo.icon.image = [UIImage imageNamed:@"setting_icon.png"];
            cellInfo.titleLabel.text = @"设置";
            
        }
        cell = cellInfo;
        cellInfo = nil;
        
    }
    return cell;
    
}



- (IBAction)showBigImageButtonPressed:(UIButton *)sender
{
    if (_portraitImage == nil)
    {
        return;
    }
    else
    {
        NSString *aString = @"CExpandPicViewController";
        
        CExpandPicViewController *expandPicViewController = [[CExpandPicViewController alloc] initWithNibName:aString bundle:nil];
        expandPicViewController.image = _portraitImage;
        
        [self presentViewController:expandPicViewController animated:NO completion:nil];
        expandPicViewController = nil;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [PresonalInfoCell cellHeight];
    }
    else if (indexPath.section == 2) {
        return 44;
    }
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view =[[UIView alloc]init];
    return view;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16;
}

#pragma  mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    if (indexPath.section == 1) {
    
    AccountRechargeViewController* messagesViewController = [[AccountRechargeViewController alloc ]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:messagesViewController animated:YES];
    messagesViewController = nil;
    
    //       [self apily];
    
}else if (indexPath.section == 2) {
    if (indexPath.row == 0) {
        OrderSuccessedViewController* orderSuccess = [[OrderSuccessedViewController alloc]initWithNibName:nil bundle:nil];
        
        [self.navigationController pushViewController:orderSuccess animated:YES];
        orderSuccess=nil;
    }else{
        WorkerManageViewController* workManage = [[WorkerManageViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:workManage animated:YES];
        workManage = nil;
    }
}
else if(indexPath.section == 3)
{
    MessagesViewController* messagesViewController = [[MessagesViewController alloc ]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:messagesViewController animated:YES];
    messagesViewController = nil;
    
}
    if (indexPath.section == 4) {
        if (indexPath.row==0) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定拨打客服电话?"
                                                                message:[NSString stringWithFormat:@"%@", SERVICE_PHONE_SHOW]
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定", nil];
            alertView.tag = 100;
            [alertView show];
            alertView = nil;
            
            
        }else{
            SetupViewController *setupViewController = [[SetupViewController alloc] init];
            [self.navigationController pushViewController:setupViewController animated:YES];
            setupViewController = nil;
        }
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView tag] == 100)
    {
        if (buttonIndex != alertView.cancelButtonIndex) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", SERVICE_PHONE]]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
