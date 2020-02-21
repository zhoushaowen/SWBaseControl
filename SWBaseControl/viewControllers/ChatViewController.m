//
//  ChatViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/21.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "ChatViewController.h"
#import <SWGrowingTextView.h>

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,SWGrowingTextViewDelegate>
{
    NSArray *_dataSource;
}
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong) SWGrowingTextView *growingTextView;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.growingTextView = [[SWGrowingTextView alloc] init];
    self.growingTextView.delegate = self;
    [self.view addSubview:self.growingTextView];
    self.growingTextView.frame = CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.growingTextView addKeyboardObserver];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.growingTextView removeKeyboardObserver];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Cell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
        cell.textLabel.numberOfLines = 0;
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChatViewController *vc = [ChatViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)changeTableViewFrame {
    CGRect rect = _tableView.frame;
    rect.size.height = _growingTextView.frame.origin.y;
    _tableView.frame = rect;
}

#pragma mark - SWGrowingTextViewDelegate
- (void)growingTextView:(SWGrowingTextView *)growingTextView textDidChangeGrowingAnimations:(CGRect)frame {
    [self changeTableViewFrame];
    if([_tableView numberOfRowsInSection:0] > 0){
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_tableView numberOfRowsInSection:0] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

- (void)growingTextViewKeyboardWillShowAnimations:(SWGrowingTextView *)growingTextView {
    [self changeTableViewFrame];
    if([_tableView numberOfRowsInSection:0] > 0){
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_tableView numberOfRowsInSection:0] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

- (void)growingTextViewKeyboardWillHideAnimations:(SWGrowingTextView *)growingTextView {
    [self changeTableViewFrame];
}

- (void)growingTextView:(SWGrowingTextView *)growingTextView didClickSendButtonWithText:(NSString *)sendText {
    if(!_dataSource){
        _dataSource = @[];
    }
    NSMutableArray *mutableArray = [_dataSource mutableCopy];
    [mutableArray addObject:sendText];
    _dataSource = [mutableArray copy];
    [_tableView reloadData];
    if([_tableView numberOfRowsInSection:0] > 0){
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_tableView numberOfRowsInSection:0] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}







@end












