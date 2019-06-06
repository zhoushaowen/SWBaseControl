//
//  SWMoveableViewController.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/29.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWMoveableViewController;

@interface UIViewController (SWMoveableViewController)

/**
 present a SWMoveableViewController animated
 */
- (void)presentMoveableViewController:(SWMoveableViewController *)moveableViewController completion:(void(^)(void))completion;

@end

@interface SWMoveableViewController : UIViewController<UIGestureRecognizerDelegate>

/**
 your must overrid this method.
 if your don't want any move,just return nil.
 */
- (UIView *)moveableView;
/**
 if the moveableView has a scrollView subView and conflicting with the pan gesture,your must return the
conflicting scrollView,otherwise the moveableView will can't move.
 */
- (UIScrollView *)conflictingScrollView;



@end
