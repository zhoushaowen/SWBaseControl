//
//  ShowPickerViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/8/6.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "ShowPickerViewController.h"
#import "PickerViewController.h"

@interface ShowPickerViewController ()

@end

@implementation ShowPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)action:(id)sender {
    PickerViewController *vc = [PickerViewController new];
    [self sw_presentPickerViewController:vc withDelegate:self];
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
