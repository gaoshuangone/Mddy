//
//  FeedbackViewController.m
//  FHL
//
//  Created by panume on 14-10-29.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "FeedbackViewController.h"

#define INPUT_LIMIT  150

@interface FeedbackViewController () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSString *text;

@end

@implementation FeedbackViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"建议与反馈";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHex:0xfc6605]} forState:UIControlStateNormal];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendFeedback:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHex:0xfc6605]} forState:UIControlStateNormal];

    self.view.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    
    self.textView = [[UITextView alloc] init];
    self.textView.text = @"阿斯顿空间按时间段【阿萨德会发哦似乎都佛啊奥斯丁好奥；到；时间地方；奥斯剪短发；噢爱就是的；；奥斯丁";
    self.textView.frame = CGRectMake(10 , 20, WINDOW_WIDTH - 20, 200);
    self.textView.delegate = self;
    self.textView.text = @"";
    self.textView.font =UIFont(15);
    self.textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textView];
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.text = @"999";
    self.countLabel.font = UIFont(15);
    self.countLabel.backgroundColor = [UIColor clearColor];
    self.countLabel.textAlignment = NSTextAlignmentRight;
    self.countLabel.textColor = [UIColor lightGrayColor];
    [self.countLabel sizeToFit];
    self.countLabel.center = CGPointMake(WINDOW_WIDTH - 20 - self.countLabel.bounds.size.width / 2, CGRectGetMaxY(self.textView.frame) + 10 + self.countLabel.bounds.size.height / 2);
    self.countLabel.text = [NSString stringWithFormat:@"%d", INPUT_LIMIT];

    [self.view addSubview:self.countLabel];
         self.swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipLeft)];
    [self.swip setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:self.swip];

}
-(void)swipLeft{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (IBAction)dismiss:(id)sender
{
    [self.textView endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendFeedback:(id)sender
{
    [self.textView endEditing:YES];
    
    if (self.textView.text.length == 0) {
        
//    [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
    [MBProgressHUD hudShowWithStatus:self :@"内容不能为空"];
    }else{
    
//    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
              [SelfUser hudShowWithViewcontroller:self];
    

    NSDictionary *params = @{@"feedbackContent":self.textView.text,@"cmdCode":g_feedBackCmd};
    
    
    [[API shareAPI]POST:@"feedBackJsonPhone.htm" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        FLDDLogDebug(@"success");
//           [SVProgressHUD dismiss ];
      [SelfUser hudHideWithViewcontroller:self];
        [MBProgressHUD hudShowWithStatus:self :@"提交成功！"];
//        [MBProgressHUD hudHideWithViewcontroller:self];
 [self performSelector:@selector(backkk) withObject:self afterDelay:1.2];
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        FLDDLogInfo(@"failure");
//           [SVProgressHUD dismiss ];
      [SelfUser hudHideWithViewcontroller:self];
//
//        [SVProgressHUD showErrorWithStatus:@"发送失败"];
        [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
        
    }];
    }
 
}
-(void)backkk{
     [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)setText:(NSString *)text
{
    _text = text;
    self.countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)(INPUT_LIMIT - _text.length)];
}

#pragma mark -UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSString *string = textView.text;
    
//    if (text.length+string.length >= INPUT_LIMIT+1 ) {
//        return NO;
//    }
    if (string.length >= INPUT_LIMIT && text.length >= 1) {
        return NO;
    }
    
    
    if (string.length + text.length == INPUT_LIMIT + 1 && text.length > 0) {
        return NO;
    }
    else {
        self.text = textView.text;
    }
    return YES;
//    
//    if (text.length == 0) {
//        return YES;
//    }
//    if(textView.text.length + [text length] > 150)
//    {
//        return NO;
//    }
//    else {
//        self.text = textView.text;
//    }
//    return YES;
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    NSString *string = textView.text;
    if (textView.text.length <= INPUT_LIMIT) {
        self.text = textView.text;
    }
    else {
        
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (string.length > INPUT_LIMIT) {
//                textView.text = [string substringToIndex:string.length - 1];
                  textView.text = [string substringToIndex:INPUT_LIMIT];
                self.text = textView.text;
            }
        }
//        self.textView.text = [textView.text substringToIndex:INPUT_LIMIT];
    }
}
@end
