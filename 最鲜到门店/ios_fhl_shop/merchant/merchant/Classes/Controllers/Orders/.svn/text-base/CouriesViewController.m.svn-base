//
//  CouriesViewController.m
//  merchant
//
//  Created by gs on 15/6/11.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "CouriesViewController.h"
#import "CouriesTableViewCell.h"
#import "CouriesRowTableViewCell.h"
@interface CouriesViewController ()
@property (strong, nonatomic)NSDictionary* dict;
@end

@implementation CouriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"配送员详细";
  self.view.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}
-(void)getData{
    __weak __typeof(self)weakSelf = self;
    [SelfUser mddyRequestWithMethodName:@"getCourierDateilJsonPhone.htm" withParams:@{@"cmdCode":@"12121",@"courierTel":self.strTel} withBlock:^(id responseObject, NSError *error) {
        NSLog(@"%@",responseObject);
        if (!error) {
            @try {
                weakSelf.dict = [NSDictionary dictionaryWithDictionary:responseObject];
                [self addTableViewWithStyle:UITableViewStylePlain];
                self.tableView.frame =CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT  - 64);
                [weakSelf.tableView reloadData];
                   NSLog(@"%@",self.dict);
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
            
        }else{
        }
        
        
    }];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if ([[self.dict valueForKey:@"courierRankIconUrl"] toString].length>=1) {
        return 4;
    }
    return 3;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell;
    if (indexPath.row==0) {
        
        static NSString *cellIdentifier = @"cour";
        CouriesTableViewCell *cellQiangDan = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cellQiangDan) {
            UINib* nib =[UINib nibWithNibName:@"CouriesTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
            cellQiangDan = (CouriesTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        }
        cellQiangDan.labelName.text = [self.dict valueForKey:@"courierName"];
        [cellQiangDan setImageWithTel:[self.dict valueForKey:@"headPortraitUrl"]];
      
        cell = cellQiangDan;
    }else {
        NSInteger countRow=0;
        if ([[self.dict valueForKey:@"courierRankIconUrl"] toString].length>=1) {
            countRow =0;
        }else{
            countRow = 1;
        }
        if(indexPath.row==1-countRow ){
            static NSString *cellIdentifier1 = @"courr1";
            CouriesRowTableViewCell *cellQiangDan1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            
            if (!cellQiangDan1) {
                UINib* nib =[UINib nibWithNibName:@"CouriesRowTableViewCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier1];
                cellQiangDan1 = (CouriesRowTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            }
          
            cellQiangDan1.labelTitle.text = @"等级";
            cellQiangDan1.labelDetail.text = [self.dict valueForKey:@"courierRank"];
//            cellQiangDan1.labelDetail.text =@"re哈哈哈哈哈哈哈哈哈哈";
           
            [cellQiangDan1 changeImageViewFrameWithImageUrl:[self.dict valueForKey:@"courierRankIconUrl"]];
             cellQiangDan1.imageViewCC.hidden = NO;
            cell = cellQiangDan1;
        }
        if(indexPath.row==2 -countRow ){
            static NSString *cellIdentifier1 = @"courr2";
            CouriesRowTableViewCell *cellQiangDan1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            
            if (!cellQiangDan1) {
                UINib* nib =[UINib nibWithNibName:@"CouriesRowTableViewCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier1];
                cellQiangDan1 = (CouriesRowTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            }
              cellQiangDan1.labelTitle.text = @"电话";
             cellQiangDan1.labelDetail.text = [self.dict valueForKey:@"courierTel"];
            
            cell = cellQiangDan1;
        }
        
        if(indexPath.row==3 -countRow ){
            static NSString *cellIdentifier1 = @"courr3";
            CouriesRowTableViewCell *cellQiangDan1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            
            if (!cellQiangDan1) {
                UINib* nib =[UINib nibWithNibName:@"CouriesRowTableViewCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier1];
                cellQiangDan1 = (CouriesRowTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            }
            cellQiangDan1.labelTitle.text = @"累计配送单数";
            cellQiangDan1.labelDetail.text = [NSString stringWithFormat:@"%ld单",(long)[[self.dict valueForKey:@"courierPackgeCount"]toInt ]];
            cellQiangDan1.viewLine.hidden = NO;
            cell = cellQiangDan1;
        }
        

        
        
        
    }
    cell.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 190;
    }else{
        return 72;
    }
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

@end
