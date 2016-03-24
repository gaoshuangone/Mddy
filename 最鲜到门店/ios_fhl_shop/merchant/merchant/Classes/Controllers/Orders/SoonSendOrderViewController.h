//
//  SoonSendOrderViewController.h
//  merchant
//
//  Created by gs on 14/11/4.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BMapKit.h"
@interface SoonSendOrderViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,BMKGeoCodeSearchDelegate,BMKRouteSearchDelegate>
@property (strong, nonatomic) BMKGeoCodeSearch *searcher;
@property (nonatomic, strong) BMKRouteSearch *routeSearch;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic)UITextField* textFieldPhoneNumber;
@property (strong, nonatomic)UITextField* textFieldJinE;
@property (strong, nonatomic)UITextView* textViewBeiZhu;

@property (strong, nonatomic)UIImageView* imageViewStatus;
@property (strong, nonatomic)UIButton* buttonArea;
@property (strong, nonatomic)UIButton* buttonDianFu;
@property (strong, nonatomic)UIPickerView* pickView;
@property (strong, nonatomic)UILabel* textFieldAddressedDetail;
@property (strong, nonatomic)UITextField* textViewAddressedDetail;
@property (strong, nonatomic)UIButton* buttonInputTEL;
@property (strong, nonatomic)UITextField* textFenJi;

@property (strong, nonatomic)UILabel* sysPhoneNumber;
@property (strong, nonatomic)UILabel* sysName;
@property (strong, nonatomic)UILabel* sysAddress;
@property (strong, nonatomic)UILabel* sysDianFu;
@property (strong, nonatomic)UILabel* sysJinE;
@property (strong, nonatomic)UILabel* labelFuHao;
@property (strong, nonatomic)UILabel* labelFuHao1;
@property (strong, nonatomic)UITextField* textFiledQuHao;


@end
