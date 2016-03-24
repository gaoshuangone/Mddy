//
//  RegisterViewController.m
//  FHL
//
//  Created by panume on 14-9-23.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIImageView+Circle.h"
#import "TextFieldCell.h"
#import "IdImageCell.h"
#import "TextFieldEnableCell.h"
#import "AreaPickerView.h"
#import "WebViewController.h"
#import "PickerView.h"
#import "User.h"

#define PORTRAIT            @"UserPortrait"
#define NAME                @"UserName"
#define MOBILE              @"UserMobile"
#define IDENTITY            @"UserId"
#define FRONT_ID            @"UserFrontId"
#define BACK_ID             @"UserBackId"
#define WORKAREA            @"UserWorkArea"
#define TRANSPOT            @"UserTranspot"
#define EXPERIENCE          @"UserExperience"
#define RECOMMEND_MOBILE    @"UserRecomMobile"

typedef NS_ENUM(NSUInteger, TABLE_VIEW_SECTION) {
    TABLE_VIEW_SECTION_INFO = 0,
    TABLE_VIEW_SECTION_IDIMAGE,
    TABLE_VIEW_SECTION_WORKAREA,
    TABLE_VIEW_SECTION_TRANSPOT,
    TABLE_VIEW_SECTION_EXPERIENCE,
    TABLE_VIEW_SECTION_RECOMMEND,
    TABLE_VIEW_SECTION_COUNT
};

typedef NS_ENUM(NSUInteger, TABLE_VIEW_ROW) {
    TABLE_VIEW_ROW_NAME,
    TABLE_VIEW_ROW_MOBILE,
    TABLE_VIEW_ROW_ID,
    TABLE_VIEW_ROW_COUNT
};

@interface RegisterViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>
{
    NSInteger selectedShowTag;
    NSInteger selectedAddTag;
    BOOL isAccept;
    CGFloat contentOffsetY;
}

@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextField *selectedTextField;
@property (nonatomic, strong) AreaPickerView *areaPickerView;
@property (nonatomic, strong) PickerView *transpotPickerView;
@property (nonatomic, strong) PickerView *exPickerView;

@property (nonatomic, strong) NSMutableDictionary *userInfo;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *recommendMobile;
@property (nonatomic, strong) NSString *identity;

@property (nonatomic, strong) UIImage *frontImage;
@property (nonatomic, strong) UIImage *backImage;
@property (nonatomic, strong) UIImage *portrait;

@property (nonatomic, assign) NSInteger transportIndex;
@property (nonatomic, assign) NSInteger experienceIndex;

@property (nonatomic, strong) NSString *provinceCode;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *districtCode;


@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"注册";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - 64);
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footerView;
    isAccept = NO;
    
    self.userInfo = [NSMutableDictionary dictionary];
    
    self.transportIndex = -1;
    self.experienceIndex = -1;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)headView
{
    if (!_headView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 120)];
        view.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        
        self.imageView = [UIImageView circleImageViewFrame:CGRectMake(0, 0, 80, 80) Radius:40];
        self.imageView.center = CGPointMake(WINDOW_WIDTH / 2, view.bounds.size.height / 2);
        self.imageView.image = [UIImage imageNamed:@"photo_nomal_bg.png"];
        [view addSubview:self.imageView];
        
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButton.frame = self.imageView.frame;
        imageButton.tag = 1000;
        [imageButton addTarget:self action:@selector(showBigImageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:imageButton];
        
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(0, 0, 32, 32);
        addButton.center = CGPointMake(CGRectGetMaxX(imageButton.frame) - addButton.bounds.size.width / 2, CGRectGetMaxY(imageButton.frame) - addButton.bounds.size.width / 2);
        addButton.tag = 2000;
        [addButton setBackgroundImage:[UIImage imageNamed:@"shooting_n.png"] forState:UIControlStateNormal];
        [addButton setBackgroundImage:[UIImage imageNamed:@"shooting_p.png"] forState:UIControlStateHighlighted];
        [addButton addTarget:self action:@selector(addImageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:addButton];
        
        _headView = view;
        
        return view;
    }
    
    return _headView;
}

- (UIView *)footerView
{
    if (!_footerView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 136)];
        view.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        
        UIButton *radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        radioButton.frame = CGRectMake(90, 20, 60, 40);
        if (!isAccept) {
            [radioButton setImage:[UIImage imageNamed:@"checkbox_n.png"] forState:UIControlStateNormal];
        }
        else {
            [radioButton setImage:[UIImage imageNamed:@"checkbox_p.png"] forState:UIControlStateNormal];

        }
        [radioButton addTarget:self action:@selector(radioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:radioButton];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"我接受最鲜到的注册协议"];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x007aff] range:NSMakeRange(7, 4)];
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(7, 4)];
        [attributedString addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.baidu.com"] range:NSMakeRange(7, 4)];
        
        UILabel *protocol = [[UILabel alloc] init];
        protocol.attributedText = attributedString;
        protocol.font = [UIFont systemFontOfSize:13.0f];
        [protocol sizeToFit];
        protocol.backgroundColor = [UIColor clearColor];
        protocol.center = CGPointMake(WINDOW_WIDTH / 2 + 20, radioButton.center.y);
        [view addSubview:protocol];

        radioButton.center = CGPointMake(CGRectGetMinX(protocol.frame) - 15, protocol.center.y);//
        
        UIButton *protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        protocolButton.frame = CGRectMake(CGRectGetMaxX(protocol.frame) - protocol.bounds.size.width / 11 * 4, CGRectGetMinY(protocol.frame) - 10, protocol.bounds.size.width / 11 * 4, protocol.bounds.size.height + 20);
        protocolButton.backgroundColor = [UIColor clearColor];
        [protocolButton addTarget:self action:@selector(protocolButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:protocolButton];
        
        UIImage *normalImage = [UIImage imageNamed:@"buttonnormal_n.png"];
        UIImage *highlightImage = [UIImage imageNamed:@"buttonnormal_p.png"];
        UIImage *disableImage = [UIImage imageNamed:@"buttonnormal_d.png"];
        
        highlightImage = [highlightImage stretchableImageWithLeftCapWidth:highlightImage.size.width * 0.5 topCapHeight:highlightImage.size.height * 0.5];
        disableImage = [disableImage stretchableImageWithLeftCapWidth:disableImage.size.width * 0.5 topCapHeight:disableImage.size.height * 0.5];
        normalImage = [normalImage stretchableImageWithLeftCapWidth:normalImage.size.width * 0.5 topCapHeight:normalImage.size.height * 0.5];
        
        self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.registerButton.frame = CGRectMake(0, 0, WINDOW_WIDTH - 32, 44);
        [self.registerButton setBackgroundImage:normalImage forState:UIControlStateNormal];
        [self.registerButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
        [self.registerButton setBackgroundImage:disableImage forState:UIControlStateDisabled];
        
        self.registerButton.enabled = NO;

        [self.registerButton setTitle:@"提交" forState:UIControlStateNormal];
        [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.registerButton.center = CGPointMake(WINDOW_WIDTH / 2, CGRectGetMaxY(protocol.frame) + 20 + 20);
        [self.registerButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.registerButton];
        
        return view;
    }
    return _footerView;
}

#pragma mark -
#pragma mark - Private

- (IBAction)radioButtonPressed:(UIButton *)sender
{
    if (self.selectedTextField) {
        [self.selectedTextField resignFirstResponder];
        return;
    }
    
    isAccept = !isAccept;
    
    if (!isAccept) {
        [sender setImage:[UIImage imageNamed:@"checkbox_n.png"] forState:UIControlStateNormal];
    }
    else {
        [sender setImage:[UIImage imageNamed:@"checkbox_p.png"] forState:UIControlStateNormal];
        
    }
}


- (IBAction)protocolButtonPressed:(id)sender
{
    if (self.selectedTextField) {
        [self.selectedTextField resignFirstResponder];
        return;
    }
    
    WebViewController *webViewController = [[WebViewController alloc] init];
    webViewController.type = WebViewTypeRegister;
    webViewController.title = @"注册条款";
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)showBigImageButtonPressed:(UIButton *)sender
{
    if (self.selectedTextField) {
        [self.selectedTextField resignFirstResponder];
        return;
    }
    
    if (!sender.currentBackgroundImage) {
        return;
    }
    
    selectedShowTag = sender.tag;
}

- (IBAction)addImageButtonPressed:(UIButton *)sender
{
    if (self.selectedTextField) {
        [self.selectedTextField resignFirstResponder];
        return;
    }
    selectedAddTag = sender.tag;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"相册",@"拍照", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}


- (IBAction)submitButtonPressed:(id)sender
{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

    return;
    if (self.selectedTextField) {
        [self.selectedTextField resignFirstResponder];
        return;
    }
    NSMutableDictionary *muImageParams = [NSMutableDictionary dictionary];
    
    if (self.portrait) {
        [muImageParams setObject:self.portrait forKey:@"portrait"];
    }
    else {
        return;
    }
    
    
    if (self.frontImage) {
        [muImageParams setObject:self.frontImage forKey:@"frontId"];
    }
    else {
        return;
    }
    
    if (self.backImage) {
        [muImageParams setObject:self.backImage forKey:@"backId"];
    }
    else {
        return;
    }
    
    self.userInfo = [self checkInfo];
    
    if (!self.userInfo) {
        return;
    }
    
    [User registerWithParams:self.userInfo imageDate:muImageParams block:^(NSError *error) {
        if (error) {
            NSLog(@"error");
        }
        else {
            WebViewController *webViewController = [[WebViewController alloc] init];
            [self.navigationController pushViewController:webViewController animated:YES];
        }
    }];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backBarButtonPressed:(id)sender
{
    if (self.selectedTextField) {
        [self.selectedTextField resignFirstResponder];
        return;
    }
    [AppManager setUserDefaultsValue:@"0" key:@"isRegister"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (NSMutableDictionary *)checkInfo
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionary];
    
    if (self.name.length > 0) {
        [muParams setObject:self.name forKey:@"name"];
    }
    else {
        return nil;
    }
    
    if (self.mobile.length > 0) {
        [muParams setObject:self.mobile forKey:@"mobile"];
    }
    else {
        return nil;
    }
    
    if (self.identity.length > 0) {
        [muParams setObject:self.identity forKey:@"identify"];
    }
    else {
        return nil;
    }
    
    if (self.provinceCode.length > 0) {
        [muParams setObject:self.provinceCode forKey:@"provinceCode"];
    }
    else {
        return nil;
    }
    
    if (self.cityCode.length > 0) {
        [muParams setObject:self.cityCode forKey:@"cityCode"];
    }
    else {
        return nil;
    }
    
    if (self.districtCode.length > 0) {
        [muParams setObject:self.districtCode forKey:@"districtCode"];
    }
    else {
        return nil;
    }
    
    if (self.transportIndex != -1) {
        [muParams setObject:@(self.transportIndex) forKey:@"transpot"];
    }
    else {
        return nil;
    }
    
    if (self.experienceIndex != -1) {
        [muParams setObject:@(self.experienceIndex) forKey:@"experience"];
    }
    else {
        return nil;
    }
    
    if (self.recommendMobile.length > 1) {
        [muParams setObject:self.recommendMobile forKey:@"recommend"];
    }
    
    if (muParams != nil) {
        self.registerButton.enabled = YES;
    }
    
    if (!isAccept) {
        return nil;
    }
    
    
    return muParams;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TABLE_VIEW_SECTION_COUNT;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        
        case TABLE_VIEW_SECTION_INFO:
            return 3;
            break;
        
        case TABLE_VIEW_SECTION_IDIMAGE:
            return 1;
            break;
        
        case TABLE_VIEW_SECTION_WORKAREA:
            return 1;
            break;
        
        case TABLE_VIEW_SECTION_TRANSPOT:
            return 1;
            break;
        
        case TABLE_VIEW_SECTION_EXPERIENCE:
            return 1;
            break;
            
        case TABLE_VIEW_SECTION_RECOMMEND:
            return 1;
            break;
        
        default:
        break;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == TABLE_VIEW_SECTION_INFO) {
        
        NSString *cellIdentifier = @"";
        
        if (indexPath.row == TABLE_VIEW_ROW_NAME) {
            cellIdentifier = @"NameCell";
            
        }
        else if (indexPath.row == TABLE_VIEW_ROW_MOBILE) {
            cellIdentifier = @"MobileCell";
        }
        else if (indexPath.row == TABLE_VIEW_ROW_ID) {
            cellIdentifier = @"IdentifyCell";

        }
        
        TextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!textFieldCell) {
            textFieldCell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            if (indexPath.row == TABLE_VIEW_ROW_NAME) {
                textFieldCell.title = @"姓名";
                textFieldCell.textField.placeholder = @"请输入真实姓名";
                textFieldCell.textField.delegate = self;
                textFieldCell.textField.returnKeyType = UIReturnKeyNext;
                textFieldCell.textField.keyboardType = UIKeyboardTypeDefault;
            }
            else if (indexPath.row == TABLE_VIEW_ROW_MOBILE) {
                textFieldCell.title = @"手机";
                textFieldCell.textField.text = @"151 5804 0551";
                textFieldCell.textField.enabled = NO;
                
                self.mobile = textFieldCell.textField.text;
//                textFieldCell.textField.delegate = self;
//                textFieldCell.textField.returnKeyType = UIReturnKeyNext;
//                textFieldCell.textField.keyboardType = UIKeyboardTypeNumberPad;

            }
            else {
                textFieldCell.title = @"身份证号";
                textFieldCell.textField.placeholder = @"请输入身份证号";
                textFieldCell.textField.delegate = self;
                textFieldCell.textField.returnKeyType = UIReturnKeyDone;
                textFieldCell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            }
        }
        
        cell = textFieldCell;
    }
    else if (indexPath.section == TABLE_VIEW_SECTION_IDIMAGE) {
        
        static NSString *cellIdentifier = @"IdValueCell";
        
        IdImageCell *idValueCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!idValueCell) {
            idValueCell = [[IdImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier type:IdImageCellTypeEditable];
            
            [idValueCell.frontButton addTarget:self action:@selector(showBigImageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            idValueCell.frontButton.tag = 1001;
            [idValueCell.addFrontButton addTarget:self action:@selector(addImageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            idValueCell.addFrontButton.tag = 2001;
            [idValueCell.backButton addTarget:self action:@selector(showBigImageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            idValueCell.backButton.tag = 1002;
            [idValueCell.addBackButton addTarget:self action:@selector(addImageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            idValueCell.addBackButton.tag = 2002;
            
        }
        
        cell = idValueCell;
        
    }
    else if (indexPath.section == TABLE_VIEW_SECTION_WORKAREA) {
        static NSString *cellIdentifier = @"AreaValueCell";
     
        TextFieldEnableCell *areaValueCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!areaValueCell) {
            areaValueCell = [[TextFieldEnableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            areaValueCell.textField.placeholder = @"请选择工作区域";
        }
        
        cell = areaValueCell;
        
    }
    else if (indexPath.section == TABLE_VIEW_SECTION_TRANSPOT) {
        static NSString *cellIdentifier = @"TranspotValueCell";
        
        TextFieldEnableCell *transpotValueCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!transpotValueCell) {
            transpotValueCell = [[TextFieldEnableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            transpotValueCell.textField.placeholder = @"请选择交通工具";
        }
        
        cell = transpotValueCell;
        
    }
    else if (indexPath.section == TABLE_VIEW_SECTION_EXPERIENCE) {
        static NSString *cellIdentifier = @"ExperienceValueCell";
 
        TextFieldEnableCell *experienceValueCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!experienceValueCell) {
            experienceValueCell = [[TextFieldEnableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            experienceValueCell.textField.placeholder = @"请选择配送经验";
        }
        
        cell = experienceValueCell;
     
        
    }
    else {
        static NSString *cellIdentifier = @"RecommandCell";
        TextFieldCell *recommendCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!recommendCell) {
            recommendCell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            recommendCell.title = @"推荐人手机号";
            [recommendCell.titleLabel sizeToFit];
            //resize the textField
            recommendCell.textField.delegate = self;
            recommendCell.textField.frame = CGRectMake(0, 0, recommendCell.textField.bounds.size.width - 20, recommendCell.textField.bounds.size.height);
            recommendCell.textField.center = CGPointMake(CGRectGetMaxX(recommendCell.titleLabel.frame) + recommendCell.textField.bounds.size.width / 2 + 5, recommendCell.titleLabel.center.y);
            recommendCell.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        cell = recommendCell;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectedTextField) {
        [self.selectedTextField resignFirstResponder];
        return;
    }
    
    __block CGPoint point = tableView.contentOffset;//弹出pickerView前tableView的contentOffset
    
    CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
    if (rect.size.height + rect.origin.y - self.tableView.contentOffset.y  <= WINDOW_HEIGHT - 64 - 162) {
        NSLog(@"ok");
    }
    else {
        
        if (indexPath.section == TABLE_VIEW_SECTION_RECOMMEND) {
            return;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.tableView setContentOffset:CGPointMake(0, -(WINDOW_HEIGHT - 64 - 162 - rect.size.height - rect.origin.y - 20))];
            
        }];
    }
    
    __weak typeof(self)weakSelf = self;

    if (indexPath.section == TABLE_VIEW_SECTION_WORKAREA ) {
        
        if (self.areaPickerView == nil) {
            self.areaPickerView = [[AreaPickerView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)];
//            [self.areaPickerView showWithSuperView:self.navigationController.view];
            
            self.areaPickerView.selectDistrictAction = ^(NSDictionary *nameInfo, NSDictionary *codeInfo){
                
                TextFieldEnableCell *cell = (TextFieldEnableCell *)[weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:TABLE_VIEW_SECTION_WORKAREA]];
                if (cell) {
                    cell.textField.text = [NSString stringWithFormat:@"%@%@%@",[nameInfo objectForKey:PROVINCE_NAME], [nameInfo objectForKey:CITY_NAME], [nameInfo objectForKey:DISTRICT_NAME]];
                    
                    weakSelf.provinceCode = [codeInfo objectForKey:PROVINCE_CODE];
                    weakSelf.cityCode = [codeInfo objectForKey:CITY_CODE];
                    weakSelf.districtCode = [codeInfo objectForKey:DISTRICT_CODE];
                    
                }
            };
            
            self.areaPickerView.dismissAction = ^(void){
                [weakSelf checkInfo];
                weakSelf.areaPickerView = nil;
            };
        }
       
    }
    else if (indexPath.section == TABLE_VIEW_SECTION_TRANSPOT ) {
        
        if (self.transpotPickerView == nil) {
            
            self.transpotPickerView = [[PickerView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) contents:@[@"自行车",@"电动车",@"无交通工具"]];
            [self.transpotPickerView showWithSuperView:self.navigationController.view];
            
            self.transpotPickerView.selectedAction = ^(NSInteger index) {
                TextFieldEnableCell *cell = (TextFieldEnableCell *)[weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:TABLE_VIEW_SECTION_TRANSPOT]];
                if (cell) {
                    cell.textField.text = @[@"自行车",@"电动车",@"无交通工具"][index];
                }
                
            };
            
            self.transpotPickerView.dismissAction = ^(NSInteger index) {
                
                weakSelf.transportIndex = index;
                
                [UIView animateWithDuration:0.3f animations:^{
                    [weakSelf.tableView setContentOffset:CGPointMake(0, point.y)];
                    [weakSelf checkInfo];
                    weakSelf.transpotPickerView = nil;
                    
                }];
            };
        }
    }
    else if (indexPath.section == TABLE_VIEW_SECTION_EXPERIENCE) {
        
        if (self.exPickerView == nil) {
            
            self.exPickerView = [[PickerView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) contents:@[@"无",@"有快递经验",@"有外卖经验"]];
            
            [self.exPickerView showWithSuperView:self.navigationController.view];
            
            self.exPickerView.selectedAction = ^(NSInteger index) {
                TextFieldEnableCell *cell = (TextFieldEnableCell *)[weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0    inSection:TABLE_VIEW_SECTION_EXPERIENCE]];
                if (cell) {
                    cell.textField.text = @[@"无",@"有快递经验",@"有外卖经验"][index];
                }
            };
            
            self.exPickerView.dismissAction = ^(NSInteger index) {
                weakSelf.experienceIndex = index;
                
                [UIView animateWithDuration:0.3f animations:^{
                    [weakSelf.tableView setContentOffset:CGPointMake(0, point.y)];
                    [weakSelf checkInfo];
                    weakSelf.exPickerView = nil;
                    
                }];
                
            };
        }
       
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == TABLE_VIEW_SECTION_IDIMAGE) {
  
        return [IdImageCell cellHeight];
    }

    return [TextFieldCell cellHeight];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == TABLE_VIEW_SECTION_INFO) {
        return 0;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 40)];
    
    view.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"期望工作区域";
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel sizeToFit];
    titleLabel.center = CGPointMake(16 + titleLabel.bounds.size.width / 2, view.bounds.size.height - 10 - titleLabel.bounds.size.height / 2);
    [view addSubview:titleLabel];
    
    if (section == TABLE_VIEW_SECTION_IDIMAGE) {
        titleLabel.text = @"身份证照片";
    }
    
    if (section == TABLE_VIEW_SECTION_WORKAREA) {
        titleLabel.text = @"期望工作区域";
    }
    
    if (section == TABLE_VIEW_SECTION_TRANSPOT) {
        titleLabel.text = @"交通工具";
    }
    
    if (section == TABLE_VIEW_SECTION_EXPERIENCE) {
        titleLabel.text = @"配送经验";
    }
    
    return view;
    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType;
    
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        
        if (buttonIndex == 0) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        else if (buttonIndex == 1) {
            sourceType = UIImagePickerControllerSourceTypeCamera;
            
            if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
        }
        
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.sourceType = sourceType;
        self.imagePickerController.delegate = self;
        self.imagePickerController.allowsEditing = YES;
        
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}



#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    IdImageCell *cell = (IdImageCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:TABLE_VIEW_SECTION_IDIMAGE]];
    if (cell.addFrontButton.tag == selectedAddTag) {
        [cell.frontButton setBackgroundImage:image forState:UIControlStateNormal];
        self.frontImage = image;
    }
    else if (cell.addBackButton.tag == selectedAddTag)
    {
        [cell.backButton setBackgroundImage:image forState:UIControlStateNormal];
        self.backImage = image;
    }
    else {
        [self.imageView setImage:image];
        self.portrait = image;
    }
    
    [self checkInfo];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    contentOffsetY = self.tableView.contentOffset.y;
    
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 216, 0)];
    
    TextFieldCell *cell = (TextFieldCell *)textField.superview.superview.superview;
    CGRect rect = [self.tableView rectForRowAtIndexPath:[self.tableView indexPathForCell:cell]];
    if (rect.size.height + rect.origin.y - self.tableView.contentOffset.y  >= WINDOW_HEIGHT - 64 - 253) {
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.tableView setContentOffset:CGPointMake(0, -(WINDOW_HEIGHT - 64 - 253 - rect.size.height - rect.origin.y - 20))];
            
        }];
    }
    
    self.selectedTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.tableView setContentInset:UIEdgeInsetsZero];
        self.tableView.contentOffset = CGPointMake(0, contentOffsetY);
        

    }];

    TextFieldCell *nameCell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TABLE_VIEW_ROW_NAME inSection:TABLE_VIEW_SECTION_INFO]];
    if (nameCell.textField == textField) {
        
        self.name = textField.text;
    }
    
    TextFieldCell *idCell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TABLE_VIEW_ROW_ID inSection:TABLE_VIEW_SECTION_INFO]];
    
    if (idCell.textField == textField) {
        self.identity = textField.text;
    }
    
    TextFieldCell *recommendCell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:TABLE_VIEW_SECTION_RECOMMEND]];
    
    NSString *mobile = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
     if (recommendCell.textField == textField) {
        self.recommendMobile = mobile;
    }
    
    [self checkInfo];

    self.selectedTextField = nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length > 1) {
        return NO;
    }
    
    TextFieldCell *nameCell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TABLE_VIEW_ROW_NAME inSection:TABLE_VIEW_SECTION_INFO]];
    if (nameCell.textField == textField) {
        if (![AppManager isChinese:string]) {
//            return NO;
        }
       
    }

    TextFieldCell *idCell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TABLE_VIEW_ROW_ID inSection:TABLE_VIEW_SECTION_INFO]];
    
    if (idCell.textField == textField) {
        if ([AppManager isChinese:string]) {
            return NO;
        }
    }
    

    TextFieldCell *cell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:TABLE_VIEW_SECTION_RECOMMEND]];

    if (textField == cell.textField) {
        
        if (string.length == 0) {
            if (range.location == 9) {
                NSString *str = [textField.text stringByReplacingCharactersInRange:NSMakeRange(8, 1) withString:@""];
                textField.text = str;
                return YES;
            }
            
            if (range.location == 4) {
                NSString *str = [textField.text stringByReplacingCharactersInRange:NSMakeRange(3, 1) withString:@""];
                textField.text = str;
                return YES;
            }
        }
        else {
            if (range.location >= 13) {
                return NO;
            }
            
            if (textField.text.length == 2) {
                textField.text = [NSString stringWithFormat:@"%@%@%@",textField.text, string,@" "];
                return NO;
            }
            
            if (textField.text.length == 7) {
                textField.text = [NSString stringWithFormat:@"%@%@%@",textField.text, string,@" "];
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    TextFieldCell *cell = (TextFieldCell *)textField.superview.superview.superview;
    
    TextFieldCell *nextCell = nil;
    
    if (cell) {
        NSIndexPath *indexPath  = [self.tableView indexPathForCell:cell];
        if (indexPath.section == TABLE_VIEW_SECTION_INFO) {
            if (indexPath.row == TABLE_VIEW_ROW_NAME) {
                nextCell = (TextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:TABLE_VIEW_ROW_ID inSection:TABLE_VIEW_SECTION_INFO]];
            }
            else if (indexPath.row == TABLE_VIEW_ROW_ID) {
                [textField resignFirstResponder];
                nextCell = nil;
            }
        }
    }
    
    if (nextCell) {
        [textField resignFirstResponder];
        [nextCell.textField becomeFirstResponder];
    }
    
    [self checkInfo];
    
    return YES;
}

@end
