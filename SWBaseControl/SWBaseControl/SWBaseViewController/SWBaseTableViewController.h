//
//  SWBaseTableViewController.h
//  SWBaseViewController
//
//  Created by zhoushaowen on 2018/8/6.
//  Copyright © 2018年 Yidu. All rights reserved.
//

#import "SWBaseViewController.h"

@interface SWBaseTableViewController : SWBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,readonly,strong) UITableView *tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end
