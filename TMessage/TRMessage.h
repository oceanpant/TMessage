//
//  TRMessage.h
//  TMessage
//
//  Created by tarena on 15/7/28.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
作用：存储消息
*/
@interface TRMessage : NSObject

@property(nonatomic,strong)NSString *content;
@property(nonatomic)BOOL fromMe;

+(NSArray *)demoData;

@end







