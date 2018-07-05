//
//  UIScrollView+SWHeadScaleableScrollView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/7/2.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (SWHeadScaleableScrollView)

/**
 add a scaleable header view in the scrollView,it can be nil.
 if you don't given the sw_scaleableHeadView size,the default height is 200.
 */
@property (nonatomic,strong,nullable) UIView *sw_scaleableHeadView;

@end
