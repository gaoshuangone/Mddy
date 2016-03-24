//
//  InputAddressViewController.h
//  merchant
//
//  Created by gs on 14/11/4.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "BaseTableViewController.h"
@interface InputAddressViewController : BaseViewController<BMKSuggestionSearchDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate ,BMKPoiSearchDelegate>
{
    BMKSuggestionSearch *_searcher;
    BMKSuggestionSearchOption * _option;
}
@property (strong, nonatomic)UITextField* textField;;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic)NSMutableArray* dataArray;
@property (strong, nonatomic)NSMutableArray* dataQuArray;
@property (strong, nonatomic)NSMutableArray* dataArrayShi;
@property (strong , nonatomic)NSString* strCityName;
@property (strong,nonatomic)BMKPoiSearch* poiSearch;
@property (strong, nonatomic)BMKCitySearchOption* poiSearchOption;
@end
