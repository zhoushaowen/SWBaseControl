//
//  ViewController.m
//  SWBaseViewController
//
//  Created by zhoushaowen on 2017/3/30.
//  Copyright © 2017年 Yidu. All rights reserved.
//

#import "BaseViewController.h"
//#import "NextViewController.h"
//#import "PresentViewController.h"
#import "SWNavigationController.h"
//#import "SWVisualEffectView.h"

static NSString *Cell = @"cell";

@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标题";
//    self.sw_barColor = [UIColor purpleColor];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
//    self.navigationItem.rightBarButtonItem = item;
//    item.tintColor = [UIColor whiteColor];
//    UIBarButtonItem *presentItem = [[UIBarButtonItem alloc] initWithTitle:@"present" style:UIBarButtonItemStylePlain target:self action:@selector(presentItemClick)];
//    self.navigationItem.leftBarButtonItem = presentItem;
//    item.tintColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 150;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Cell];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tableView.frame = self.view.bounds;
}

- (void)rightItemClick {
//    NextViewController *vc = [NextViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)presentItemClick {
//    PresentViewController *vc = [PresentViewController new];
//    SWNavigationController *nav = [[SWNavigationController alloc] initWithRootViewController:vc];
//    [self presentViewController:nav animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd",indexPath.row%2?1:2]];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd-%zd",indexPath.section,indexPath.row];
    return cell;
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}




@end
