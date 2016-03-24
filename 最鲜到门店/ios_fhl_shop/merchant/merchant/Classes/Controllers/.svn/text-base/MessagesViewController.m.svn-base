//
//  MessagesViewController.m
//  FHL
//
//  Created by panume on 14-9-22.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "MessagesViewController.h"
#import "MessageCell.h"
#import "WebViewController.h"
#import "Message.h"
#import "MessageDetailViewController.h"
#import "BlankView.h"
#define ROWS 15
@interface MessagesViewController ()

@property (nonatomic, strong) UISegmentedControl *segmented;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) NSMutableArray *sysMessages;
@property (nonatomic, strong) NSMutableArray *orderMessages;
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, assign) NSInteger sysCount;
@property (nonatomic, assign) NSInteger orderCount;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) BlankView *blankView;
@end

@implementation MessagesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"消息";
     [self addTableViewWithStyle:UITableViewStylePlain];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.headView];
    CGFloat height = self.tableView.frame.origin.y;
    
    self.tableView.frame = CGRectMake(0, height + 55, WINDOW_WIDTH, self.tableView.bounds.size.height );
    self.page = 1;
    [self setupRefresh];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
     [self.view addGestureRecognizer:self.swip];
    
}

- (void)didReceiveMemoryWarnin

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BOOL refresh = [AppManager boolValueForKey:@"NeedRefreshMes"];
    
    if (self.messages.count == 0 || refresh) {
        if (refresh) {
//            self.messages = [NSMutableArray array];
//            self.segmented.selectedSegmentIndex = 0;
        }
//        [self headerRereshing];
        [AppManager setUserBoolValue:NO key:@"NeedRefreshMes"];

    }
      [self headerRereshing];
}

- (void)headerRereshing
{
    self.page = 1;
    [self getMessages];
    [self getSysMessageCount];
    [self getOrderMessageCount];
}

- (void)footerRereshing
{
    self.page ++;
    [self getMessages];
}

- (UIView *)headView
{
    if (!_headView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 55)];
        view.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        line.center = CGPointMake(WINDOW_WIDTH / 2, 55 - 0.25);
        [view addSubview:line];
        [view addSubview:self.segmented];
        _headView = view;
        return _headView;
    }
    return _headView;
}
#pragma mark - Private

- (UIView *)blankView
{
    if (!_blankView) {
        
        
        BlankView *blankView = [[BlankView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, self.tableView.bounds.size.height) image:nil content:@"暂无相关消息" showButton:NO];
        _blankView = blankView;
        return _blankView;
    }
    return _blankView;
}


- (UISegmentedControl *)segmented
{
    if (!_segmented) {
        _segmented = [[UISegmentedControl alloc] initWithItems:@[@"系统消息",@"订单消息"]];
        _segmented.frame = CGRectMake(15, 10, WINDOW_WIDTH - 30, 35);
        _segmented.tintColor = [UIColor colorWithHex:0xfc6605];
//        _segmented.segmentedControlStyle = UISegmentedControlNoSegment;
        [_segmented addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        _segmented.selectedSegmentIndex = 0;
        return _segmented;
    }
    return _segmented;
}

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender
{
    self.page = 1;

    [self getMessages];
    
    [self.tableView reloadData];
}


#pragma mark - Request Method

- (void)getMessages
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionary];
    
    if (self.segmented.selectedSegmentIndex == 0) {
        [muParams setObject:@(1) forKey:@"type"];
    }
    else {
        [muParams setObject:@(2) forKey:@"type"];
    }
    
    [muParams setObject:@(self.page) forKey:@"page"];
    [muParams setObject:@(ROWS) forKey:@"rows"];
        
    [Message messagesWithParams:muParams block:^(NSArray *messages, NSInteger total, NSInteger page, NSError *error,NSInteger count1,NSInteger count2) {
        if (!error) {
//            [SVProgressHUD dismiss];
            [MBProgressHUD hudHideWithViewcontroller:self];
            
            if (count1 == 0) {
                [self.segmented setTitle:@"系统消息" forSegmentAtIndex:0];
                
            }
            else {
                [self.segmented setTitle:[NSString stringWithFormat:@"系统消息(%ld)", (long)count1] forSegmentAtIndex:0];
            }
            
            if (count2 == 0) {
                [self.segmented setTitle:@"订单消息" forSegmentAtIndex:1];
            }
            else {
                [self.segmented setTitle:[NSString stringWithFormat:@"订单消息(%ld)",(long)count2] forSegmentAtIndex:1];
            }
      
      
        
            if (total > page * ROWS) {
                self.tableView.footerHidden = NO;
            }
            else {
                self.tableView.footerHidden = YES;
            }
            
            if (_segmented.selectedSegmentIndex == 0) {
                
                if (self.tableView.footerRefreshing) {
                    [_sysMessages addObjectsFromArray:messages];
                }
                else {
                    _sysMessages = [NSMutableArray arrayWithArray:messages];
                }
                _messages = _sysMessages;
            }
            else {
                
                if (self.tableView.footerRefreshing) {
                    [_orderMessages addObjectsFromArray:messages];
                }
                else {
                    _orderMessages = [NSMutableArray arrayWithArray:messages];
                }
                _messages = _orderMessages;
            }
            
            [self.tableView reloadData];
        }
        else {
//            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
        
        if (self.messages.count == 0) {
            self.tableView.tableFooterView = self.blankView;
            //g_displayMessageIcon = NO;
        }
        else {
            self.tableView.tableFooterView = nil;
            //g_displayMessageIcon = YES;
        }
        
        if (self.tableView.isHeaderRefreshing) {
            [self.tableView headerEndRefreshing];
        }
        
        if (self.tableView.isFooterRefreshing) {
            [self.tableView footerEndRefreshing];
        }
    }];
}

- (void)getSysMessageCount
{
//    NSMutableDictionary *muParams = [NSMutableDictionary dictionary];
//    
//    [muParams setObject:@(1) forKey:@"type"];
//    
//    [Message messagesCountWithParams:muParams block:^(NSInteger count, NSError *error) {
//        if (!error) {
//            _sysCount = count;
//            
//            if (count == 0) {
//                [self.segmented setTitle:@"系统消息" forSegmentAtIndex:0];
//                
//            }
//            else {
//                [self.segmented setTitle:[NSString stringWithFormat:@"系统消息(%ld)", (long)count] forSegmentAtIndex:0];
//            }
//        }
//    }];
}

- (void)getOrderMessageCount
{
//    NSMutableDictionary *muParams = [NSMutableDictionary dictionary];
//    
//    [muParams setObject:@(2) forKey:@"type"];
//    [Message messagesCountWithParams:muParams block:^(NSInteger count, NSError *error) {
//        if (!error) {
//            _orderCount = count;
//            if (count == 0) {
//                [self.segmented setTitle:@"订单消息" forSegmentAtIndex:1];
//            }
//            else {
//                [self.segmented setTitle:[NSString stringWithFormat:@"订单消息(%ld)",(long) _orderCount] forSegmentAtIndex:1];
//            }
//        }
//        
//    }];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MessageCell";
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Message *message = [[Message alloc] init];
    message = self.messages[indexPath.row];
    cell.title = message.title;
    cell.time = message.time;
    cell.type = message.state;
    cell.content = message.content;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.messages.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    MessageDetailViewController *messageDetailVC = [[MessageDetailViewController alloc] init];
    if (self.segmented.selectedSegmentIndex == 0) {
//        messageDetailVC.title = @"系统消息";
           messageDetailVC.type = MessageTypeSys;
    }
    else {
//        messageDetailVC.title = @"订单消息";
        messageDetailVC.type = MessageTypeOrder;
    }
    Message *message = self.messages[indexPath.row];
    messageDetailVC.messageId = message.id;
//    messageDetailVC.isNoti = YES;
 
    messageDetailVC.message = self.messages[indexPath.row];
    [self.navigationController pushViewController:messageDetailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MessageCell cellHeight];
}

@end
