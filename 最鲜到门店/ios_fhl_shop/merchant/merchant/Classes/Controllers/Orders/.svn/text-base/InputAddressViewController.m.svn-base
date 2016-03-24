//
//  InputAddressViewController.m
//  merchant
//
//  Created by gs on 14/11/4.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "InputAddressViewController.h"
#import "Reachability.h"
#import "InputAddressssCell.h"
#import "InputAddressNODataView.h"
#import "InputAddDetailViewController.h"
#import "InputMapViewController.h"
@interface InputAddressViewController ()<BMKGeneralDelegate>
@property (assign, nonatomic)BOOL isLianXiangEn;
@property (assign, nonatomic)BOOL  isLianXiangCommon;
@property (assign, nonatomic)BOOL  isLianXiangCH;
@property (strong, nonatomic)NSString* strAddress;
@property (assign, nonatomic)BOOL isFirst;
@property (strong, nonatomic)NSString* strLastOBJ;

@property (strong, nonatomic)NSString* detailAddressed;
@property (strong, nonatomic) NSString *shiName;;

@property (strong, nonatomic)InputAddressNODataView* viewNoData;
@end

@implementation InputAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hiddenMBProgressHUD:) name:@"HIDDENMBProgressHUD" object:nil];
// self.view.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//     [delegate.bmkMapManager start:@"8FcbLvlt2eXjC6TPABOMkQ58" generalDelegate:self];
//     BMKMapManager* bmk = [SelfUser currentSelfUser].userBMKMapManager;
//    if(bmk != nil)
//    {
//       [bmk start:@"8FcbLvlt2eXjC6TPABOMkQ58" generalDelegate:self];
//    }
//    else
//    {
//        bmk = [[BMKMapManager alloc] init];
//        BOOL isAuth =
//        [bmk start:@"8FcbLvlt2eXjC6TPABOMkQ58" generalDelegate:self];
//        //
//        if (!isAuth) {
//            FLDDLogDebug(@"开启失败!");
//        }
//        else
//        {
//            [SelfUser currentSelfUser].userBMKMapManager = bmk;
//        }
//    }
    [self addNavView];
    [self addCountsView];
  
    self.dataArray = [NSMutableArray array];
    self.dataQuArray = [NSMutableArray array];
    self.dataArrayShi = [NSMutableArray array];

     self.isLianXiangCH = YES;
    
   
   
    _searcher =[[BMKSuggestionSearch alloc]init];//建议检索

    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
    self.poiSearchOption = [[BMKCitySearchOption alloc]init];
    self.poiSearchOption.pageIndex = 0;
    self.poiSearchOption.pageCapacity = 10;
    self.poiSearchOption.city= [SelfUser currentSelfUser].cityName ;
    self.poiSearch = [[BMKPoiSearch alloc]init];//poi检索
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti) name:UITextFieldTextDidChangeNotification object:nil];
    if (![self.strCityName isEqualToString:@""]) {
        self.textField.text = self.strCityName;
        [self noti];
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)addNavView{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 74)];
    view.backgroundColor = [UIColor colorWithHex:0xededed];
    [self.view addSubview:view];
    
    UIView* viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 74, WINDOW_WIDTH, 1)];
    viewLine.backgroundColor =[UIColor lightGrayColor];
    viewLine.alpha = 0.35;
    [self.view addSubview:viewLine];
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(35, 30, WINDOW_WIDTH-93, 36)];
    imageView.image = [[UIImage imageNamed:@"searchbar_bg_textfield.png"]stretchableImageWithLeftCapWidth:3 topCapHeight:3];
    [view addSubview:imageView];
    
    
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(42, 30, WINDOW_WIDTH-98, 35)];
    self.textField.placeholder = @"输入小区、写字楼、街道等";
    self.textField.returnKeyType = UIReturnKeyDone;
    [self.textField becomeFirstResponder];
    self.textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [view addSubview:self.textField];
    
    
    
    [self.textField setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    [self.textField setBorderStyle:UITextBorderStyleNone];
    self.textField.delegate = self;
    self.textField.tintColor =[UIColor orangeColor];
    
    
    UIButton* buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLeft.frame = CGRectMake(-5, 25, 44, 44);
    [buttonLeft addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [buttonLeft setImage:[UIImage imageNamed:@"backNOTitle.png"] forState:UIControlStateNormal];
    buttonLeft.tag =1;
    [view addSubview:buttonLeft];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    button.frame = CGRectMake(WINDOW_WIDTH-55, 20, 50, 54);
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 2;
    [button setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    [view addSubview:button];
    
    UIView* viewLine1 =[CommonUtils CommonViewLineWithFrame:CGRectMake(0, 73, WINDOW_WIDTH, 1)];
    [view addSubview:viewLine1];


}
-(void)addCountsView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, WINDOW_WIDTH, WINDOW_HEIGHT  - 74) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
    
    self.viewNoData =[[InputAddressNODataView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, self.tableView.frameHeight)];
    self.viewNoData.hidden = YES;
    
    __weak __typeof(self)weakSelf = self;
    self.viewNoData.buttonPressed= ^(){
        InputMapViewController* input = [[InputMapViewController alloc]init];
        weakSelf.navigationController.navigationBarHidden = NO;
//            CLLocationCoordinate2D colocation2D ;
//            colocation2D.latitude =[[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"coordinate_latitude"] floatValue];
//            colocation2D.longitude = [[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"coordinate_longitude"] floatValue];
        input.colocation2D =[SelfUser currentSelfUser].mddyAdderssedLocationcoorDinate2D;
            [weakSelf.navigationController pushViewController:input animated:YES];
    };
    [self.tableView addSubview:self.viewNoData];
    
//    InputMapViewController* input = [[InputMapViewController alloc]init];
//    CLLocationCoordinate2D colocation2D ;
//    colocation2D.latitude =[[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"coordinate_latitude"] floatValue];
//    colocation2D.longitude = [[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"coordinate_longitude"] floatValue];
//    input.colocation2D =colocation2D;
//    input.isFromAddDetail = YES;
//    [self.navigationController pushViewController:input animated:YES];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        self.navigationController.navigationBarHidden = YES;
    _searcher.delegate = self;
      self.poiSearch.delegate = self;
    }


#pragma mark - UITableViewDataSource
-(void)noti{
    if (self.textField.text.length==0) {
        return;
    }
    _option = [[BMKSuggestionSearchOption alloc] init];
    _option.cityname =  [SelfUser currentSelfUser].cityName;
        if (self.isLianXiangEn) {
                     if (self.isFirst) {
                self.isFirst = NO;
                _option.keyword  =[self.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                BOOL flag = [_searcher suggestionSearch:_option];
    
                if(flag)
                {
                    FLDDLogDebug(@"建议检索发送成功");
    
                }
                else
                {
                    if ([CLLocationManager locationServicesEnabled]==NO) {
                        [[[UIAlertView alloc] initWithTitle:@"提示：" message:@"位置服务发生错误!，请确认是否打开改app的位置服务" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];}
                }
    
            }else {
                self.isLianXiangEn=NO;
    
            }
    
        }else if(self.isLianXiangCommon ) {
             self.isLianXiangCommon = NO;
                    self.isFirst = NO;
                _option.keyword  =[self.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                BOOL flag = [_searcher suggestionSearch:_option];
    
                if(flag)
                {
                    FLDDLogDebug(@"建议检索发送成功");
    
                }
                else
                {
                    if ([CLLocationManager locationServicesEnabled]==NO) {
                        [[[UIAlertView alloc] initWithTitle:@"提示：" message:@"位置服务发生错误!，请确认是否打开改app的位置服务" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];}
                }

    
        }else if( self.isLianXiangCH){
            if (![self.textField.text isEqualToString:self.strLastOBJ]) {
                self.isFirst = NO;
            }
    
            if (!self.isFirst) {
                self.isFirst = YES;
              
                _option.keyword  =[self.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                BOOL flag = [_searcher suggestionSearch:_option];
    
                if(flag)
                {
                    FLDDLogDebug(@"建议检索发送成功");
    
                }
                else
                {

                    if ([CLLocationManager locationServicesEnabled]==NO) {
                        [[[UIAlertView alloc] initWithTitle:@"提示：" message:@"位置服务发生错误!，请确认是否打开改app的位置服务" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];}
                }
                
            }
            
        }
        
     self.strLastOBJ = self.textField.text;

}

-(void)hiddenMBProgressHUD:(NSNotification*)noti
{
//    [SelfUser hudHideWithViewcontroller:self];
//    if ([[noti.userInfo valueForKey:@"analyzeResult"] isEqualToString:@"success"])
//    {
//        self.navigationController.navigationBarHidden = NO;
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    else
//    {
//        [MBProgressHUD hudShowWithStatus:self :@"鲜到君找不到这个地址，请重新输入"];
//    }
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
//    if(0 == self.textField.text .length)
//    {
//        [MBProgressHUD hudShowWithStatus:self :@"鲜到君找不到这个地址，请重新输入"];
//        return NO;
//    }
//    
    [self.textField resignFirstResponder];
//    FLDDLogDebug(@"%@",self.textField.text);
//    
//    
////    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
//    [SelfUser hudShowWithViewcontroller:self];
//    
//    if(self.dataQuArray.count > 0)
//    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"inPutAddress" object:self userInfo:@{@"inPutAddress":self.textField.text,@"detailAdder":[AppManager valueForKey:@"detailAddressed"],@"shiName":[AppManager valueForKey:@"shiName"]}];//本地化是防治再次点进来奔溃
//    }
//    else
//    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"inPutAddress" object:self userInfo:@{@"inPutAddress":self.textField.text,@"detailAdder":self.textField.text,@"shiName":self.textField.text}];
//    }
//
    return YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.textField resignFirstResponder];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* strINTI = @"cell";
    InputAddressssCell* inputCell = [tableView dequeueReusableCellWithIdentifier:strINTI];
    if (!inputCell) {
        inputCell = [[InputAddressssCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
    }
    for (UIView* view in inputCell.contentView.subviews) {
        [view removeFromSuperview];
    }
   
    [inputCell initViewWithAddress:[self.dataArray objectAtIndex:indexPath.row] withCityQu:[self.dataArrayShi objectAtIndex:indexPath.row] WithQu:[self.dataQuArray  objectAtIndex:indexPath.row]];
    return inputCell;
}
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if ([[self.dataArray objectAtIndex:indexPath.row] isEqualToString:[self.dataQuArray objectAtIndex:indexPath.row]]) {
//        self.textField.text = [NSString stringWithFormat:@"%@",[self.dataQuArray objectAtIndex:indexPath.row]];
//        
//        return;
//    }
//    self.textField.text = [NSString stringWithFormat:@"%@%@",[self.dataQuArray objectAtIndex:indexPath.row],[self.dataArray objectAtIndex:indexPath.row]];
//    [self.textField becomeFirstResponder];
//    [self noti];
    [self.textField resignFirstResponder];
    self.detailAddressed = [self.dataArray objectAtIndex:indexPath.row];
    self.shiName =[self.dataArrayShi objectAtIndex:indexPath.row];
    
    [AppManager setUserDefaultsValue:self.detailAddressed key:@"detailAddressed"];
  [AppManager setUserDefaultsValue:self.detailAddressed key:@"shiName"];
    
    [self poiSearchMehtodWithKeyWord:[self.dataArray objectAtIndex:indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    InputAddressssCell* cell =(InputAddressssCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    self.tableView.backgroundColor = [UIColor whiteColor];

//   self.isLianXiangCH = NO ;
    self.isFirst = YES;
    FLDDLogDebug(@"%@",string);
    if ([string isEqualToString:@"，"]||[string isEqualToString:@"➋"]||[string isEqualToString:@"➌"]||[string isEqualToString:@"➍"]||[string isEqualToString:@"➎"]||[string isEqualToString:@"➏"]||[string isEqualToString:@"➐"]||[string isEqualToString:@"➑"]||[string isEqualToString:@"➒"]) {
        self.isLianXiangEn = YES;
        self.isLianXiangCommon  = NO;
        
    }else{
        self.isLianXiangCommon  = YES;
        self.isLianXiangEn = NO;
        
    }
    return YES;
    
    
    
}




//实现Delegate处理回调结果
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        //        FLDDLogDebug(@"%@",result.keyList);
        //        FLDDLogDebug(@"%@",result.cityList);
        //        FLDDLogDebug(@"%@",result.districtList);
           self.tableView.backgroundColor = [UIColor whiteColor];
        [self.dataArray removeAllObjects];
            self.viewNoData.hidden = YES;
        for (NSString* str in result.keyList) {//详细地址
            FLDDLogDebug(@"%@",str);
            [self.dataArray addObject:str];
            
        }
      
        for (NSString* str in result.cityList) {//市
            FLDDLogDebug(@"%@",str);
                  [self.dataArrayShi addObject:str];
        }
        [self.dataQuArray removeAllObjects];
        for (NSString* str in result.districtList) {//区
            [self.dataQuArray addObject:str];
            FLDDLogDebug(@"%@",str);
        }
          [self.tableView reloadData];
    }
    else {
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
//        self.viewNoData.hidden = NO;
//        [self.textField resignFirstResponder];
        FLDDLogInfo(@"抱歉，未找到结果");
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonPressed:(UIButton* )sender{
    [self.textField resignFirstResponder];
    if (sender.tag==1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"inPutAddress" object:self userInfo:@{@"inPutAddress":@"cancel"}];
            _searcher.delegate = nil;
            self.poiSearch.delegate = nil;
            _searcher = nil;
            self.poiSearchOption = nil;
            [self.tableView  removeFromSuperview];
            self.tableView  = nil;
        
            [self.dataArray removeAllObjects];
            self.dataArray = nil;
        
            [self.dataQuArray removeAllObjects];
            self.dataQuArray = nil;
        
            [self.dataArrayShi removeAllObjects];
            self.dataArrayShi = nil;
            
            [self.viewNoData removeFromSuperview];
            self.viewNoData = nil;
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }else{//点击搜索
        [self.textField resignFirstResponder];
        if (self.textField.text.length==0) {
              [MBProgressHUD hudShowWithStatus :self : @"请输入搜索内容"];
            return;
        }
        [self poiSearchMehtodWithKeyWord:self.textField.text];
        
    }
}
-(void)poiSearchMehtodWithKeyWord:(NSString*)keyWord{
    self.poiSearchOption.keyword = keyWord;
    self.textField.text = keyWord;
    BOOL flag = [self.poiSearch poiSearchInCity:self.poiSearchOption];
    if(flag)
    {
        [SelfUser hudShowWithViewcontroller:self];
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        
        NSLog(@"城市内检索发送失败");
    }
 
}
-(void)viewWillDisappear:(BOOL)animated
{
//    _searcher.delegate = nil;
//    self.poiSearch.delegate = nil;
//    _searcher = nil;
//    self.poiSearchOption = nil;
//    [self.tableView  removeFromSuperview];
//    self.tableView  = nil;
//    
//    [self.dataArray removeAllObjects];
//    self.dataArray = nil;
//    
//    [self.dataQuArray removeAllObjects];
//    self.dataQuArray = nil;
//    
//    [self.dataArrayShi removeAllObjects];
//    self.dataArrayShi = nil;
//    
//    [self.viewNoData removeFromSuperview];
//    self.viewNoData = nil;
      self.navigationController.navigationBarHidden = NO;
    if([SelfUser currentSelfUser].userBMKMapManager)
    {
        [[SelfUser currentSelfUser].userBMKMapManager stop];
    }

}
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    [SelfUser hudHideWithViewcontroller:self];
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:10];
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        for (int i = 0; i < poiResult.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];

            FLDDLogDebug(@"%@~~%@~~%@",poi.name,poi.address,poi.city);
           NSMutableDictionary* dictTemp = [NSMutableDictionary dictionary];
            [dictTemp setObject:poi.name forKey:@"name"];
            [dictTemp setObject:poi.address forKey:@"address"];
             [dictTemp setObject:poi.city forKey:@"city"];
             [dictTemp setObject:[NSString stringWithFormat:@"%f",poi.pt.latitude] forKey:@"coordinate_latitude"];
            [dictTemp setObject:[NSString stringWithFormat:@"%f",poi.pt.longitude] forKey:@"coordinate_longitude"];
            [array addObject:dictTemp];
        }
        
       
        InputAddDetailViewController* inputDetail = [[InputAddDetailViewController alloc]init];
        inputDetail.arrayData = array;
        [self.navigationController pushViewController:inputDetail animated:YES];
        self.viewNoData.hidden = YES;
        
    } else if (errorCode == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        self.viewNoData.hidden = NO;
        FLDDLogInfo(@"起始点有歧义");
    } else {
         self.viewNoData.hidden = NO;
           [MBProgressHUD hudShowWithStatus :self : @"搜索失败"];
        // 各种情况的判断。。。
    }
    FLDDLogDebug(@"cerrorCode=%d",errorCode);
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
