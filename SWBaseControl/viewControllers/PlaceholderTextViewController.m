//
//  PlaceholderTextViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/29.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "PlaceholderTextViewController.h"
#import <SWBaseTextView.h>

@interface PlaceholderTextViewController ()
{
    SWBaseTextView *_textView;
}
@end

@implementation PlaceholderTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    _textView = [[SWBaseTextView alloc] initWithFrame:CGRectMake(0, 260, self.view.bounds.size.width, 100)];
    _textView.placeholder = @"我是一段占位文字,试试输入文字看看!";
    [self.view addSubview:_textView];
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
