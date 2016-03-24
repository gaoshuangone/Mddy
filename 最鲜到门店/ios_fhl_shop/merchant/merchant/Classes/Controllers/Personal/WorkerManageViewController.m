//
//  WorkerManageViewController.m
//  merchant
//
//  Created by gs on 14/11/3.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "WorkerManageViewController.h"
#import "WorkerManageCell.h"
#import "AddWorkerController.h"
#import "DeleteWorderViewController.h"

@interface WorkerManageViewController ()<UIActionSheetDelegate>
@property (strong, nonatomic)NSDictionary* dictData;
@property (assign,nonatomic)NSInteger currentRow;
@property (strong, nonatomic)UIView* notDataView;
@end

@implementation WorkerManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton* rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItem.frame = CGRectMake(0, 0, 35, 35);
    [rightItem setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightItem];
    [rightItem addTarget:self action:@selector(addWorker) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rithtBarItem ;
    
    
    self.title = @"店员管理";
    self.dataArray = [[NSMutableArray alloc]initWithObjects:@"波提切利",@"达＊芬奇",@"米开朗基罗",@"拉斐尔",@"乔尔乔涅", nil ];
    
    
     [self.view addGestureRecognizer:self.swip];
    
    //    [self.tableView setEditing:YES animated:YES];
    
    // Do any additional setup after loading the view from its nib.
}
-(UIView*)notDataView{
    if (!_notDataView) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, WINDOW_WIDTH, self.tableView.frame.size.height-100)];
        
        UILabel* label = [[UILabel alloc]init];
        label.text  =@"暂无店员";
        label.textColor = [UIColor grayColor];
        [label sizeToFit];
        label.center = CGPointMake(self.view.center.x,self.view.center.y-90-100);
        [view addSubview:label];
        
        UILabel* labelJia = [[UILabel alloc]init];
        labelJia.text = @"点击右上角“＋”添加";
        labelJia.textColor = UICOLOR(248, 78, 11, 1);
          [labelJia sizeToFit];
        labelJia.center = CGPointMake(self.view.center.x,self.view.center.y+30-90-100);
        [view addSubview:labelJia];
        view.userInteractionEnabled = YES;
        _notDataView = view;
        return view;
        
    }
    
    
    
    return _notDataView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT  - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    [self.view addSubview:self.tableView];
    //刷新数据
    [self getDictData];
    
      [self.tableView addSubview:self.notDataView];
}
-(void)getDictData{
//    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
    [self startActivityView];
    [SelfUser clerkListWithBlock:^(id resongseObjecj, NSError *error) {
//        [SVProgressHUD dismiss];
        [MBProgressHUD hudHideWithViewcontroller:self];
        if (!error) {
            @try {
                FLDDLogDebug(@"%@",resongseObjecj);
                self.dictData = resongseObjecj;
                if (   [[[resongseObjecj valueForKey:@"dispatchClerkList"]valueForKey:@"total"] toInt] == 1){
                    
            
                
                     self.notDataView.hidden = NO;
                }else{
                    self.notDataView.hidden = YES;
                 
                }
                  [self.tableView reloadData ];
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
          
        }else{
            
//            [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
            [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
        }
        [self stopActivityView];
    }];
    
    
}
-(void)startActivityView{
    if (self.activityIndicatorView == nil) {
        
        self.activityIndicatorView= [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        self.activityIndicatorView.center = [UIApplication sharedApplication].keyWindow.center;
        //        self.activityIndicatorView.color = [UIColor redColor];
        [self.view addSubview: self.activityIndicatorView];
        
    }
    [self.activityIndicatorView startAnimating];
    self.tableView.userInteractionEnabled = NO;
    
}
-(void)stopActivityView{
    [  self.activityIndicatorView stopAnimating];
    self.tableView.userInteractionEnabled = YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[self.dictData valueForKey:@"dispatchClerkList"]valueForKey:@"total"] toInt];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* strINTI = @"cell";
    WorkerManageCell* cell = (WorkerManageCell*)[tableView dequeueReusableCellWithIdentifier:strINTI];
    if (!cell) {
        cell =[[WorkerManageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
    }
    cell.cellLabel.text =[[[[self.dictData valueForKey:@"dispatchClerkList"] valueForKey:@"rows"]objectAtIndex:indexPath.row  ]valueForKey:@"clerkName"];
    [cell.cellLabel sizeToFit];
    if ([[[[[[self.dictData valueForKey:@"dispatchClerkList"] valueForKey:@"rows"]objectAtIndex:indexPath.row  ]valueForKey:@"clerkType"]toString] isEqualToString:@"1"]) {
        cell.labelDianZhang.hidden = NO;
        
    }else{
        cell.labelDianZhang.hidden = YES;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentRow = indexPath.row;
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView

           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
////滑动删除，title宽度减小（左移），防止被delete按钮盖住。
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath*)indexPath
//{
////    WorkerManageCell * cell = (WorkerManageCell *)[tableView cellForRowAtIndexPath:indexPath];
////
////    cell.cellLabel.frame = CGRectMake(-cell.cellLabel.bounds.size.width/2+100, 0, cell.cellLabel.bounds.size.width, 44);
//}

////恢复title宽度
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath*)indexPath
//{
////    WorkerManageCell * cell = (WorkerManageCell *)[tableView cellForRowAtIndexPath:indexPath];
////
////    cell.cellLabel.frame = CGRectMake(15, 0, cell.cellLabel.bounds.size.width, 44);
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DeleteWorderViewController* delWorker = [[DeleteWorderViewController alloc]initWithNibName:nil bundle:nil];
    delWorker.title = [[[[self.dictData valueForKey:@"dispatchClerkList"]  valueForKey:@"rows"]objectAtIndex:indexPath.row  ]valueForKey:@"clerkName"];
    delWorker.dictData =[[[self.dictData valueForKey:@"dispatchClerkList"]  valueForKey:@"rows"]objectAtIndex:indexPath.row  ];
    [self.navigationController pushViewController:delWorker animated:YES];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(void)addWorker
{
    AddWorkerController* addWorker = [[AddWorkerController alloc]initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:addWorker animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        FLDDLogDebug(@"删除");
        
        if ([[[[[[self.dictData valueForKey:@"dispatchClerkList"] valueForKey:@"rows"]objectAtIndex:self.currentRow  ]valueForKey:@"clerkType"]toString] isEqualToString:@"1"]) {
//            [SVProgressHUD showErrorWithStatus:@"店长不可删除"];
            [MBProgressHUD hudShowWithStatus:self :@"店长不可删除"];
            
        }else{
//            
//            [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
            [MBProgressHUD hudShowWithViewcontrollerStatus:self :@"请稍候..."];
            FLDDLogDebug(@"%@",[self.dictData valueForKey:@"clerkId"]);
            [SelfUser mddyRequestWithMethodName:@"clerkDelJsonPhone.htm" withParams:@{@"cmdCode" : g_clerkDelCmd, @"clerkId":[[[[[self.dictData valueForKey:@"dispatchClerkList"] valueForKey:@"rows"]objectAtIndex:self.currentRow  ]valueForKey:@"clerkId"]toString]} withBlock:^(id responseObject, NSError *error) {
//                [SVProgressHUD dismiss ];
                [MBProgressHUD hudHideWithViewcontroller:self];
                
                if (!error) {
                    @try {
                        FLDDLogDebug(@"%@",responseObject);
                        
                    }
                    @catch (NSException *exception) {
                        
                    }
                    @finally {
                        
                    }
                    [self getDictData];
                }else{
//                    [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
                    [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
                }
                
            }];
            
            
            
        }
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.tableView  removeFromSuperview];
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
