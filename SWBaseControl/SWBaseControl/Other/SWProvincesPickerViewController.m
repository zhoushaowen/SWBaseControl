//
//  SWProvincesPickerViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2019/7/19.
//  Copyright © 2019 zhoushaowen. All rights reserved.
// 省市区选择器

#import "SWProvincesPickerViewController.h"
#import <MJExtension/MJExtension.h>

NS_INLINE BOOL HasSuffix(NSString *name,NSString *removeString){
    if(name.length > removeString.length){
        NSRange range = [name rangeOfString:removeString options:NSBackwardsSearch range:NSMakeRange(name.length - removeString.length, removeString.length)];
        if(range.location != NSNotFound && range.location > 1){
            return YES;
        }
    }
    return NO;
}

NS_INLINE NSString *GetShortName(NSString *name,NSString *removeString){
    return [name stringByReplacingOccurrencesOfString:removeString withString:@"" options:NSBackwardsSearch range:NSMakeRange(name.length - removeString.length, removeString.length)];
}

@implementation SWProvincesPickerAreaModel

- (void)mj_keyValuesDidFinishConvertingToObject {
    if(self.name.length > 0){
        if(HasSuffix(self.name, @"市")){
            self.shortName = GetShortName(self.name, @"市");
        }
        else if (HasSuffix(self.name, @"县")){
            self.shortName = GetShortName(self.name, @"县");
        }
        else if (HasSuffix(self.name, @"新区")){
            self.shortName = GetShortName(self.name, @"新区");
        }
        else if (HasSuffix(self.name, @"区")){
            self.shortName = GetShortName(self.name, @"区");
        }
        else{
            self.shortName = self.name;
        }

    }
}

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

- (void)mj_keyValuesDidFinishConvertingToObject {
    if(self.name.length > 0){
        if(HasSuffix(self.name, @"市")){
            self.shortName = GetShortName(self.name, @"市");
        }
        else{
            self.shortName = self.name;
        }

    }
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

- (void)mj_keyValuesDidFinishConvertingToObject {
    if(self.name.length > 0){
        if(HasSuffix(self.name, @"市")){
            self.shortName = GetShortName(self.name, @"市");
        }
        else if (HasSuffix(self.name, @"省")){
            self.shortName = GetShortName(self.name, @"省");
        }
        else if (HasSuffix(self.name, @"特别行政区")){
            self.shortName = GetShortName(self.name, @"特别行政区");
        }
        else if (HasSuffix(self.name, @"壮族自治区")){
            self.shortName = GetShortName(self.name, @"壮族自治区");
        }
        else if (HasSuffix(self.name, @"回族自治区")){
            self.shortName = GetShortName(self.name, @"回族自治区");
        }
        else if (HasSuffix(self.name, @"维吾尔自治区")){
            self.shortName = GetShortName(self.name, @"维吾尔自治区");
        }
        else if (HasSuffix(self.name, @"自治区")){
            self.shortName = GetShortName(self.name, @"自治区");
        }
        else{
            self.shortName = self.name;
        }

    }
}


@end

@interface SWProvincesPickerViewController ()

@property (nonatomic,copy) NSString *provinceCode;
@property (nonatomic,copy) NSString *cityCode;
@property (nonatomic,copy) NSString *areaCode;

@end

@implementation SWProvincesPickerViewController


- (instancetype)initWithSelectedProvinceCode:(NSString *)provinceCode selectedCityCode:(NSString *)cityCode areaCode:(NSString *)areaCode {
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        self.provinceCode = provinceCode;
        self.cityCode = cityCode;
        self.areaCode = areaCode;
    }
    return self;
}

+ (NSArray<SWProvincesPickerProvinceModel *> *)loadAllProvincesData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"2019年5月中华人民共和国县以上行政区划代码.json" ofType:nil];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *provinces = [SWProvincesPickerProvinceModel mj_objectArrayWithKeyValuesArray:jsonStr];
    return provinces;
}

+ (SWProvincesPickerProvinceModel *)getProvinceModelWithProvinceName:(NSString *)provinceName {
    if(provinceName.length > 0){
        __block SWProvincesPickerProvinceModel *model = nil;
        [[self loadAllProvincesData] enumerateObjectsUsingBlock:^(SWProvincesPickerProvinceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj.name isEqualToString:provinceName] || [obj.shortName isEqualToString:provinceName]){
                model = obj;
                *stop = YES;
            }
        }];
        return model;
    }
    return nil;
}

+ (SWProvincesPickerCityModel *)getCityModelWithCityName:(NSString *)cityName {
    if(cityName.length > 0){
        __block SWProvincesPickerCityModel *model = nil;
        [[self loadAllProvincesData] enumerateObjectsUsingBlock:^(SWProvincesPickerProvinceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.cityList enumerateObjectsUsingBlock:^(SWProvincesPickerCityModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                if([obj2.name isEqualToString:cityName] || [obj2.shortName isEqualToString:cityName]){
                    model = obj2;
                    *stop = YES;
                    *stop2 = YES;
                }
            }];
        }];
        return model;
    }
    return nil;
}

+ (SWProvincesPickerAreaModel *)getAreaModelWithAreaName:(NSString *)areaName {
    if(areaName.length > 0){
        __block SWProvincesPickerAreaModel *model = nil;
        [[self loadAllProvincesData] enumerateObjectsUsingBlock:^(SWProvincesPickerProvinceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.cityList enumerateObjectsUsingBlock:^(SWProvincesPickerCityModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                [obj2.areaList enumerateObjectsUsingBlock:^(SWProvincesPickerAreaModel * _Nonnull obj3, NSUInteger idx3, BOOL * _Nonnull stop3) {
                    if([obj3.name isEqualToString:areaName] || [obj3.shortName isEqualToString:areaName]){
                        model = obj3;
                        *stop = YES;
                        *stop2 = YES;
                        *stop3 = YES;
                    }
                }];
            }];
        }];
        return model;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [SWProvincesPickerViewController loadAllProvincesData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setInitialSelected];
    [self getSelectedModel];
}

- (void)setDataSource:(NSArray *)dataSource {
    [super setDataSource:dataSource];
    [self.pickerView reloadAllComponents];
}

- (void)setInitialSelected {
    if(self.areaCode && self.provincesPickerMode == SWProvincesPickerModeArea){
        [self.dataSource enumerateObjectsUsingBlock:^(SWProvincesPickerProvinceModel*  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            [obj1.cityList enumerateObjectsUsingBlock:^(SWProvincesPickerCityModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                [obj2.areaList enumerateObjectsUsingBlock:^(SWProvincesPickerAreaModel * _Nonnull obj3, NSUInteger idx3, BOOL * _Nonnull stop3) {
                    if([obj3.code isEqualToString:self.areaCode]){
                        [self.pickerView selectRow:idx1 inComponent:0 animated:YES];
                        [self.pickerView reloadComponent:1];
                        [self.pickerView selectRow:idx2 inComponent:1 animated:YES];
                        [self.pickerView reloadComponent:2];
                        [self.pickerView selectRow:idx3 inComponent:2 animated:YES];
                        *stop3 = YES;
                        *stop2 = YES;
                        *stop1 = YES;
                    }
                }];
            }];
        }];
    }else if (self.cityCode && self.provincesPickerMode != SWProvincesPickerModeProvince){
        [self.dataSource enumerateObjectsUsingBlock:^(SWProvincesPickerProvinceModel*  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            [obj1.cityList enumerateObjectsUsingBlock:^(SWProvincesPickerCityModel * _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                if([obj2.code isEqualToString:self.cityCode]){
                    [self.pickerView selectRow:idx1 inComponent:0 animated:NO];
                    [self.pickerView reloadComponent:1];
                    [self.pickerView selectRow:idx2 inComponent:1 animated:NO];
                    [self.pickerView reloadComponent:2];
                    [self.pickerView selectRow:0 inComponent:2 animated:YES];
                    *stop2 = YES;
                    *stop1 = YES;
                }
            }];
        }];
    }else if (self.provinceCode){
        [self.dataSource enumerateObjectsUsingBlock:^(SWProvincesPickerProvinceModel*  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            if([obj1.code isEqualToString:self.provinceCode]){
                [self.pickerView selectRow:idx1 inComponent:0 animated:NO];
                [self.pickerView reloadComponent:1];
                [self.pickerView selectRow:0 inComponent:1 animated:NO];
                [self.pickerView reloadComponent:2];
                [self.pickerView selectRow:0 inComponent:2 animated:NO];
                *stop1 = YES;
            }
        }];
    }
}

- (void)getSelectedModel {
    self.provinceCode = nil;
    self.cityCode = nil;
    self.areaCode = nil;
    if(self.dataSource.count > 0){
        self.selectedProvinceModel = self.dataSource[[self.pickerView selectedRowInComponent:0]];
    }else{
        self.selectedProvinceModel = nil;
    }
    if(self.provincesPickerMode != SWProvincesPickerModeProvince && self.selectedProvinceModel.cityList.count > 0 && [self.pickerView selectedRowInComponent:1] < self.selectedProvinceModel.cityList.count){
        self.selectedCityModel = self.selectedProvinceModel.cityList[[self.pickerView selectedRowInComponent:1]];
    }else{
        self.selectedCityModel = nil;
    }
    if(self.provincesPickerMode == SWProvincesPickerModeArea && self.selectedCityModel.areaList.count > 0 && [self.pickerView selectedRowInComponent:2] < self.selectedCityModel.areaList.count){
        self.selectedAreaModel = self.selectedCityModel.areaList[[self.pickerView selectedRowInComponent:2]];
    }else{
        self.selectedAreaModel = nil;
    }
}

- (void)setProvincesPickerMode:(SWProvincesPickerMode)provincesPickerMode {
    _provincesPickerMode = provincesPickerMode;
    [self.pickerView reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.provincesPickerMode == SWProvincesPickerModeArea ? 3:(self.provincesPickerMode == SWProvincesPickerModeCity ? 2:1);
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0) return self.dataSource.count;
    if(component == 1){
        if(self.dataSource.count == 0) return 0;
        NSInteger row = [pickerView selectedRowInComponent:component - 1];
        if(row < 0) return 0;
        if(row >= self.dataSource.count) return 0;
        SWProvincesPickerProvinceModel *province = self.dataSource[row];
        return province.cityList.count;
    }
    if(self.dataSource.count == 0) return 0;
    NSInteger row0 = [pickerView selectedRowInComponent:component - 2];
    NSInteger row1 = [pickerView selectedRowInComponent:component - 1];
    if(row0 < 0) return 0;
    if(row1 < 0) return 0;
    if(row0 >= self.dataSource.count) return 0;
    SWProvincesPickerProvinceModel *province = self.dataSource[row0];
    if(province.cityList.count == 0) return 0;
    if(row1 >= province.cityList.count) return 0;
    SWProvincesPickerCityModel *city = province.cityList[row1];
    if(city.areaList == 0) return 0;
    return city.areaList.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //每reload上一个component之后要赶紧调用selectRow,否则reload下一个component否则会导致numberOfRowsInComponent中的数组越界
    if(component == 0){
        if(self.provincesPickerMode != SWProvincesPickerModeProvince){
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
        }
        if(self.provincesPickerMode == SWProvincesPickerModeArea){
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }else if (component == 1){
        if(self.provincesPickerMode == SWProvincesPickerModeArea){
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
    [self getSelectedModel];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if(!view){
        view = [UIView new];
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:19];
        label.tag = 100;
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[label]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    }
    UILabel *label = (UILabel *)[view viewWithTag:100];
    if(component == 0 && row >= 0){
        SWProvincesPickerProvinceModel *province = self.dataSource[row];
        label.text = province.name;
    }else if(component == 1){
        NSInteger row0 = [pickerView selectedRowInComponent:0];
        if(row0 >= 0 && row0 < self.dataSource.count){
            SWProvincesPickerProvinceModel *province = self.dataSource[row0];
            if(row >= 0 && row < province.cityList.count){
                SWProvincesPickerCityModel *city = province.cityList[row];
                label.text = city.name;
            }
        }
    }else{
        NSInteger row0 = [pickerView selectedRowInComponent:0];
        if(row0 >= 0 && row0 < self.dataSource.count){
            SWProvincesPickerProvinceModel *province = self.dataSource[row0];
            NSInteger row1 = [pickerView selectedRowInComponent:1];
            if(row1 >= 0 && row1 < province.cityList.count){
                SWProvincesPickerCityModel *city = province.cityList[row1];
                if(row >= 0 && row < city.areaList.count){
                    SWProvincesPickerAreaModel *area = city.areaList[row];
                    label.text = area.name;
                }
            }
        }
    }

    return view;
}


@end
