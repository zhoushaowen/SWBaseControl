//
//  SWBaseButton.h
//  Pods-SWBaseControl
//
//  Created by zhoushaowen on 2019/1/23.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SWBaseButton : UIButton

@property (nonatomic,copy,nullable) IBInspectable NSString *hexColorStringForNormalBackgroundImage;//UIControlStateNormal
@property (nonatomic,copy,nullable) IBInspectable NSString *hexColorStringForHighlightedBackgroundImage;//UIControlStateHighlighted
@property (nonatomic,copy,nullable) IBInspectable NSString *hexColorStringForDisabledBackgroundImage;//UIControlStateDisabled
@property (nonatomic,copy,nullable) IBInspectable NSString *hexColorStringForSelectedBackgroundImage;//UIControlStateSelected

@end
