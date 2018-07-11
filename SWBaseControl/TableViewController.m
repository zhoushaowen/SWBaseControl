//
//  TableViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/29.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
{
    NSArray *_dataArray;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = @[@"PopoverViewController",
                   @"DatePickerViewController",
                   @"ChatViewController",
                   @"PlaceholderTextViewController",
                   @"AnimateBtnViewController",
                   @"MoveableTableViewController",
                   @"ScaleableTableViewController",
                   @"DisplaySlideViewController",
                   ];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class class = NSClassFromString(_dataArray[indexPath.row]);
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
