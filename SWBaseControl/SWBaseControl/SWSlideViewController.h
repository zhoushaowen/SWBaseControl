//
//  SWSlideViewController.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/7/6.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SWSlideViewControllerAnimationDirection) {
    SWSlideViewControllerAnimationDirectionLeft,
    SWSlideViewControllerAnimationDirectionRight,
    SWSlideViewControllerAnimationDirectionTop,
    SWSlideViewControllerAnimationDirectionBottom,
};

@interface SWSlideViewController : UIViewController<UIGestureRecognizerDelegate>

/**
 add subViews in this view,do not in self.view;
 */
@property (nonatomic,readonly,strong,null_unspecified) __kindof UIView *contentView;
@property (nonatomic,readonly) SWSlideViewControllerAnimationDirection animationDirection;

/**
 use this property to change background color,do not use self.view.backgroundColor;
 */
@property (nonatomic,strong,nullable) UIColor *backgroundColor;
/**
 the width or height of contentView,default is 240
 */
@property (nonatomic) CGFloat widthOrHeight;

@end

@interface UIViewController (SWSlideViewController)

/**
 present a SWSlideViewController,if your want hide it,just call dismissViewController;
 */
- (void)presentSlideViewController:(SWSlideViewController *)slideViewController withAnimationDirection:(SWSlideViewControllerAnimationDirection)animationDirection completion:(void(^)(void))completion;

@end

