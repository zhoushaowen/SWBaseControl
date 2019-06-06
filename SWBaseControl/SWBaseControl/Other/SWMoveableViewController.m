//
//  SWMoveableViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/29.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWMoveableViewController.h"
#import <SWCustomPresentation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <objc/runtime.h>

@interface SWMoveableViewController ()
{
    UIPanGestureRecognizer *_panGesture;
    UITapGestureRecognizer *_tapGesture;
    @public
    __weak SWPresentationController *_presentationController;
}

@property (nonatomic,strong) UIView *moveableContentView;

@end

@implementation UIViewController (SWMoveableViewController)

- (void)presentMoveableViewController:(SWMoveableViewController *)moveableViewController completion:(void (^)(void))completion {
        __weak typeof(moveableViewController) weakVC = moveableViewController;
    [self sw_presentCustomModalPresentationWithViewController:moveableViewController containerViewWillLayoutSubViewsBlock:^(SWPresentationController * _Nonnull presentationController) {
        __strong typeof(weakVC) strongVC = weakVC;
        presentationController.presentedView.frame = presentationController.containerView.bounds;
        presentationController.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
        strongVC->_presentationController = presentationController;
    } animatedTransitioningModel:nil completion:completion];
}

@end

@implementation SWMoveableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecogize:)];
    _tapGesture.delegate = self;
    [self.view addGestureRecognizer:_tapGesture];
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognize:)];
    _panGesture.delegate = self;
    [self.view addGestureRecognizer:_panGesture];
}

- (UIView *)moveableView {
    NSAssert(NO, @"you must override this method");
    return nil;
}

- (UIScrollView *)conflictingScrollView {
    return nil;
}

- (void)tapGestureRecogize:(UITapGestureRecognizer *)gesture {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)panGestureRecognize:(UIPanGestureRecognizer *)gesture {
    if(self.conflictingScrollView.isDragging) return;
    CGPoint translation = [gesture translationInView:gesture.view];
    CGPoint velocity = [gesture velocityInView:gesture.view];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if(translation.y <= 0){
                translation.y = 0;
            }
            [self moveableView].transform = CGAffineTransformMakeTranslation(0, translation.y);
            self->_presentationController.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f + 0.1f * (1 - translation.y/[self moveableView].bounds.size.height)];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if(velocity.y > 200){
                [UIView animateWithDuration:0.35f delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:10 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    [self moveableView].transform = CGAffineTransformMakeTranslation(0, [self moveableView].bounds.size.height);
                } completion:^(BOOL finished) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                }];
            }
            else if (translation.y > [self moveableView].bounds.size.height * 0.4f) {
                [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                    [self moveableView].transform = CGAffineTransformMakeTranslation(0, [self moveableView].bounds.size.height);
                } completion:^(BOOL finished) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                }];
            }
            else{
                [UIView animateWithDuration:0.35f animations:^{
                    [self moveableView].transform = CGAffineTransformIdentity;
                } completion:nil];
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(gestureRecognizer == _tapGesture){
        if(touch.view != gestureRecognizer.view) return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if(gestureRecognizer == _panGesture){
        if(![self moveableView]) return NO;
        CGPoint velocity = [_panGesture velocityInView:_panGesture.view];
        if(velocity.y < 0) return NO;
    }
    return YES;
}

//这个方法返回YES，第一个和第二个互斥时，第二个会失效
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if([self conflictingScrollView]){
        if(otherGestureRecognizer ==  [self conflictingScrollView].panGestureRecognizer){
            if([self conflictingScrollView].contentOffset.y < 0){
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (void)dealloc {
    NSLog(@"%s",__func__);
}



@end









