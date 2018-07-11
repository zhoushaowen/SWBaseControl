//
//  ScaleableTableViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/7/2.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "ScaleableTableViewController.h"
#import <UIScrollView+SWHeadScaleableScrollView.h>
#import <UIImageView+SWExtension.h>
#import <UIImage+SWExtension.h>
#import <SWMultipleDelegateProxy.h>
#import "People.h"
#import <MJRefresh.h>

@interface ScaleableTableViewController ()
{
    People *_p;
}
@property (nonatomic,strong) SWMultipleDelegateProxy *multipleDelegateProxy;

@end

@implementation ScaleableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UIImageView *imgV = [UIImageView sw_imageViewWithContentMode:UIViewContentModeScaleAspectFill];
    imgV.image = [UIImage imageNamed:@"1"];
    imgV.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    self.tableView.sw_scaleableHeadView = imgV;
    self.tableView.delegate = self.multipleDelegateProxy;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
}

- (void)refresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self changeNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (SWMultipleDelegateProxy *)multipleDelegateProxy {
    if(!_multipleDelegateProxy){
        _multipleDelegateProxy = [SWMultipleDelegateProxy new];
        _p = [People new];
        _multipleDelegateProxy.allDelegate = @[self,_p];
    }
    return _multipleDelegateProxy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self changeNavigationBar];
}

- (void)changeNavigationBar {
    CGFloat fixedOffsetY = self.tableView.contentOffset.y + self.tableView.contentInset.top;
    CGFloat percent = fixedOffsetY/self.tableView.contentInset.top;
    if(percent > 1.0){
        percent = 1.0;
    }
    if(percent < 0){
        percent = 0;
    }
    if(percent == 1.0){
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage sw_createImageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:percent]] forBarMetrics:UIBarMetricsDefault];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%s",__func__);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
