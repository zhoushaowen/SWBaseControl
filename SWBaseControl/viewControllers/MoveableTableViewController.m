//
//  MoveableTableViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/29.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "MoveableTableViewController.h"
#import "MyMoveableViewController1.h"
#import "MyMoveableViewController2.h"
#import "MyMoveableViewController3.h"

@interface MoveableTableViewController ()

@end

@implementation MoveableTableViewController

- (IBAction)clickBtn1:(id)sender {
    MyMoveableViewController1 *vc = [MyMoveableViewController1 new];
    [self presentMoveableViewController:vc completion:nil];
}

- (IBAction)clickBtn2:(id)sender {
    MyMoveableViewController2 *vc = [MyMoveableViewController2 new];
    [self presentMoveableViewController:vc completion:nil];
}

- (IBAction)clickBtn3:(id)sender {
    MyMoveableViewController3 *vc = [MyMoveableViewController3 new];
    [self presentMoveableViewController:vc completion:nil];
}


@end
