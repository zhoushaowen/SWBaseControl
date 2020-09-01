//
//  SWProvincesPickerViewController.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2019/7/19.
//  Copyright © 2019 zhoushaowen. All rights reserved.
// 省市区选择器

#import "SWPickerViewController.h"

NS_ASSUME_NONNULL_BEGIN

///区
@interface SWProvincesPickerAreaModel : NSObject

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *name;

@end

///市
@interface SWProvincesPickerCityModel : NSObject

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy,nullable) NSArray<SWProvincesPickerAreaModel *> *areaList;

@end

///省
@interface SWProvincesPickerProvinceModel : NSObject

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy,nullable) NSArray<SWProvincesPickerCityModel *> *cityList;

@end

typedef NS_ENUM(NSUInteger, SWProvincesPickerMode) {
    SWProvincesPickerModeArea,//显示省市区
    SWProvincesPickerModeCity,//显示省市
    SWProvincesPickerModeProvince,//显示省
};


@interface SWProvincesPickerViewController : SWPickerViewController

- (instancetype)initWithSelectedProvinceCode:(NSString *_Nullable)provinceCode selectedCityCode:(NSString *_Nullable)cityCode areaCode:(NSString *_Nullable)areaCode;
+ (NSArray<SWProvincesPickerProvinceModel *> *)loadAllProvincesData;

@property (nonatomic) SWProvincesPickerMode provincesPickerMode;

@property (nonatomic,strong,nullable) SWProvincesPickerProvinceModel *selectedProvinceModel;
@property (nonatomic,strong,nullable) SWProvincesPickerCityModel *selectedCityModel;
@property (nonatomic,strong,nullable) SWProvincesPickerAreaModel *selectedAreaModel;


@end

NS_ASSUME_NONNULL_END
