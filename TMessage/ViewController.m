//
//  ViewController.m
//  TMessage
//
//  Created by tarena on 15/7/28.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "ViewController.h"
#import "TRMessage.h"
#import "TRMessageCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

//存储全部message
@property(nonatomic,strong)NSMutableArray *allMessages;
//为了解决单元格高度不同这个问题，需要另外准备一个备用的cell，每次回答高度是多少这个问题时，可以用这个备用的cell临时生成一下高度，然后作为答案返回
@property(nonatomic,strong)TRMessageCell *prototypeCell;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;

@property (weak, nonatomic) IBOutlet UIButton *stateButton;



@end

@implementation ViewController

- (NSMutableArray *)allMessages{
    if (!_allMessages) {
        _allMessages = [[TRMessage demoData] mutableCopy];
    }
    return _allMessages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册单元格
    [self.tableView registerClass:[TRMessageCell class] forCellReuseIdentifier:@"MyCell"];
    //将备用单元格实例化
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"MyCell"];
}
//注册通知
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
}

//取消注册的键盘通知
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
//检测手指的拖拽操作 只要拖拽了 就隐藏键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
//键盘弹起时触发
-(void)openKeyboard:(NSNotification *)notification{
    //读取键盘弹起后的frame
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //读取键盘弹起时动画的时长
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //读取键盘弹起时动画的选项
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    //修改视图底部的约束中的constant为键盘的高度
    self.bottomLayoutConstraint.constant = keyboardFrame.size.height;
    //在动画中，设置重新布局
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        [self.view layoutIfNeeded];
        [self scrollToTableViewBottom];
        
    } completion:nil];
    
    
}
//键盘关闭时触发
-(void)closeKeyboard:(NSNotification *)notification{
    //读取键盘弹起时动画的时长
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //读取键盘弹起时动画的选项
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    //修改视图底部的约束中的constant为键盘的高度
    self.bottomLayoutConstraint.constant = 0;
    //在动画中，设置重新布局
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        [self.view layoutIfNeeded];
        [self scrollToTableViewBottom];
        
    } completion:nil];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allMessages.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TRMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    
    TRMessage *message = self.allMessages[indexPath.row];
    cell.message = message;
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //先获取正在询问的行 对应的数据
    TRMessage *message = self.allMessages[indexPath.row];
    //将这个待显示的数据传给那个备用的单元格
    //这样，这个备用的单元格就根据要显示的数据
    //生成了一个有效的高度，返回这个高度即可
    self.prototypeCell.message = message;
    return self.prototypeCell.bounds.size.height;
}

- (IBAction)sendMessage:(UITextField *)sender {
    NSString *newContent = sender.text;
    if (newContent.length == 0) {
        return;
    }
    TRMessage *newMessage = [[TRMessage alloc]init];
    newMessage.content = newContent;
    newMessage.fromMe = self.stateButton.selected;
    
    // 修改数据模型
    [self.allMessages addObject:newMessage];
    
    //清空输入
    sender.text = @"";
    
    // 更新界面
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.allMessages.count-1 inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
    
}

- (IBAction)changeMessageState:(UIButton *)sender {
    sender.selected = !sender.selected;
}

//实现表视图滚动到最后一行
-(void)scrollToTableViewBottom{
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.allMessages.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

//界面显示后，表格立即滚动到最后一行，查看最后的数据
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self scrollToTableViewBottom];
}



@end
