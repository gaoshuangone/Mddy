//
//  InputAddDetailViewController.h
//  merchant
//
//  Created by gs on 15/7/9.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "BaseViewController.h"

@interface InputAddDetailViewController : BaseViewController
{
    NSIndexPath *lastIndexPath;
}
@property(retain,nonatomic) BMKMapView* mapView;
@property (strong, nonatomic) NSMutableArray *arrayData;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) BMKPointAnnotation *lastAnnotation;
@property (strong, nonatomic) UILabel *labelTitle;

@end
