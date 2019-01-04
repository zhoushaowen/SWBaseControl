//
//  PopoverViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/29.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "PopoverViewController.h"
#import "MyPopoverContentTableView.h"
#import <SWPopoverView.h>

@interface PopoverViewController ()

@end

@implementation PopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightItemClick)];
}

- (void)rightItemClick {
    MyPopoverContentTableView *contentView = [MyPopoverContentTableView new];
    contentView.dataSource = @[@"1",@"2",@"3",@"4",@"5"];
    contentView.didSelectedIndex = ^(NSInteger index) {
        NSLog(@"%ld",(long)index);
    };
    SWPopoverView *popoverView = [[SWPopoverView alloc] initWithContentView:contentView contentViewSize:CGSizeMake(130, contentView.rowHeight*5) arrowPoint:CGPointMake(self.view.bounds.size.width - 30, 70) arrowDirection:SWPopoverArrowDirectionTop contentViewCenterOffset:-50];
    popoverView.popoverViewDidHidden = ^{
        NSLog(@"popoverViewDidHidden");
    };
    [popoverView showAnimated:YES];
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
