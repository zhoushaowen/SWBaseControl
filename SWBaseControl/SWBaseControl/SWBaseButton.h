//
//  SWBaseButton.h
//  Pods-SWBaseControl
//
//  Created by zhoushaowen on 2019/1/23.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SWBaseButton : UIButton

@property (nonatomic,copy,nullable) IBInspectable NSString *backgroundImageHexStringForNormal;//UIControlStateNormal
@property (nonatomic,copy,nullable) IBInspectable NSString *backgroundImageHexStringForHighlighted;//UIControlStateHighlighted
@property (nonatomic,copy,nullable) IBInspectable NSString *backgroundImageHexStringForDisabled;//UIControlStateDisabled
@property (nonatomic,copy,nullable) IBInspectable NSString *backgroundImageHexStringForSelected;//UIControlStateSelected

@end
