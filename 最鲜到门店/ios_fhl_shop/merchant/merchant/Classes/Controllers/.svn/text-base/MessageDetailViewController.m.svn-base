//
//  MessageDetailViewController.m
//  FHL
//
//  Created by panume on 14-11-7.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) Message *message;

@property (nonatomic, strong) NSString *messageTitle;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation MessageDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.type == MessageTypeSys) {
        self.title = @"系统消息";
        
    }
    else {
        self.title = @"订单消息";
    }
    self.navigationItem.hidesBackButton = YES;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"backWithTitle.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 53, 19);
    
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rithtBarItem ;
    self.view.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    
    if (self.isNoti) {
        [self    getMessageDetailNoti];
    }else{
    
    [self getMessageDetail];
    }
     [self.view addGestureRecognizer:self.swip];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti:) name:@"MessageDetailViewController" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)noti:(NSNotification*)noti{

    
    
    if ([[noti.userInfo valueForKey:@"type"]isEqualToString:@"xitong"]) {
          self.title = @"系统消息";
    }else {
        self.title = @"订单消息";
    }
    self.messageId = [noti.userInfo valueForKey:@"messageId"];
    [self getMessageDetailNoti];
    
}
#pragma mark - Request Method

- (void)getMessageDetail
{
//    [Message messageDetailWithParams:@{@"notifyId" : self.messageId} block:^(Message *message, NSError *error) {
//        if (!error) {
//            self.message = message;
////             self.title = self.message.title;
//            [self.view addSubview:self.scrollView];
//            
//            [self setMessageReaded];
//        }
//        else {
//            [self.view addSubview:self.scrollView];
//
//        }
//    }];
//      self.title = self.message.title;
      [self.view addSubview:self.scrollView];
     [self setMessageReaded];
}
- (void)getMessageDetailNoti
{
        [Message messageDetailWithParams:@{@"notifyId" : self.messageId} block:^(Message *message, NSError *error) {
            if (!error) {
                
                self.message = message;
//                 self.title = self.message.title;
                if (self.scrollView) {
                    [self.scrollView removeFromSuperview];
                    self.scrollView = nil;
                }
                [self.view addSubview:self.scrollView];
    
                [self setMessageReaded];
            }
            else {
                [self.view addSubview:self.scrollView];
    
            }
        }];

    [self setMessageReaded];
}
- (void)setMessageReaded
{
    [self.message readMessageWithBlock:^(NSError *error) {
        if (!error) {
            [AppManager setUserBoolValue:YES key:@"NeedRefreshMes"];

        }
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

//- (void)setMessageTitle:(NSString *)messageTitle
//{
//    _messageTitle = messageTitle;
//    self.titleLabel.text = _messageTitle;
//}
//
//- (void)setTime:(NSTimeInterval)time
//{
//    _time = time;
//    self.timeLabel.text = [AppManager dateStringWithFormatter:@"YYYY年MM月DD日 hh:MM" timeInterval:_time];
//
//}
//
//- (void)setContent:(NSString *)content
//{
//    _content = content;
//    CGSize size  = [_content sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(WINDOW_WIDTH - 32, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    self.contentLabel.frame = CGRectMake(16, self.contentLabel.frame.origin.y, size.width, size.height + 5);
//    
//    [self.scrollView setContentSize:CGSizeMake(WINDOW_WIDTH, CGRectGetMaxY(self.contentLabel.frame))];
//}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scorllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)];
   
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = @"最鲜到新鲜出炉，小伙伴都来看啊小伙伴都来看啊小伙伴";
        self.titleLabel.numberOfLines = 0;
               self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.backgroundColor = [UIColor clearColor];
     
       self.titleLabel.text = self.message.title;
        
       [CommonUtils  heightForText:self.message.title withFontSize:20 withWide:WINDOW_WIDTH-20 withBlocl:^(CGFloat height) {
           self.titleLabel.bounds = CGRectMake(0, 0, WINDOW_WIDTH-20, height);
       }];
//       self.titleLabel
        [self.titleLabel sizeToFit];
 
        self.titleLabel.center = CGPointMake(15+self.titleLabel.bounds.size.width/2, 15 + self.titleLabel.bounds.size.height / 2);
        [scorllView addSubview:self.titleLabel];
        
      
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.text = @"2014年11月09日 16:30 2014年11月09日 ";
        self.timeLabel.font = [UIFont systemFontOfSize:13];
//        self.timeLabel.textColor = [UIColor colorWithHex:0x3e3e3e];
          self.timeLabel.textColor = [UIColor grayColor];
//        self.timeLabel.backgroundColor = [UIColor clearColor];
        [self.timeLabel sizeToFit];
        self.timeLabel.center = CGPointMake(16 + self.timeLabel.bounds.size.width / 2, CGRectGetMaxY(self.titleLabel.frame) +1 + self.titleLabel.bounds.size.height / 2);
        [scorllView addSubview:self.timeLabel];
      
        self.timeLabel.text = [AppManager dateStringWithFormatter:@"YYYY年MM月dd日 HH:mm" timeInterval:self.message.time];
        
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH - 32, 0.5)];
//        lineLabel.backgroundColor = [UIColor colorWithHex:0xd7d7d7];
        lineLabel.backgroundColor = [UIColor clearColor ];
        lineLabel.center = CGPointMake(WINDOW_WIDTH / 2, CGRectGetMaxY(self.timeLabel.frame) + 5);
        [scorllView addSubview:lineLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        self.contentLabel.numberOfLines = 0;
//        CGSize size  = [self.message.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WINDOW_WIDTH - 32, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        CGRect size  = [self.message.content boundingRectWithSize:CGSizeMake(WINDOW_WIDTH - 32, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.contentLabel.font} context:nil];

        self.contentLabel.frame = CGRectMake(16, CGRectGetMaxY(lineLabel.frame) + 8, size.size.width, size.size.height + 5);
        [scorllView addSubview:self.contentLabel];
        self.contentLabel.text = self.message.content;
        
        [scorllView setContentSize:CGSizeMake(WINDOW_WIDTH, CGRectGetMaxY(self.contentLabel.frame)+100)];
        
        _scrollView = scorllView;
        return _scrollView;
    }
    return _scrollView;
}

@end
