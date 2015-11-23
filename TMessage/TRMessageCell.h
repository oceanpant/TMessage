//
//  TRMessageCell.h
//  TMessage
//
//  Created by tarena on 15/7/28.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRMessage.h"

@interface TRMessageCell : UITableViewCell

//公开一个属性，存储要显示的message对象
@property(nonatomic,strong)TRMessage *message;

@end






