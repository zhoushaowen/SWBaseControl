//
//  SWBaseButton.h
//  Pods-SWBaseControl
//
//  Created by zhoushaowen on 2019/1/23.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE
@interface SWBaseButton : UIButton

@property (nonatomic,copy,nullable) IBInspectable NSString *hexColorStringForNormalBackgroundImage;//UIControlStateNormal
@property (nonatomic,copy,nullable) IBInspectable NSString *hexColorStringForHighlightedBackgroundImage;//UIControlStateHighlighted
@property (nonatomic,copy,nullable) IBInspectable NSString *hexColorStringForSelectedBackgroundImage;//UIControlStateSelected
@property (nonatomic,copy,nullable) IBInspectable NSString *hexColorStringForDisabledBackgroundImage;//UIControlStateDisabled

@property (nonatomic,strong,nullable) IBInspectable UIImage *imageForNormal;
@property (nonatomic,strong,nullable) IBInspectable UIImage *imageForHighlighted;
@property (nonatomic,strong,nullable) IBInspectable UIImage *imageForSelected;
@property (nonatomic,strong,nullable) IBInspectable UIImage *imageForDisabled;

@property (nonatomic,strong,nullable) IBInspectable UIImage *backgroundImageForNormal;
@property (nonatomic,strong,nullable) IBInspectable UIImage *backgroundImageForHighlighted;
@property (nonatomic,strong,nullable) IBInspectable UIImage *backgroundImageForSelected;
@property (nonatomic,strong,nullable) IBInspectable UIImage *backgroundImageForDisabled;

@end
