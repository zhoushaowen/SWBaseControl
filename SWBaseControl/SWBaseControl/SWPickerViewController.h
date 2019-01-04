//
//  SWPickerViewController.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/8/6.
//

#import <UIKit/UIKit.h>

@class SWPickerViewController;

@protocol SWPickerViewControllerDelegate <NSObject>

/**
 means confirm button is click
 */
- (void)pickerViewControllerDidClickConfirmButton:(SWPickerViewController *)pickerViewController;

@end

@interface UIViewController (SWPickerViewController)

/**
 show a SWPickerViewController.
 */
- (SWPickerViewController *)sw_presentPickerViewController:(SWPickerViewController *)pickerViewController withDelegate:(id<SWPickerViewControllerDelegate>)delegate;

@end

@interface SWPickerViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,readonly,strong,null_unspecified) UIPickerView *pickerView;
@property (nonatomic,copy) NSArray *dataSource;

/**
 affect confirm button's title color,default is nil
 */
@property (nonatomic,strong) UIColor *styleColor;


@end
