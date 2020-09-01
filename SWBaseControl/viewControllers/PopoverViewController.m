//
//  PopoverViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/29.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "PopoverViewController.h"
#import <SWPopoverView.h>
#import "SWTextPopoverView.h"

@interface PopoverViewController ()

@end

@implementation PopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)btn1Action:(UIButton *)sender {
    SWTextPopoverView *popoverView = [[SWTextPopoverView alloc] initWithTargetView:sender titles:@[@"测试1",@"测试2",@"测试3"]];
    popoverView.didSelectedItem = ^(NSInteger index, NSString * _Nonnull text) {
        NSLog(@"%d---%@",index,text);
    };
    [popoverView showAnimated:YES];
}
- (IBAction)btn2Action:(UIButton *)sender {
    SWTextPopoverView *popoverView = [[SWTextPopoverView alloc] initWithTargetView:sender titles:@[@"1",@"2",@"3"]];
    [popoverView showAnimated:YES];
}
- (IBAction)btn3Action:(UIButton *)sender {
    SWTextPopoverView *popoverView = [[SWTextPopoverView alloc] initWithTargetView:sender titles:@[@"1",@"2",@"3"]];
    [popoverView showAnimated:YES];
}
- (IBAction)btn4Action:(UIButton *)sender {
    SWTextPopoverView *popoverView = [[SWTextPopoverView alloc] initWithTargetView:sender titles:@[@"1",@"2",@"3"]];
    [popoverView showAnimated:YES];
}
- (IBAction)btn5Action:(UIButton *)sender {
    SWTextPopoverView *popoverView = [[SWTextPopoverView alloc] initWithTargetView:sender titles:@[@"1",@"2",@"3"]];
    [popoverView showAnimated:YES];
}
- (IBAction)btn6Action:(UIButton *)sender {
    SWTextPopoverView *popoverView = [[SWTextPopoverView alloc] initWithTargetView:sender titles:@[@"1",@"2",@"3"]];
    [popoverView showAnimated:YES];
}
- (IBAction)btn7Action:(UIButton *)sender {
    SWTextPopoverView *popoverView = [[SWTextPopoverView alloc] initWithTargetView:sender titles:@[@"1",@"2",@"3"]];
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
