//
//  PopoverViewContentView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/27.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWPopoverContentTableView.h"
#import "SWPopoverContentTableViewCell.h"
#import "SWPopoverView.h"

@interface SWPopoverContentTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SWPopoverContentTableView
{
    UITableView *_tableView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self prepare];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        [self prepare];
    }
    return self;
}

- (void)prepare {
    self.rowHeight = 44.0f;
    self.layer.cornerRadius = 2.0f;
    self.clipsToBounds = YES;
    _tableView = [[UITableView alloc] initWithFrame:self.bounds];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    if([self registerNibForTableView]){
        [_tableView registerNib:[self registerNibForTableView] forCellReuseIdentifier:@"cell"];
    }else{
        NSAssert([[[self registerCellClassForTableView] new] isKindOfClass:[SWPopoverContentTableViewCell class]], @"you must return a SWPopoverContentTableViewCell class or sub class");
        [_tableView registerClass:[self registerCellClassForTableView] forCellReuseIdentifier:@"cell"];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if([self.superview isKindOfClass:[SWPopoverView class]]){
        SWPopoverView *popoverView = (SWPopoverView *)self.superview;
        _tableView.scrollEnabled = _dataSource.count * self.rowHeight > popoverView.contentViewSize.height;
    }
}

- (Class)registerCellClassForTableView {
    return [SWPopoverContentTableViewCell class];
}

- (UINib *)registerNibForTableView {
    return nil;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = [dataSource copy];
    [_tableView reloadData];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWPopoverContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(indexPath.row == [tableView numberOfRowsInSection:0] - 1){
        cell.shouldStrokeLine = NO;
    }else{
        cell.shouldStrokeLine = YES;
    }
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([self.superview isKindOfClass:[SWPopoverView class]]){
        [(SWPopoverView *)self.superview hidePopoverAnimated:YES];
    }
    if(_didSelectedIndex){
        _didSelectedIndex(indexPath.row);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end


