//
//  InputMapViewController.m
//  merchant
//
//  Created by gs on 15/7/10.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "InputMapViewController.h"
#import "CommonUtils+BaiDUMapMothod.h"
#import "SoonSendOrderViewController.h"
#import "ROllLabel.h"
#import "InputAddressssCell.h"
@interface InputMapViewController ()<BMKMapViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIButton* button;
@property (strong, nonatomic) UIImageView* imageView;
@property (assign, nonatomic) BOOL isCanQueRen;

@property (assign, nonatomic) BOOL isDingWeiDoing;
@property (strong, nonatomic) NSString* strError;
@property (strong, nonatomic)ROllLabel* rollLabel;
@property (strong, nonatomic)NSTimer* timer;
@property (strong, nonatomic)NSTimer* timer1;
@property (strong, nonatomic) UIButton* buttonRight;
@property (assign ,nonatomic) CGRect rect;
@property (assign, nonatomic)BOOL isF;


@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayData;
@property (assign, nonatomic) BOOL isSelect;
@end

@implementation InputMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     self.navigationItem.hidesBackButton = YES;
    self.mapView = [[BMKMapView alloc]init];
    self.mapView.frame =CGRectMake(0, 0, WINDOW_WIDTH,(WINDOW_HEIGHT-64)/3*2);


    
    self.mapView.delegate =self;
    self.mapView.zoomLevel = 17;
     self.mapView.centerCoordinate =self.colocation2D;
    [self.view addSubview:self.mapView];
    
    
    
    
    self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 42  , 42)];
    self.imageView.image = [UIImage imageNamed:@"local_house_map_z-1.png"];
    self.imageView.center =CGPointMake(self.view.center.x, self.mapView.center.y);
    [self.view addSubview:self.imageView];

   self.button =[CommonUtils commonButNormalWithFrame:CGRectMake(0, 0, 0, 0) withBounds:CGSizeMake(160, 36.5) withOriginX:self.mapView.center.x withOriginY:self.mapView.center.y-22-25 isRelativeCoordinate:NO withTarget:self withAction:@selector(buttonPressed:)];
    [CommonUtils commonButSetWithButton:self.button WithImageName:@"select_as_adress" withTitle:nil withFontSize:0 withColor:nil];
    [self.view addSubview:self.button];
    
    
     self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, (WINDOW_HEIGHT-64)/3*2, WINDOW_WIDTH, (WINDOW_HEIGHT-64)/3) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    
    
    UIControl*view = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH,(WINDOW_HEIGHT-64)/3*2)];
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,self.mapView.frameHeight-10 , WINDOW_WIDTH, 10)];
    
    UIImage* image = [UIImage imageNamed:@"search_list_shadow.png"];
    NSInteger leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    NSInteger topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    imageView.image = image;
    [view addSubview:imageView];
    view.userInteractionEnabled = NO;
    
    //    imageView.backgroundColor = [UIColor blackColor];
    //    view.backgroundColor =[UIColor redColor];
    imageView.userInteractionEnabled = NO;
    [self.view addSubview:view];
    
    
//    self.tableView.tableFooterView = [self addFootView];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    UIButton* buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLeft.frame = CGRectMake(-5, 0, 44, 44);
    [buttonLeft addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [buttonLeft setImage:[UIImage imageNamed:@"backNOTitle.png"] forState:UIControlStateNormal];
    buttonLeft.tag =1;
    [self.navigationController.navigationBar addSubview:buttonLeft];

    self.buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonRight setTitle:@"确认" forState:UIControlStateNormal];
    self.buttonRight.frame = CGRectMake(WINDOW_WIDTH-55, 0, 44, 44);
    [self.buttonRight addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonRight.tag = 3;
    self.buttonRight.userInteractionEnabled = YES;
    [self.buttonRight setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:self.buttonRight];
 
    [CommonUtils commonGeoCodeSearchWithCity:nil withTagget:self withAddress:nil withCoor2D:self.mapView.centerCoordinate withBlock:^(BOOL isSuccess) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* strINTI = @"cell";
    InputAddressssCell* inputCell = [tableView dequeueReusableCellWithIdentifier:strINTI];
    if (!inputCell) {
        inputCell = [[InputAddressssCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
    }
    inputCell.accessoryView = nil;
    for (UIView* view in inputCell.contentView.subviews) {
        
        NSLog(@"%@",view);
        [view removeFromSuperview];
    }
    [inputCell initViewWithAddress:[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"name"] withCityQu:[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"address"] WithQu:nil];
    
    inputCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (lastIndexPath== nil )  {
        if (indexPath.row==0) {
            lastIndexPath=indexPath;
            NSLog(@"%ld",(long)indexPath.row);
            UIImageView* imageViewAcc =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
            imageViewAcc.image = [UIImage imageNamed:@"check_list_mark"];
            inputCell.accessoryView = imageViewAcc;
        }
    }else{
        if (indexPath.row== lastIndexPath.row) {
            
            UIImageView* imageViewAcc =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
            imageViewAcc.image = [UIImage imageNamed:@"check_list_mark"];
            inputCell.accessoryView = imageViewAcc;
            
        }
    }
    
    return inputCell;
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger newRow = [indexPath row];
    NSInteger oldRow = [lastIndexPath row];
    
    if (newRow != oldRow)
    {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:
                                    indexPath];
        UIImageView* imageViewAcc =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        imageViewAcc.image = [UIImage imageNamed:@"check_list_mark"];
        newCell.accessoryView = imageViewAcc;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:
                                    lastIndexPath];
        oldCell.accessoryView = UITableViewCellAccessoryNone;
        
        lastIndexPath = indexPath;
    }
    
    [self addMapViewWithIndexPath:indexPath];
}
-(void)addMapViewWithIndexPath:(NSIndexPath*)indexPath{
    
        self.isSelect = YES;
    CLLocationCoordinate2D colocation2D ;
    colocation2D.latitude =[[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"coordinate_latitude"] floatValue];
    colocation2D.longitude = [[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"coordinate_longitude"] floatValue];
    self.mapView.centerCoordinate =colocation2D;
    
   [self TimeWith:self.rollLabel withTitle:[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"name"]];
      self.isCanQueRen = YES;
}

-(void)TimeWith:(ROllLabel*)roll withTitle:(NSString*)title{
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        [self.timer1 invalidate];
        self.timer1 = nil;
    
    }
    
//    title = @"11哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈~~";
    CGRect rect = [title boundingRectWithSize:CGSizeMake(1000, 44) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    self.rect = rect;
    [self.rollLabel removeFromSuperview];
    self.rollLabel = nil;
  
    
    if (rect.size.width>=200) {
          self.rollLabel = [ROllLabel rollLabelTitle:title color:UICOLOR(248, 78, 11, 1) font:[UIFont systemFontOfSize:18] superView:self.navigationController.navigationBar fram:CGRectMake(40, 0, 200, 44)];
    }else{
         self.rollLabel = [ROllLabel rollLabelTitle:title color:UICOLOR(248, 78, 11, 1) font:[UIFont systemFontOfSize:18] superView:self.navigationController.navigationBar fram:CGRectMake(40, 0, rect.size.width, 44)];
    }
    self.rollLabel.center = CGPointMake(WINDOW_WIDTH/2, 22);
    [self.navigationController.navigationBar addSubview:self.rollLabel];
        if (rect.size.width>=200) {
//            [self performSelector:@selector(onTimer) withObject:sel f];
            [NSTimer timerWithTimeInterval:0 target:self selector:@selector(onTimer) userInfo:nil repeats:NO];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
            
             self.timer1 =   [NSTimer scheduledTimerWithTimeInterval:7.88 target:self selector:@selector(onTimer1) userInfo:nil repeats:YES];
//        [self.timer fire];
//                    NSLog(@"~~!!!!~~~%f",self.rollLabel.contentOffset.x);
//                  [self.rollLabel setContentOffset:CGPointMake(ceil(self.rect.size.width)-200, 0)];
//                  NSLog(@"~~!!!!~~~%f",self.rollLabel.contentOffset.x);
//                  [self.rollLabel setContentOffset:CGPointMake(0, 0)];
    }
   
}
-(void)onTimer{

  

//    [UIView animateWithDuration:8 animations:^{
//    
//        
//
//             [self.rollLabel setContentOffset:CGPointMake(ceil(self.rect.size.width), 0)];
//    } completion:^(BOOL finished) {
//        
    
//  [self.rollLabel setContentOffset:CGPointMake(-150, 0)];
//
//    }];
        __weak __typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:8 animations:^{
       [weakSelf.rollLabel setContentOffset:CGPointMake(ceil(self.rect.size.width), 0)];
    }];
//           [self.rollLabel setContentOffset:CGPointMake(-100, 0)];
}
-(void)onTimer1{
        [self.rollLabel setContentOffset:CGPointMake(-180, 0)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *地图区域即将改变时会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
//    self.button.hidden = YES;
    self.button.alpha = 0;

}

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
   
    [self shakeView:self.imageView];
 
           [self TimeWith:self.rollLabel withTitle:@"定位中..."];
    
    if (self.isF) {
        if (!self.isSelect) {
            
          self.isDingWeiDoing = YES;
        [CommonUtils commonGeoCodeSearchWithCity:nil withTagget:self withAddress:nil withCoor2D:self.mapView.centerCoordinate withBlock:^(BOOL isSuccess) {
           
       
         
        }];
            
        }
        self.isSelect = NO;
    }
  
    
}
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
errorCode:(BMKSearchErrorCode)error{
    self.isDingWeiDoing = NO;
  if (error == BMK_SEARCH_NO_ERROR) {
       self.isF = YES;
//      NSLog(@"%@",result.address);
      NSLog(@"～～～～～～～～%@,%@",result.addressDetail.streetName,result.addressDetail.streetNumber);

      
      if (self.arrayData) {
          [self.arrayData  removeAllObjects];
          self.arrayData = nil;
      }
      self.arrayData = [NSMutableArray arrayWithCapacity:5];
      for (int i = 0; i < result.poiList.count; i++) {
          BMKPoiInfo* poi = [result.poiList objectAtIndex:i];
          
          FLDDLogDebug(@"%@~~%@~~%@",poi.name,poi.address,poi.city);
          NSMutableDictionary* dictTemp = [NSMutableDictionary dictionary];
          [dictTemp setObject:poi.name forKey:@"name"];
          [dictTemp setObject:poi.address forKey:@"address"];
          [dictTemp setObject:poi.city forKey:@"city"];
          [dictTemp setObject:[NSString stringWithFormat:@"%f",poi.pt.latitude] forKey:@"coordinate_latitude"];
          [dictTemp setObject:[NSString stringWithFormat:@"%f",poi.pt.longitude] forKey:@"coordinate_longitude"];
          [self.arrayData addObject:dictTemp];
          
      }
      [self.tableView reloadData];
      [self.tableView setContentOffset:CGPointMake(0, 0)];
      NSString* str = nil;
      if (self.isFir) {
          str = self.strName;
          self.isFir = NO;
      }else{
    str =[NSString stringWithFormat:@"%@%@%@",result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber];
          self.strName = str;
      }
    
      if (str.length<=1) {
          str = @"无效定位";
          self.strError =@"无效定位";
        
          self.button.alpha = 0;
          self.buttonRight.userInteractionEnabled = NO;
          [self.buttonRight setTitleColor:UICOLOR(254, 185, 131, 1) forState:UIControlStateNormal];
      
          
          [self TimeWith:self.rollLabel withTitle:@"无效定位"];
      }else{
          [UIView animateWithDuration:0.5 animations:^{
              self.button.alpha = 1;
          }];
          self.isCanQueRen = YES;
            self.buttonRight.userInteractionEnabled = YES;
              [self.buttonRight setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
          NSIndexPath* index  = [self.tableView indexPathForSelectedRow];
          if (self.arrayData.count==0) {
              
              [self TimeWith:self.rollLabel withTitle:self.strName];
          }else{
              self.strName =[[[self.arrayData objectAtIndex:index.row] valueForKey:@"name"] toString];
          [self TimeWith:self.rollLabel withTitle:[[[self.arrayData objectAtIndex:index.row] valueForKey:@"name"] toString]];
          }
      }
  
//      self.labelTitle.text=str;
//      //    [self.labelTitle sizeToFit];
//      self.labelTitle.bounds = CGRectMake(0, 0, 180, 30);
//      self.labelTitle.textAlignment = NSTextAlignmentCenter;
//      self.labelTitle.center = CGPointMake(WINDOW_WIDTH/2, self.labelTitle.frameHeight/2);
      
      
      
      NSInteger newRow = [NSIndexPath indexPathForRow:0 inSection:0].row;
      NSInteger oldRow = lastIndexPath.row;
      
      if (newRow != oldRow)
      {
          UITableViewCell *newCell = [self.tableView cellForRowAtIndexPath:
                                      [NSIndexPath indexPathForRow:0 inSection:0]];
          UIImageView* imageViewAcc =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
          imageViewAcc.image = [UIImage imageNamed:@"check_list_mark"];
          newCell.accessoryView = imageViewAcc;
          
          UITableViewCell *oldCell = [self.tableView cellForRowAtIndexPath:
                                      lastIndexPath];
          oldCell.accessoryView = UITableViewCellAccessoryNone;
          
          lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
      }
//    [UIView animateWithDuration:3 animations:^{
////        self.labelTitle.center = CGPointMake(-WINDOW_WIDTH/2, self.labelTitle.frameHeight/2);
//    } completion:^(BOOL finished) {
//        self.labelTitle.center = CGPointMake(WINDOW_WIDTH/2, self.labelTitle.frameHeight/2);
//
//    }];
  }
  else {
      NSLog(@"抱歉，未找到结果");
       self.strError =@"定位失败";
        [self TimeWith:self.rollLabel withTitle:@"无效定位"];
      self.buttonRight.userInteractionEnabled = NO;
      [self.buttonRight setTitleColor:UICOLOR(254, 185, 131, 1) forState:UIControlStateNormal];
  }
}
-(void)shakeView:(UIView*)viewToShake
{
    CGFloat t =3.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, 0.0,t);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,0.0,-t);
    
    viewToShake.transform = translateLeft;
    
    [UIView animateWithDuration:0.12 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:1.0];
        viewToShake.transform = translateRight;
        
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
  
}
-(void)buttonPressed:(UIButton*)sender{
    if (sender.tag ==1) {//返回
        [self removiNanView];
        if (self.isFromAddDetail) {
            
        }else{
            self.navigationController.navigationBarHidden = YES;
            //        for (UIViewController* vc in self.navigationController.viewControllers) {
            //            if ( [vc isKindOfClass:[InputMapViewController class]] ) {
            //                [self removiNanView];
            //                [self.navigationController popToViewController:vc animated:YES];
            //            }
            //        }
        }
        [self.navigationController popViewControllerAnimated:YES];
  

    }else{
        if (self.isDingWeiDoing) {
            [MBProgressHUD hudShowWithStatus :self : @"正在定位中，确认失败"];
            return;
        }
    
        
        
        if (self.isCanQueRen) {
            self.isCanQueRen = NO;
            
            NSIndexPath* index  = [self.tableView indexPathForSelectedRow];
            
            if (self.arrayData.count==0) {
                
            [[NSNotificationCenter defaultCenter] postNotificationName:@"inPutAddress" object:self userInfo:@{@"inPutAddress":self.strName,@"latitude":[NSString stringWithFormat:@"%f",self.mapView.centerCoordinate.latitude],@"longitude":[NSString stringWithFormat:@"%f",self.mapView.centerCoordinate.longitude]}];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"inPutAddress" object:self userInfo:@{@"inPutAddress":[[[self.arrayData objectAtIndex:index.row] valueForKey:@"name"] toString],@"latitude":[NSString stringWithFormat:@"%f",self.mapView.centerCoordinate.latitude],@"longitude":[NSString stringWithFormat:@"%f",self.mapView.centerCoordinate.longitude]}];
            }
            
            for (UIViewController* vc in self.navigationController.viewControllers) {
                if ( [vc isKindOfClass:[SoonSendOrderViewController class]] ) {
                    [self removiNanView];
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }else{
          
          
            
        
        }
    }

}
-(void)removiNanView{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        [self.timer1 invalidate];
        self.timer1 = nil;
        
    }
    
    if (self.rollLabel) {
        [self.rollLabel removeFromSuperview];
        self.rollLabel = nil;
    }
  

    for (UIView* view in self.navigationController.navigationBar.subviews) {
        if (view.frame.origin.x>=70) {
            [view removeFromSuperview];
        }
        if (view.frame.origin.x == -5) {
            [view removeFromSuperview];
        }
        
    }
    self.mapView.delegate = nil;
    [self.mapView removeFromSuperview];
    self.mapView = nil;
    
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    
}
//-(UIView*)addFootView{
//    UIView* view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 135/4+10)];
//    UILabel* labelTitle = [CommonUtils commonSignleLabelWithText:@"没找到想要的地址？" withFontSize:16 withOriginX:15 withOriginY:10 isRelativeCoordinate:YES];
//    labelTitle.textColor = [UIColor redColor];
//    [view addSubview:labelTitle];
//    
//    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(15, 0, WINDOW_WIDTH, 1)];
//    [view addSubview:viewLine];
//    
//    UIButton* button1 = [CommonUtils commonButtonWithFrame:CGRectMake(WINDOW_WIDTH-110, 0, 100, 135/4+10) withTarget:self withAction:@selector(reDingWei)];
//    [button1 setTitle:@"去地图上找找" forState:UIControlStateNormal];
//    button1.titleLabel.font =[UIFont systemFontOfSize:16];
//    [button1 setTitleColor:[UIColor colorWithHex:0x007aff] forState:UIControlStateNormal];
//    [view addSubview:button1];
//    return view;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
