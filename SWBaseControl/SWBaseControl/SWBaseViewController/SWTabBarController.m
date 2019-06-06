//
//  SWTabBarController.m
//  SWBaseViewController
//
//  Created by zhoushaowen on 2017/4/13.
//  Copyright © 2017年 Yidu. All rights reserved.
//

#import "SWTabBarController.h"
#import <objc/runtime.h>

@interface SWFixBugTabBarButton : UIView

@end

@implementation SWFixBugTabBarButton

+ (void)load {
    if (@available(iOS 12.1, *)) {
        if(@available(iOS 13.0, *)){
            
        }else{
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            Class originalClass = NSClassFromString(@"UITabBarButton");
            SEL originalSelector = @selector(setFrame:);
            SEL swizzledSelector = @selector(xp_setFrame:);
            Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
            //先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
            BOOL isSuccess = class_addMethod(originalClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            if(!isSuccess){//说明源方法实现了
                class_replaceMethod(originalClass,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod));
                class_replaceMethod(originalClass,
                                    originalSelector,
                                    method_getImplementation(swizzledMethod),
                                    method_getTypeEncoding(swizzledMethod));
            }
        });
        }
    }
}

- (void)xp_setFrame:(CGRect)frame {
    if (!CGRectIsEmpty(self.frame)) {
        // for iPhone 8/8Plus
        if (CGRectIsEmpty(frame)) {
            return;
        }
        // for iPhone XS/XS Max/XR
        frame.size.height = MAX(frame.size.height, 48.0);
    }
    [self xp_setFrame:frame];
}

@end


@interface SWTabBarController ()

@end

@implementation SWTabBarController

- (UIViewController *)childViewControllerForStatusBarHidden {
    return nil;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.selectedViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
    return self.selectedViewController.prefersStatusBarHidden;
}

- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}


@end
