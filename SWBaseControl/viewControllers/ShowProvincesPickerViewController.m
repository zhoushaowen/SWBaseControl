//
//  ShowProvincesPickerViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2019/7/19.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import "ShowProvincesPickerViewController.h"
#import <SWProvincesPickerViewController.h>

@interface ShowProvincesPickerViewController ()<SWPickerViewControllerDelegate>

@end

@implementation ShowProvincesPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    SWProvincesPickerProvinceModel *model = [SWProvincesPickerViewController getProvinceModelWithProvinceName:@"浙江"];
    NSLog(@"%@",model);
}
- (IBAction)show:(id)sender {
    SWProvincesPickerViewController *picker = [[SWProvincesPickerViewController alloc] initWithSelectedProvinceCode:nil selectedCityCode:@"330100xxx" areaCode:@"330108"];
    [self sw_presentPickerViewController:picker withDelegate:self];
}
- (IBAction)show2:(UIButton *)sender {
    SWProvincesPickerViewController *picker = [[SWProvincesPickerViewController alloc] init];
    picker.provincesPickerMode = SWProvincesPickerModeCity;
    [self sw_presentPickerViewController:picker withDelegate:self];
}
- (IBAction)show3:(id)sender {
    SWProvincesPickerViewController *picker = [[SWProvincesPickerViewController alloc] init];
    picker.provincesPickerMode = SWProvincesPickerModeProvince;
    [self sw_presentPickerViewController:picker withDelegate:self];
}

- (void)pickerViewControllerDidClickConfirmButton:(SWProvincesPickerViewController *)pickerViewController {
    NSLog(@"%@-%@-%@",pickerViewController.selectedProvinceModel.name,pickerViewController.selectedCityModel.name,pickerViewController.selectedAreaModel.name);
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
