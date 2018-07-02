//
//  SWDatePickerViewController.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/26.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWDatePickerViewController;

@protocol SWDatePickerViewControllerDelegate <NSObject>

/**
 means confirm button is click
 */
- (void)datePickerViewController:(SWDatePickerViewController *)datePickerViewController didSelectedDate:(NSDate *)date;

@end

@interface SWDatePickerViewController : UIViewController

/**
 show a SWDatePickerViewController which has a datePicker view,default datePickerMode is UIDatePickerModeDate.
 you can custom datePicker with datePickerConfig block
 */
+ (instancetype)showDatePickerToViewController:(UIViewController *)viewController withDatePickerConfig:(void(^)(UIDatePicker *datePicker))datePickerConfig delegate:(id<SWDatePickerViewControllerDelegate>)delegate;
/**
 affect confirm button's title color,default is nil
 */
@property (nonatomic,strong) UIColor *styleColor;

@end
