//
//  SWCornerShadowView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2020/4/8.
//  Copyright © 2020 zhoushaowen. All rights reserved.
// 带圆角的阴影视图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#warning if shadow is not appear,please check superView's clipsToBounds property is set to YES.
@interface SWCornerShadowView : UIView

/// default is 10.0
@property (nonatomic) IBInspectable CGFloat shadowCornerRadius;
/// default is whiteColor
@property (nonatomic,strong) IBInspectable UIColor *shadowBackgroundColor;
/// default is blackColor alpha:0.1
@property (nonatomic,strong) IBInspectable UIColor *shadowColor;
/// default is 1.0
@property (nonatomic) IBInspectable float shadowOpacity;
/// default is CGSizeMake(0.0, 0.0)
@property (nonatomic) IBInspectable CGSize shadowOffset;
/// default is 3.0
@property (nonatomic) IBInspectable CGFloat shadowRadius;

/// please add subView on this view
@property (nonatomic,readonly,strong) UIView *contentView;



@end

NS_ASSUME_NONNULL_END
