//
//  TestCollectionPagingViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/8.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import "TestCollectionPagingViewController.h"
#import <SWCollectionPagingView.h>
#import <SWExtension.h>

@interface TestCollectionPagingViewController ()
{
    SWCollectionPagingView *_pagingView;
}
@end

@implementation TestCollectionPagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    SWCollectionPagingView *pagingView = [[SWCollectionPagingView alloc] initWithFrame:CGRectMake(10, SWNavigationBarHeight+10, SWScreenWidth - 20, 300)];
    _pagingView = pagingView;
    [self.view addSubview:pagingView];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [_pagingView.collectionView reloadData];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
