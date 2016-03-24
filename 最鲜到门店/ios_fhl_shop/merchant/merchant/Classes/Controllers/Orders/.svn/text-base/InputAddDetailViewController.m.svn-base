//
//  InputAddDetailViewController.m
//  merchant
//
//  Created by gs on 15/7/9.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "InputAddDetailViewController.h"
#import "InputAddressssCell.h"
#import "SoonSendOrderViewController.h"
#import "InputMapViewController.h"
@interface InputAddDetailViewController ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate>

@end

@implementation InputAddDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
     self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, (WINDOW_HEIGHT-64)*0.33, WINDOW_WIDTH, WINDOW_HEIGHT-64-(WINDOW_HEIGHT-64)*0.33) style:UITableViewStylePlain];
    
    
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:[self addMapView]];
    self.tableView.tableFooterView = [self addFootView];
 
    
//        if (self.arrayData.count*135/2+135/4+10 >(WINDOW_HEIGHT-64)*0.69) {
//            
//        }else{
//            self.tableView.frame = CGRectMake(0, WINDOW_HEIGHT-64-( self.arrayData.count*135/2+135/4+10), WINDOW_WIDTH, self.arrayData.count*135/2+135/4+10);
//        }
  
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.labelTitle = [CommonUtils commonSignleLabelWithText:@"" withFontSize:18 withOriginX:WINDOW_WIDTH/2 withOriginY:10 isRelativeCoordinate:YES];
    self.labelTitle.textColor =[UIColor blackColor];
    [self.navigationController.navigationBar addSubview:self.labelTitle];
//    UIButton* button = [CommonUtils commonButtonWithFrame:CGRectMake( WINDOW_WIDTH/2-30,20, 60, 20) withTarget:self withAction:@selector(buttonPressed:)];
//    [button setTitle:@"修改" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:12];
//    button.tag =1;
//    [button setTitleColor:[UIColor colorWithHex:0x007aff] forState:UIControlStateNormal];
//    [self.navigationController.navigationBar addSubview:button];
    
    UIButton* buttonQueRen = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonQueRen setTitle:@"确认" forState:UIControlStateNormal];
    buttonQueRen.frame = CGRectMake(WINDOW_WIDTH-55, 0, 44, 44);
    [buttonQueRen addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    buttonQueRen.tag = 2;
    [buttonQueRen setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:buttonQueRen];
    self.mapView.delegate = self;
       [self addMapViewWithIndexPath:self.tableView.indexPathForSelectedRow];

    
    UIButton* buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLeft.frame = CGRectMake(-5, 0, 44, 44);
    [buttonLeft addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [buttonLeft setImage:[UIImage imageNamed:@"backNOTitle.png"] forState:UIControlStateNormal];
    buttonLeft.tag =3;
    [self.navigationController.navigationBar addSubview:buttonLeft];
    

}
-(UIView*)addFootView{
    UIView* view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 135/4+10)];
    UILabel* labelTitle = [CommonUtils commonSignleLabelWithText:@"没找到想要的地址？" withFontSize:16 withOriginX:15 withOriginY:10 isRelativeCoordinate:YES];
    labelTitle.textColor = [UIColor redColor];
    [view addSubview:labelTitle];
    
    UIView* viewLine = [CommonUtils CommonViewLineWithFrame:CGRectMake(15, 0, WINDOW_WIDTH, 1)];
    [view addSubview:viewLine];
    
    UIButton* button1 = [CommonUtils commonButtonWithFrame:CGRectMake(WINDOW_WIDTH-110, 0, 100, 135/4+10) withTarget:self withAction:@selector(reDingWei)];
    [button1 setTitle:@"去地图上找找" forState:UIControlStateNormal];
    button1.titleLabel.font =[UIFont systemFontOfSize:16];
    [button1 setTitleColor:[UIColor colorWithHex:0x007aff] forState:UIControlStateNormal];
    [view addSubview:button1];
    return view;
}
-(UIView*)addMapView{
    UIView* view = nil;
    if (self.mapView== nil) {
    
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH,(WINDOW_HEIGHT-64)*0.33)];
        self.mapView = [[BMKMapView alloc]init];
        
     
//            if (self.arrayData.count*135/2+135/4+10 >(WINDOW_HEIGHT-64)*0.69) {
                   self.mapView.frame =CGRectMake(0, 0, WINDOW_WIDTH,(WINDOW_HEIGHT-64)*0.33);
//            }else{
////                self.tableView.frame = CGRectMake(0, , WINDOW_WIDTH, self.arrayData.count*135/2+135/4+10);
//                   self.mapView.frame =CGRectMake(0, 0, WINDOW_WIDTH,WINDOW_HEIGHT-64-( self.arrayData.count*135/2+135/4+10));
//            }
     

     
        self.mapView.delegate =self;
        self.mapView.zoomLevel = 16;
        
        [self addMapViewWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [view addSubview:self.mapView];
        
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,self.mapView.frameHeight-10 , WINDOW_WIDTH, 10)];
        
        
        UIImage* image = [UIImage imageNamed:@"search_list_shadow.png"];
        NSInteger leftCapWidth = image.size.width * 0.5f;
        // 顶端盖高度
        NSInteger topCapHeight = image.size.height * 0.5f;
        // 重新赋值
        image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
        imageView.image = image;
        [view addSubview:imageView];
        imageView.userInteractionEnabled = NO;
    }
    return view;
 
}
#pragma mark - UITableViewDataSource

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

#pragma mark - UITableViewDelegate

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
 self.labelTitle.text= [[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"name"];
//    [self.labelTitle sizeToFit];
    self.labelTitle.bounds = CGRectMake(0, 0, 180, 30);
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.center = CGPointMake(WINDOW_WIDTH/2, self.labelTitle.frameHeight/2+8);
    CLLocationCoordinate2D colocation2D ;
    colocation2D.latitude =[[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"coordinate_latitude"] floatValue];
    colocation2D.longitude = [[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"coordinate_longitude"] floatValue];
    self.mapView.centerCoordinate =colocation2D;
    
    [self.mapView removeAnnotation:self.lastAnnotation];
    
    self.lastAnnotation = [[BMKPointAnnotation alloc]init];
    self.lastAnnotation.coordinate = colocation2D;
    [self.mapView addAnnotation:self.lastAnnotation];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    InputAddressssCell* cell =(InputAddressssCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//*根据anntation生成对应的View
//*@param mapView 地图View
//*@param annotation 指定的标注
//*@return 生成的标注View
//*/
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    FLDDLogDebug(@"~~~%@",annotation.title);
    BMKAnnotationView* annotationView1;
    //    FLDDLogDebug(@"1111111%f",annotation.coordinate.latitude);
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        
        //        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
        
        
    }
    
    annotationView.image =  [UIImage imageNamed:@"local_house_map_z-1.png"];
    annotationView.annotation = annotation;
    
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    //    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    annotationView.enabled = NO;
    //    annotationView.selected = YES;
    
    annotationView1 = annotationView;
    [annotationView removeFromSuperview];
    annotationView = nil;
    return annotationView1;
    
    
}
-(void)buttonPressed:(UIButton*)sender{
    if (sender.tag==3) {
          [self removiNanView];
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
    }else if(sender.tag==2){
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
//        if (sender.tag==2) {
        
            [[NSNotificationCenter defaultCenter] postNotificationName:@"inPutAddress" object:self userInfo:@{@"inPutAddress":[NSString stringWithFormat:@"%@",[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"name"] ],@"latitude":[NSString stringWithFormat:@"%f",self.mapView.centerCoordinate.latitude],@"longitude":[NSString stringWithFormat:@"%f",self.mapView.centerCoordinate.longitude]}];
            
//        }else{//返回按钮
//            
//        }
         for(UIViewController* vc in self.navigationController.viewControllers) {
            if ( [vc isKindOfClass:[SoonSendOrderViewController class]] ) {
                [self removiNanView];
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
//
    }
    
    
    [self.tableView removeFromSuperview];
    self.tableView = nil;
}
-(void)reDingWei{//人工定位的地图
   [self removiNanView];
    NSIndexPath *indexPath =[self.tableView indexPathForSelectedRow];
    InputMapViewController* input = [[InputMapViewController alloc]init];
    CLLocationCoordinate2D colocation2D ;
    colocation2D.latitude =[[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"coordinate_latitude"] floatValue];
    colocation2D.longitude = [[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"coordinate_longitude"] floatValue];
   input.colocation2D =colocation2D;
    input.isFir = YES;
    input.strName =[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"name"];
    input.isFromAddDetail = YES;
    [self.navigationController pushViewController:input animated:YES];
    
    
    
}
-(void)removiNanView{
    for (UIView* view in self.navigationController.navigationBar.subviews) {
        if (view.frame.origin.x>=70) {
            [view removeFromSuperview];
        }
        if (view.frame.origin.x == -5) {
            [view removeFromSuperview];
           
        }
        
    }

}
-(void)viewWillDisappear:(BOOL)animated{
    self.mapView.delegate = nil;
    
    
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
