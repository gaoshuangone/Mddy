//
//  PickerView.m
//  FHL
//
//  Created by panume on 14-9-26.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "PickerView.h"

#define PICKER_HIGH       162

@interface PickerView ()

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) UIView *superView;
@property (nonatomic, assign) NSInteger index;

@end

@implementation PickerView

- (instancetype)initWithFrame:(CGRect)frame contents:(NSArray *)contents
{
    FLDDLogDebug(@"frame:%@", NSStringFromCGRect(frame));
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:0x000 alpha:0.0];
        
        [self addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        _options = contents;
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, WINDOW_HEIGHT - PICKER_HIGH, WINDOW_WIDTH, 150)];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
        self.pickerView.showsSelectionIndicator = YES;
        
        [self addSubview:self.pickerView];
        FLDDLogDebug(@"pickerView:%@", NSStringFromCGRect(self.pickerView.frame));
        FLDDLogDebug(@"self:%@", NSStringFromCGRect(self.frame));

    }
    return self;
}

#pragma mark -
#pragma mark - Private

- (void)showWithSuperView:(UIView *)superView
{
    _superView = superView;

    if (self.superview) {
        [self removeFromSuperview];
    }
    else {
        
      
        self.frame = CGRectMake(0, WINDOW_HEIGHT, self.bounds.size.width, self.bounds.size.height);
        [_superView addSubview:self];


        [UIView animateWithDuration:0.3 animations:^{

            self.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);

        } completion:^(BOOL finished) {
            self.backgroundColor = [UIColor colorWithHex:0x000 alpha:0.5];

            if (self.selectedAction) {
                self.selectedAction(0);
            }
            
            self.index = 0;

        }];
    }
}

- (IBAction)dismiss:(id)sender
{
    self.backgroundColor = [UIColor colorWithHex:0x000 alpha:0.0];

    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 1000, self.bounds.size.width, self.bounds.size.height);

    } completion:^(BOOL finished) {
        if (self.dismissAction) {
            self.dismissAction(self.index);
        }
        [self removeFromSuperview];
       

    }];
}

#pragma mark -
#pragma mark - UIPickerViewDataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.options.count;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


#pragma mark -
#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    FLDDLogDebug(@"%@", self.options[row]);
    
    if (self.selectedAction) {
        self.selectedAction(row);
    }
    
    self.index = row;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.options[row];
}

@end
