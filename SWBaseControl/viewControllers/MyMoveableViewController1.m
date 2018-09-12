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
    UIView *_moveableContentView;
}
@end

@implementation MyMoveableViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _moveableContentView = [UIView new];
    _moveableContentView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_moveableContentView];
    [self setMoveableContentViewFrameWithSize:self.view.bounds.size];

    _tableView = [[UITableView alloc] initWithFrame:_moveableContentView.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_moveableContentView addSubview:_tableView];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self setMoveableContentViewFrameWithSize:size];
}

- (void)setMoveableContentViewFrameWithSize:(CGSize)size {
    CGFloat height = 500;
    if(height > size.height){
        height = size.height;
    }
    _moveableContentView.frame = CGRectMake(0, size.height - height, size.width, height);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:_moveableContentView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 0)];
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.path = bezierPath.CGPath;
    _moveableContentView.layer.mask = shaperLayer;
    _tableView.frame = _moveableContentView.bounds;
}

- (UIView *)moveableView {
    return _moveableContentView;
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.y < 0) {
        scrollView.scrollEnabled = NO;
    }else{
        scrollView.scrollEnabled = YES;
    }
}

@end
