//
//  MyMoveableViewController2.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/7/2.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "MyMoveableViewController2.h"

@interface MyMoveableViewController2 ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation MyMoveableViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 500, self.view.bounds.size.width, 500) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (UIView *)moveableView {
    return _tableView;
}

- (UIScrollView *)conflictingScrollView {
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

@end
