//
//  DisplaySlideViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/7/6.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "DisplaySlideViewController.h"
#import "SlideViewController.h"

@interface DisplaySlideViewController ()

@end

@implementation DisplaySlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)leftAction:(id)sender {
    [self presentSlideViewController:[SlideViewController new] withAnimationDirection:SWSlideViewControllerAnimationDirectionLeft completion:nil];
}

- (IBAction)rightAction:(id)sender {
    [self presentSlideViewController:[SlideViewController new] withAnimationDirection:SWSlideViewControllerAnimationDirectionRight completion:nil];
}

- (IBAction)topAction:(id)sender {
    [self presentSlideViewController:[SlideViewController new] withAnimationDirection:SWSlideViewControllerAnimationDirectionTop completion:nil];
}

- (IBAction)bottomAction:(id)sender {
    [self presentSlideViewController:[SlideViewController new] withAnimationDirection:SWSlideViewControllerAnimationDirectionBottom completion:nil];
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
