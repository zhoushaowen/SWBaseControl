//
//  ViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/20.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "ViewController.h"
#import <SWBaseButton.h>
#import <SWGrowingTextView.h>
#import <SWBaseTextView.h>
#import <UIImage+SWExtension.h>
#import "ChatViewController.h"
#import <SWDatePickerViewController.h>

@interface ViewController ()<SWDatePickerViewControllerDelegate>
{
    SWGrowingTextView *_growingTextView;
    SWBaseTextView *_textView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWBaseButton *btn = [[SWBaseButton alloc] initWithType:UIButtonTypeCustom style:UIActivityIndicatorViewStyleWhite];
    btn.frame = CGRectMake(30, 100, self.view.bounds.size.width - 60, 50);
    [btn setTitle:@"点我!" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage sw_createImageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    _growingTextView = [[SWGrowingTextView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 50)];
    [self.view addSubview:_growingTextView];
    _textView = [[SWBaseTextView alloc] initWithFrame:CGRectMake(0, 260, self.view.bounds.size.width, 100)];
    _textView.backgroundColor = [UIColor redColor];
    _textView.placeholder = @"请输入文字";
    [self.view addSubview:_textView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%s",__func__);
}

- (void)btnClick:(SWBaseButton *)sender {
    [sender startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender stopAnimating];
        ChatViewController *vc = [[ChatViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [SWDatePickerViewController showDatePickerToViewController:self withDatePickerConfig:nil delegate:self];
}

#pragma mark - SWDatePickerViewControllerDelegate
- (void)datePickerViewController:(SWDatePickerViewController *)datePickerViewController didSelectedDate:(NSDate *)date {
    NSLog(@"%@",date);
}


@end
