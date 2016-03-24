//
//  MessageDetailViewController.h
//  FHL
//
//  Created by panume on 14-11-7.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "BaseViewController.h"
#import "Message.h"

typedef NS_ENUM(NSUInteger, MessageType) {
    MessageTypeSys,
    MessageTypeOrder
};

@interface MessageDetailViewController : BaseViewController

@property (nonatomic, assign) MessageType type;
@property (nonatomic, strong) NSString *messageId;
@property (nonatomic,strong) Message  *message;
@property (assign, nonatomic) BOOL isNoti;
@end
