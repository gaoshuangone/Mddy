//
//  SendOrderViewController.m
//  merchant
//
//  Created by panume on 14-11-1.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "SendOrderViewController.h"
#import "SoonSendOrderViewController.h"
#import "OrderDetailViewController.h"
#import "OrderErrorDetailkViewController.h"
@interface SendOrderViewController ()

@end

@implementation SendOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)buttonPressed:(id)sender {
    UIButton* button = sender;
    
    if (button.tag == 1 || button.tag ==2 || button.tag == 3) {
        OrderDetailViewController* orderDetail = [[OrderDetailViewController alloc]initWithNibName:nil bundle:nil];
        if (button.tag == 1) {
            orderDetail.order_status = ORDER_STATUS_WAIT_QIANGDAN;
        }else if (button.tag == 2){
            orderDetail.order_status = ORDER_STATUS_WAIT_LANSHOU;
        }else{
            orderDetail.order_status = ORDER_STATUS_WAIT_QIANSHOU;
            
        }
        [self.navigationController pushViewController:orderDetail animated:YES];
        
    }else if(button.tag == 4 || button.tag == 5){
        OrderErrorDetailkViewController* errorDetail = [[OrderErrorDetailkViewController alloc ]initWithNibName:nil bundle:nil];
        if (button.tag == 4) {
            errorDetail.orderStatus = ORDER_ERROR_STATUS_WAIT_CANCEL;
            
        }else {
            errorDetail.orderStatus = ORDER_ERROR_STATUS_WAIT_JUSHOU;
        }
        [self.navigationController pushViewController:errorDetail animated:YES];
        
    }else{
        
        SoonSendOrderViewController* soonSend = [[SoonSendOrderViewController alloc]initWithNibName:nil bundle:nil   ];
        [self.navigationController pushViewController:soonSend animated:YES];
        
    }
}
@end
