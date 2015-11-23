//
//  TRMessage.m
//  TMessage
//
//  Created by tarena on 15/7/28.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "TRMessage.h"

@implementation TRMessage

+(NSArray *)demoData{
    TRMessage *m1 = [[TRMessage alloc]init];
    m1.content = @"hi,你好";
    m1.fromMe = YES;
    
    TRMessage *m2 = [[TRMessage alloc]init];
    m2.content = @"怎么了";
    m2.fromMe = NO;
    
    TRMessage *m3 = [[TRMessage alloc]init];
    m3.content = @"这是一段测试文本主要用于测试是否能够换行";
    m3.fromMe = YES;
    
    TRMessage *m4 = [[TRMessage alloc]init];
    m4.content = @"再来继续说点什么呢？想换行那就再写一点";
    m4.fromMe = NO;
    
    TRMessage *m5 = [[TRMessage alloc]init];
    m5.content = @"今天天气不怎么好听说还是有雨啊";
    m5.fromMe = YES;
    
    TRMessage *m6 = [[TRMessage alloc]init];
    m6.content = @"实在是太热了，太闷了，太潮湿了，不开空调太热了，太闷了，太潮湿了，不开太热了，太闷了，太潮湿了，不开睡不着啊";
    m6.fromMe = NO;
    
    TRMessage *m7 = [[TRMessage alloc]init];
    m7.content = @"好听说还是有雨啊";
    m7.fromMe = YES;
    
    TRMessage *m8 = [[TRMessage alloc]init];
    m8.content = @"今天天气不怎么好听说还是有雨啊";
    m8.fromMe = NO;
    
    return @[m1,m2,m3,m4,m5,m6,m7,m8];
}


@end










