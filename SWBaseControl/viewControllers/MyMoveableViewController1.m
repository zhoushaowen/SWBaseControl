//
//  MyMoveableViewController1.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/7/2.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "MyMoveableViewController1.h"

@interface MyMoveableViewController1 ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIView *_testView;
}
@end

@implementation MyMoveableViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    _testView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 500, self.view.bounds.size.width, 500)];
    _testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_testView];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:_testView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 0)];
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.path = bezierPath.CGPath;
    _testView.layer.mask = shaperLayer;
    _tableView = [[UITableView alloc] initWithFrame:_testView.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_testView addSubview:_tableView];
}

- (UIView *)moveableView {
    return _testView;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
