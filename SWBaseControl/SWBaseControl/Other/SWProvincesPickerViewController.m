//
//  SWProvincesPickerViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2019/7/19.
//  Copyright © 2019 zhoushaowen. All rights reserved.
// 省市区选择器

#import "SWProvincesPickerViewController.h"
#import <MJExtension.h>


@implementation SWProvincesPickerAreaModel

@end

@implementation SWProvincesPickerCityModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [SWProvincesPickerCityModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"areaList":[SWProvincesPickerAreaModel class]};
        }];
    }
    return self;
}

@end

@implementation SWProvincesPickerProvinceModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [SWProvincesPickerProvinceModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"cityList":[SWProvincesPickerCityModel class]};
        }];
    }
    return self;
}

- (NSArray<SWProvincesPickerCityModel *> *)cityList {
    if(_cityList.count == 0) return nil;
    return _cityList;
}

@end

@interface SWProvincesPickerViewController ()

@property (nonatomic,copy) NSString *provinceCode;
@property (nonatomic,copy) NSString *cityCode;
@property (nonatomic,copy) NSString *areaCode;

@end

@implementation SWProvincesPickerViewController


//- (instancetype)initWithSelectedProvinceCode:(NSString *)provinceCode selectedCityCode:(NSString *)cityCode areaCode:(NSString *)areaCode {
//    self = [super initWithNibName:nil bundle:nil];
//    if(self){
//        self.provinceCode = provinceCode;
//        self.cityCode = cityCode;
//        self.areaCode = areaCode;
//    }
//    return self;
//}

+ (NSArray<SWProvincesPickerProvinceModel *> *)loadAllProvincesData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"2019年5月中华人民共和国县以上行政区划代码.json" ofType:nil];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *provinces = [SWProvincesPickerProvinceModel mj_objectArrayWithKeyValuesArray:jsonStr];
    return provinces;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [SWProvincesPickerViewController loadAllProvincesData];
}

- (void)setDataSource:(NSArray *)dataSource {
    [super setDataSource:dataSource];
    [self.pickerView reloadAllComponents];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    if(self.areaCode){
//        [self.dataSource enumerateObjectsUsingBlock:^(SWProvincesPickerProvinceModel*  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
//            [obj1.cityList enumerateObjectsUsingBlock:^(SWProvincesPickerCityModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
//                [obj2.areaList enumerateObjectsUsingBlock:^(SWProvincesPickerAreaModel * _Nonnull obj3, NSUInteger idx3, BOOL * _Nonnull stop3) {
//                    if([obj3.code isEqualToString:self.areaCode]){
//                        [self.pickerView selectRow:idx1 inComponent:0 animated:NO];
//                        [self.pickerView reloadComponent:1];
//                        [self.pickerView selectRow:idx2 inComponent:1 animated:NO];
//                        [self.pickerView reloadComponent:2];
//                        [self.pickerView selectRow:idx3 inComponent:2 animated:NO];
//                        *stop3 = YES;
//                        *stop2 = YES;
//                        *stop1 = YES;
//                    }
//                }];
//            }];
//        }];
//    }else if (self.cityCode){
//        [self.dataSource enumerateObjectsUsingBlock:^(SWProvincesPickerProvinceModel*  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
//            [obj1.cityList enumerateObjectsUsingBlock:^(SWProvincesPickerCityModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
//                if([obj2.code isEqualToString:self.cityCode]){
//                    [self.pickerView selectRow:idx1 inComponent:0 animated:NO];
//                    [self.pickerView reloadComponent:1];
//                    [self.pickerView selectRow:idx2 inComponent:1 animated:NO];
//                    [self.pickerView reloadComponent:2];
//                    [self.pickerView selectRow:0 inComponent:2 animated:YES];
//                    *stop2 = YES;
//                    *stop1 = YES;
//                }
//            }];
//        }];
//    }else if (self.provinceCode){
//        [self.dataSource enumerateObjectsUsingBlock:^(SWProvincesPickerProvinceModel*  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
//            if([obj1.code isEqualToString:self.provinceCode]){
//                [self.pickerView selectRow:idx1 inComponent:0 animated:NO];
//                [self.pickerView reloadComponent:1];
//                [self.pickerView selectRow:0 inComponent:1 animated:NO];
//                [self.pickerView reloadComponent:2];
//                [self.pickerView selectRow:0 inComponent:2 animated:NO];
//                *stop1 = YES;
//            }
//        }];
//    }else{
//        [self.pickerView selectRow:0 inComponent:0 animated:NO];
//        [self.pickerView reloadComponent:1];
//        [self.pickerView selectRow:0 inComponent:1 animated:NO];
//        [self.pickerView reloadComponent:2];
//        [self.pickerView selectRow:0 inComponent:2 animated:NO];
//    }
//    [self getSelectedModel];
//}

- (void)getSelectedModel {
    if(self.dataSource.count > 0){
        self.selectedProvinceModel = self.dataSource[[self.pickerView selectedRowInComponent:0]];
    }else{
        self.selectedProvinceModel = nil;
    }
    if(self.selectedProvinceModel.cityList.count > 0 && [self.pickerView selectedRowInComponent:1] < self.selectedProvinceModel.cityList.count){
        self.selectedCityModel = self.selectedProvinceModel.cityList[[self.pickerView selectedRowInComponent:1]];
    }else{
        self.selectedCityModel = nil;
    }
    if(self.selectedCityModel.areaList.count > 0 && [self.pickerView selectedRowInComponent:2] < self.selectedCityModel.areaList.count){
        self.selectedAreaModel = self.selectedCityModel.areaList[[self.pickerView selectedRowInComponent:2]];
    }else{
        self.selectedAreaModel = nil;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0) return self.dataSource.count;
    if(component == 1){
        if(self.dataSource.count == 0) return 0;
        NSInteger row = [pickerView selectedRowInComponent:component - 1];
        if(row < 0) return 0;
        SWProvincesPickerProvinceModel *province = self.dataSource[row];
        return province.cityList.count;
    }
    if(self.dataSource.count == 0) return 0;
    NSInteger row0 = [pickerView selectedRowInComponent:component - 2];
    NSInteger row1 = [pickerView selectedRowInComponent:component - 1];
    if(row0 < 0) return 0;
    if(row1 < 0) return 0;
    SWProvincesPickerProvinceModel *province = self.dataSource[row0];
    if(province.cityList.count == 0) return 0;
    SWProvincesPickerCityModel *city = province.cityList[row1];
    if(city.areaList == 0) return 0;
    return city.areaList.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(component == 0){
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else if (component == 1){
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    [self getSelectedModel];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (UILabel *)view;
    if(!label){
        label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:19];
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
    }
    if(component == 0){
        SWProvincesPickerProvinceModel *province = self.dataSource[row];
        label.text = province.name;
    }else if(component == 1){
        SWProvincesPickerProvinceModel *province = self.dataSource[[pickerView selectedRowInComponent:component - 1]];
        if(row < province.cityList.count){
            SWProvincesPickerCityModel *city = province.cityList[row];
            label.text = city.name;
        }
    }else{
        SWProvincesPickerProvinceModel *province = self.dataSource[[pickerView selectedRowInComponent:component - 2]];
        if([pickerView selectedRowInComponent:component - 1] < province.cityList.count){
            SWProvincesPickerCityModel *city = province.cityList[[pickerView selectedRowInComponent:component - 1]];
            if(row < city.areaList.count){
                SWProvincesPickerAreaModel *area = city.areaList[row];
                label.text = area.name;
            }
        }
    }

    return label;
}


@end
