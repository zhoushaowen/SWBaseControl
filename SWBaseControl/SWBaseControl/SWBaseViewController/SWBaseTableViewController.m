//
//  SWBaseTableViewController.m
//  SWBaseViewController
//
//  Created by zhoushaowen on 2018/8/6.
//  Copyright © 2018年 Yidu. All rights reserved.
//

#import "SWBaseTableViewController.h"

@interface SWBaseTableViewController ()

@property (nonatomic) UITableViewStyle style;

@end

@implementation SWBaseTableViewController


@synthesize tableView = _tableView;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        self.style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.style];
    _tableView.tableFooterView = [UIView new];
    //防止外界全局更改了这个属性
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    } else {
        // Fallback on earlier versions
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tableView.frame = self.view.bounds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
