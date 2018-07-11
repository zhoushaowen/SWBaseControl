//
//  SlideViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/7/6.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SlideViewController.h"

@interface SlideViewController ()

@end

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UISwitch *slider = [[UISwitch alloc] initWithFrame:CGRectMake(30, 80, 100, 100)];
    [self.contentView addSubview:slider];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    btn.frame = CGRectMake(50, 120, 50, 50);
    [self.contentView addSubview:btn];
    
    self.widthOrHeight = 300;
    self.backgroundColor = nil;
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
