//
//  SWTableView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/10/9.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import "SWTableView.h"

@implementation SWTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if(self){
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlie   r versions
    }
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 44.0f;
    self.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.estimatedSectionHeaderHeight = 44.0f;
    self.sectionFooterHeight = UITableViewAutomaticDimension;
    //不要设置UITableViewAutomaticDimension 否则UITableViewStyleGrouped 底部有间隙
    self.estimatedSectionFooterHeight = 44.0f;
//            _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    //去除UITableViewStyleGrouped样式导致的tableView头部空白间隙
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.01)];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.01)];
    self.tableHeaderView = headerView;
    self.tableFooterView = footerView;
    if (@available(iOS 15.0, *)) {
        //从 iOS 15 开始，TableView 增加sectionHeaderTopPadding属性，默认情况sectionHeaderTopPadding会有22个像素的高度
        //手动关闭
        self.sectionHeaderTopPadding = 0;
    } else {
        // Fallback on earlier versions
    }
}

@end
