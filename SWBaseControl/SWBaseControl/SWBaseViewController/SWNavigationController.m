//
//  SWNavigationController.m
//  SWBaseViewController
//
//  Created by zhoushaowen on 2017/3/30.
//  Copyright © 2017年 Yidu. All rights reserved.
//

#import "SWNavigationController.h"

@interface SWNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation SWNavigationController

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if(self){
//        [self appearance];
//    }
//    return self;
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if(self){
//        [self appearance];
//    }
//    return self;
//}
//
////这个写法在iOS13失效了
//- (void)appearance {
//    [[UINavigationBar appearanceWhenContainedIn:[self class], nil] setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearanceWhenContainedIn:[self class], nil] setShadowImage:[UIImage new]];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    //设置一下颜色 避免导航在push或pop的时候出现黑色阴影
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[UIImage new]];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return nil;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.topViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
    return self.topViewController.prefersStatusBarHidden;
}

/*
 在iOS6及以上的版本中, 增添了方法UIViewController.supportedInterfaceOrientations. 此方法返回当前viewController支持的方向. 但是, 只有两种情况下此方法才会生效:

 1.当前viewController是window的rootViewController.
 2.当前viewController是modal模式的. 即, 此viewController是被调用presentModalViewController而显示出来的.

 在以上两种情况中,UIViewController.supportedInterfaceOrientations方法会作用于当前viewController和所有childViewController. 以上两种情况之外, UIKit并不会理会你的supportedInterfaceOrientations方法.

 3.只有当modalPresentationStyle为UIModalPresentationFullScreen或者UIModalPresentationCustom modal出的控制器才可以自动旋转的(前提是控制器内部开启了自动旋转),否则即使控制器内部开启了自动旋转 modal出来的控制器也是不可以旋转的;
 */
- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(self.viewControllers.count>1) return YES;
    return NO;
}


@end
