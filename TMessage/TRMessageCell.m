//
//  TRMessageCell.m
//  TMessage
//
//  Created by tarena on 15/7/28.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "TRMessageCell.h"

@interface TRMessageCell ()

//声明为了显示数据而存在的两个控件
@property(nonatomic,strong)UIImageView *popImageView;
@property(nonatomic,strong)UILabel *popLabel;

@end

@implementation TRMessageCell

#define CELL_MARGIN_TB          4.0  //气泡上下外边距
#define CELL_MARGIN_LR          10.0 //气泡左右外边距

#define CELL_CORNOR             18.0 //圆角的半径
#define CELL_TAIL_WIDTH         16.0 //气泡尾巴的宽度

#define MAX_WIDTH_OF_TEXT       200.0 //最大文本宽度
#define CELL_PADDING            8.0   //气泡的上下左右四个内边距

//重写message属性的set方法
//这样，只要给message属性赋值了
//就可以根据传入的消息的内容来计算气泡和标签的frame
- (void)setMessage:(TRMessage *)message{
    _message = message;
    // 只有先把文本信息给label，label才能根据
    // 内容的多少，算出合适的高宽
    self.popLabel.text = message.content;
    
    if (message.fromMe) {//蓝色气泡，在右边
        self.popLabel.textColor = [UIColor whiteColor];
        self.popImageView.image = [[UIImage imageNamed:@"message_i"] resizableImageWithCapInsets:UIEdgeInsetsMake(CELL_CORNOR, CELL_CORNOR, CELL_CORNOR, CELL_CORNOR+CELL_TAIL_WIDTH)];
        
        //获取label在不超过200的宽度时，需要多大的尺寸才能装下所有内容
        CGRect rectOfText = [self.popLabel textRectForBounds:CGRectMake(0, 0, MAX_WIDTH_OF_TEXT, 999) limitedToNumberOfLines:0];
        
        //第一个目标：计算label的frame
        CGRect frameOfLabel = CGRectZero;
        frameOfLabel.size = rectOfText.size;
        frameOfLabel.origin.x = self.bounds.size.width-CELL_MARGIN_LR-CELL_TAIL_WIDTH-CELL_PADDING-rectOfText.size.width;
        frameOfLabel.origin.y = CELL_MARGIN_TB+CELL_PADDING;
        self.popLabel.frame = frameOfLabel;
        
        //第二个目标：计算imageView的frame
        CGRect frameOfImageView = frameOfLabel;
        frameOfImageView.origin.x -=CELL_PADDING;
        frameOfImageView.origin.y = CELL_MARGIN_TB;
        frameOfImageView.size.width +=2*CELL_PADDING+CELL_TAIL_WIDTH;
        frameOfImageView.size.height +=2*CELL_PADDING;
        self.popImageView.frame = frameOfImageView;
        
        //第三个目标：cell根据图片的大小，修改cell此时的尺寸
        CGRect bounds = self.bounds;
        bounds.size.height = frameOfImageView.size.height+2*CELL_MARGIN_TB;
        self.bounds = bounds;
        
    }else{//灰色气泡，在左边
        self.popLabel.textColor = [UIColor darkGrayColor];
        self.popImageView.image = [[UIImage imageNamed:@"message_other"] resizableImageWithCapInsets:UIEdgeInsetsMake(CELL_CORNOR, CELL_CORNOR+CELL_TAIL_WIDTH, CELL_CORNOR, CELL_CORNOR)];
        
        //获取label在不超过200的宽度时，需要多大的尺寸才能装下所有内容
        CGRect rectOfText = [self.popLabel textRectForBounds:CGRectMake(0, 0, MAX_WIDTH_OF_TEXT, 999) limitedToNumberOfLines:0];
        
        //第一个目标：计算label的frame
        CGRect frameOfLabel = CGRectZero;
        frameOfLabel.size = rectOfText.size;
        frameOfLabel.origin.x = CELL_MARGIN_LR + CELL_TAIL_WIDTH + CELL_PADDING;
        frameOfLabel.origin.y = CELL_MARGIN_TB+CELL_PADDING;
        self.popLabel.frame = frameOfLabel;
        
        //第二个目标：计算imageView的frame
        CGRect frameOfImageView = frameOfLabel;
        frameOfImageView.origin.x =CELL_MARGIN_LR;
        frameOfImageView.origin.y = CELL_MARGIN_TB;
        frameOfImageView.size.width +=2*CELL_PADDING+CELL_TAIL_WIDTH;
        frameOfImageView.size.height +=2*CELL_PADDING;
        self.popImageView.frame = frameOfImageView;
        
        //第三个目标：cell根据图片的大小，修改cell此时的尺寸
        CGRect bounds = self.bounds;
        bounds.size.height = frameOfImageView.size.height+2*CELL_MARGIN_TB;
        self.bounds = bounds;
    }
    //添加两个控件到cell的contentView中
    [self.contentView addSubview:self.popImageView];
    [self.contentView addSubview:self.popLabel];
}






- (UIImageView *)popImageView{
    if (!_popImageView) {
        _popImageView = [[UIImageView alloc]init];
    }
    return _popImageView;
}
- (UILabel *)popLabel{
    if (!_popLabel) {
        _popLabel = [[UILabel alloc]init];
        //设定标签的行数无上限
        _popLabel.numberOfLines = 0;
    }
    return _popLabel;
}

@end
