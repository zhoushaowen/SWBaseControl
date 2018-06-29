//
//  AnimateBtnViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/29.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "AnimateBtnViewController.h"
#import <SWBaseButton.h>
#import <UIImage+SWExtension.h>

@interface AnimateBtnViewController ()

@end

@implementation AnimateBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    SWBaseButton *btn = [[SWBaseButton alloc] initWithType:UIButtonTypeCustom style:UIActivityIndicatorViewStyleWhite];
    btn.frame = CGRectMake(30, 100, self.view.bounds.size.width - 60, 50);
    [btn setTitle:@"点我!" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage sw_createImageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)btnClick:(SWBaseButton *)sender {
    [sender startAnimating];
    NSLog(@"网络请求中...");
    [sender setTitle:@"网络请求中..." forState:UIControlStateNormal];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender stopAnimating];
        NSLog(@"网络请求结束");
        [sender setTitle:@"网络请求结束" forState:UIControlStateNormal];
    });
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
