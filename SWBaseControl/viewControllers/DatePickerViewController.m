//
//  DatePickerViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/29.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "DatePickerViewController.h"
#import <SWDatePickerViewController.h>

@interface DatePickerViewController ()<SWDatePickerViewControllerDelegate>

@end

@implementation DatePickerViewController


- (IBAction)clickBtn:(id)sender {
    [SWDatePickerViewController showDatePickerToViewController:self withDatePickerConfig:nil delegate:self];
}

#pragma mark - SWDatePickerViewControllerDelegate
- (void)datePickerViewController:(SWDatePickerViewController *)datePickerViewController didSelectedDate:(NSDate *)date {
    NSLog(@"%@",date);
}





@end
