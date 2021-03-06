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

@interface UIViewController (SWDatePickerViewController)

/**
 show a SWDatePickerViewController which has a datePicker view,default datePickerMode is UIDatePickerModeDate.
 you can custom datePicker with datePickerConfig block
 */
- (SWDatePickerViewController *)sw_presentDatePickerWithDatePickerConfig:(void(^)(UIDatePicker *datePicker))datePickerConfig delegate:(id<SWDatePickerViewControllerDelegate>)delegate;
/**
 another way to call it
 */
- (SWDatePickerViewController *)sw_presentDatePickerWithDatePickerConfig:(void(^)(UIDatePicker *datePicker))datePickerConfig didSelectedDateBlock:(void(^)(NSDate *selectedDate))didSelectedDateBlock;

@end

@interface SWDatePickerViewController : UIViewController

/**
 affect confirm button's title color,default is nil
 */
@property (nonatomic,strong) UIColor *styleColor;

@end
