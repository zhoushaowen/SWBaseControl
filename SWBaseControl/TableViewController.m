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

- (SWBaseViewControllerType)controllerType {
    return SWBaseViewControllerTableViewType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.sw_barColor = [UIColor redColor];
    self.navigationItem.title = @"Main";
    _dataArray = @[
                   @"BaseViewController",
                   @"PopoverViewController",
                   @"DatePickerViewController",
                   @"ShowPickerViewController",
                   @"ShowProvincesPickerViewController",
                   @"ChatViewController",
                   @"PlaceholderTextViewController",
                   @"AnimateBtnViewController",
                   @"MoveableTableViewController",
                   @"ScaleableTableViewController",
                   @"DisplaySlideViewController",
                   @"XibViewController",
                   @"XibTableViewController",
                   @"XibCollectionViewController",
                   @"BaseTextViewController",
                   @"BaseTextFieldController",
                   @"LeftAlignCollectionViewController",
                   @"ShadowViewTestController",
                   @"TestBannerViewController"
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
//    cell.imageView.image = [UIImage imageNamed:@"1"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class class = NSClassFromString(_dataArray[indexPath.row]);
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


@end
