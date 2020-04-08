//
//  SWCornerShadowView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2020/4/8.
//  Copyright © 2020 zhoushaowen. All rights reserved.
// 带圆角的阴影视图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWCornerShadowView : UIView

/// default is 10.0
@property (nonatomic) CGFloat shadowCornerRadius;
/// default is whiteColor
@property (nonatomic,strong) UIColor *shadowBackgroundColor;
/// default is blackColor
@property (nonatomic,strong) UIColor *shadowColor;
/// default is 0.5
@property (nonatomic) float shadowOpacity;
/// default is CGSizeMake(0.0, -3.0)
@property (nonatomic) CGSize shadowOffset;
/// default is 3.0
@property (nonatomic) CGFloat shadowRadius;

/// please add subView on this view
@property (nonatomic,readonly,strong) UIView *contentView;



@end

NS_ASSUME_NONNULL_END
