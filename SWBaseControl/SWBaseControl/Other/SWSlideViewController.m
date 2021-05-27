//
//  SWSlideViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/7/6.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWSlideViewController.h"
#import <SWCustomPresentation/SWCustomPresentation.h>

@interface SWSlideViewControllerAnimatedTransitioning : NSObject<SWAnimatedTransitioning>

@end

@implementation SWSlideViewControllerAnimatedTransitioning

- (void)sw_animateTransitionForPresent:(id<UIViewControllerContextTransitioning>)transitionContext {
    SWSlideViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [transitionContext.containerView addSubview:toView];
    switch (toViewController.animationDirection) {
        case SWSlideViewControllerAnimationDirectionLeft:
        {
            toView.transform = CGAffineTransformMakeTranslation(-[UIScreen mainScreen].bounds.size.width, 0);
        }
            break;
        case SWSlideViewControllerAnimationDirectionRight:
        {
            toView.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
        }
            break;
        case SWSlideViewControllerAnimationDirectionTop:
        {
            toView.transform = CGAffineTransformMakeTranslation(0, -[UIScreen mainScreen].bounds.size.height);
        }
            break;
        case SWSlideViewControllerAnimationDirectionBottom:
        {
            toView.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
        }
            break;
            
        default:
            break;
    }
    [UIView animateWithDuration:[self sw_transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:0 animations:^{
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)sw_animateTransitionForDismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    SWSlideViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [UIView animateWithDuration:[self sw_transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        switch (fromViewController.animationDirection) {
            case SWSlideViewControllerAnimationDirectionLeft:
            {
                fromView.transform = CGAffineTransformMakeTranslation(-[UIScreen mainScreen].bounds.size.width, 0);
            }
                break;
            case SWSlideViewControllerAnimationDirectionRight:
            {
                fromView.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
            }
                break;
            case SWSlideViewControllerAnimationDirectionTop:
            {
                fromView.transform = CGAffineTransformMakeTranslation(0, -[UIScreen mainScreen].bounds.size.height);
            }
                break;
            case SWSlideViewControllerAnimationDirectionBottom:
            {
                fromView.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
            }
                break;

            default:
                break;
        }
        transitionContext.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)sw_transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35f;
}


@end

@interface SWSlideViewControllerContentView : UIView
{
    BOOL _isFrameSetEnable;
}

- (void)setSWEnableFrame:(CGRect)frame;

@end

@implementation SWSlideViewControllerContentView

- (void)setFrame:(CGRect)frame {
    if(!_isFrameSetEnable) return;
    return [super setFrame:frame];
}

- (void)setSWEnableFrame:(CGRect)frame {
    _isFrameSetEnable = YES;
    [super setFrame:frame];
    _isFrameSetEnable = NO;
}

@end

@interface SWSlideViewController ()
{
    UITapGestureRecognizer *_tapGesture;
    UIPanGestureRecognizer *_panGesture;
    @public
    __weak SWPresentationController *_presentationController;
}

@property (nonatomic) SWSlideViewControllerAnimationDirection animationDirection;

@end

@implementation UIViewController (SWSlideViewController)

- (void)presentSlideViewController:(SWSlideViewController *)slideViewController withAnimationDirection:(SWSlideViewControllerAnimationDirection)animationDirection completion:(void (^)(void))completion {
    slideViewController.animationDirection = animationDirection;
    __weak typeof(slideViewController) weakSlideViewController = slideViewController;
    [self sw_presentCustomModalPresentationWithViewController:slideViewController containerViewWillLayoutSubViewsBlock:^(SWPresentationController * _Nonnull presentationController) {
        __strong typeof(weakSlideViewController) strongSlideViewController = weakSlideViewController;
        presentationController.presentedView.frame = [UIScreen mainScreen].bounds;
        presentationController.containerView.backgroundColor = strongSlideViewController.backgroundColor?:[[UIColor blackColor] colorWithAlphaComponent:0.2f];
        strongSlideViewController->_presentationController = presentationController;
    } animatedTransitioningModel:[SWSlideViewControllerAnimatedTransitioning new] completion:^{
    }];
}

@end

@implementation SWSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
    _contentView = [[SWSlideViewControllerContentView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.shadowOpacity = 0.3f;
    _contentView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f].CGColor;
    _contentView.layer.shadowOffset = CGSizeZero;
    [self.view addSubview:_contentView];
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    _tapGesture.delegate = self;
    [self.view addGestureRecognizer:_tapGesture];
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _panGesture.delegate = self;
    [self.view addGestureRecognizer:_panGesture];
    self.widthOrHeight = 240;
}

- (void)updateViewConstraints {
    [self setContentViewConstraint];
    [super updateViewConstraints];
}

- (void)setContentViewConstraint {
    switch (self.animationDirection) {
        case SWSlideViewControllerAnimationDirectionLeft:
        {
            [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_contentView(width)]" options:0 metrics:@{@"width":@(self.widthOrHeight)} views:NSDictionaryOfVariableBindings(_contentView)]];
            [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_contentView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)]];
        }
            break;
        case SWSlideViewControllerAnimationDirectionRight:
        {
            [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_contentView(width)]-0-|" options:0 metrics:@{@"width":@(self.widthOrHeight)} views:NSDictionaryOfVariableBindings(_contentView)]];
            [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_contentView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)]];
        }
            break;
        case SWSlideViewControllerAnimationDirectionTop:
        {
            [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_contentView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)]];
            [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_contentView(height)]" options:0 metrics:@{@"height":@(self.widthOrHeight)} views:NSDictionaryOfVariableBindings(_contentView)]];
        }
            break;
        case SWSlideViewControllerAnimationDirectionBottom:
        {
            [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_contentView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)]];
            [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_contentView(height)]-0-|" options:0 metrics:@{@"height":@(self.widthOrHeight)} views:NSDictionaryOfVariableBindings(_contentView)]];
        }
            break;
            
        default:
            break;
    }
}

- (void)setWidthOrHeight:(CGFloat)widthOrHeight {
    _widthOrHeight = widthOrHeight;
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    if(_backgroundColor == nil){
        _presentationController.containerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
    }else{
        _presentationController.containerView.backgroundColor = _backgroundColor;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(gestureRecognizer == _tapGesture && touch.view != gestureRecognizer.view) return NO;
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if(gestureRecognizer == _panGesture){
        CGPoint velocity = [_panGesture velocityInView:_panGesture.view];
        switch (self.animationDirection) {
            case SWSlideViewControllerAnimationDirectionLeft:
            {
                if(velocity.x > 0) return NO;
            }
                break;
            case SWSlideViewControllerAnimationDirectionRight:
            {
                if(velocity.x < 0) return NO;
            }
                break;
            case SWSlideViewControllerAnimationDirectionTop:
            {
                if(velocity.y > 0) return NO;
            }
                break;
            case SWSlideViewControllerAnimationDirectionBottom:
            {
                if(velocity.y < 0) return NO;
            }
                break;
                
            default:
                break;
        }
    }
    return YES;
}

#pragma mark - handleGesture
- (void)handleTapGesture:(UITapGestureRecognizer *)gesture {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:gesture.view];
    CGPoint velocity = [gesture velocityInView:gesture.view];
    switch (gesture.state) {
        case UIGestureRecognizerStateChanged:
        {
            switch (self.animationDirection) {
                case SWSlideViewControllerAnimationDirectionLeft:
                {
                    if(translation.x > 0){
                        translation.x = 0;
                    }
                    self.contentView.transform = CGAffineTransformMakeTranslation(translation.x, 0);
                }
                    break;
                case SWSlideViewControllerAnimationDirectionRight:
                {
                    if(translation.x < 0){
                        translation.x = 0;
                    }
                    self.contentView.transform = CGAffineTransformMakeTranslation(translation.x, 0);
                }
                    break;
                case SWSlideViewControllerAnimationDirectionTop:
                {
                    if(translation.y > 0){
                        translation.y = 0;
                    }
                    self.contentView.transform = CGAffineTransformMakeTranslation(0, translation.y);
                }
                    break;
                case SWSlideViewControllerAnimationDirectionBottom:
                {
                    if(translation.y < 0){
                        translation.y = 0;
                    }
                    self.contentView.transform = CGAffineTransformMakeTranslation(0, translation.y);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            switch (self.animationDirection) {
                case SWSlideViewControllerAnimationDirectionLeft:
                {
                    if(velocity.x < -200){
                        [UIView animateWithDuration:0.35f delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:6 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.contentView.transform = CGAffineTransformMakeTranslation(-self.contentView.bounds.size.width, 0);
                        } completion:^(BOOL finished) {
                            [self dismissViewControllerAnimated:NO completion:nil];
                        }];
                    }
                    else if (translation.x < -0.4*self.contentView.bounds.size.width){
                        [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.contentView.transform = CGAffineTransformMakeTranslation(-self.contentView.bounds.size.width, 0);
                        } completion:^(BOOL finished) {
                            [self dismissViewControllerAnimated:NO completion:nil];
                        }];
                    }else{
                        [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.contentView.transform = CGAffineTransformIdentity;
                        } completion:^(BOOL finished) {
                        }];
                    }

                }
                    break;
                case SWSlideViewControllerAnimationDirectionRight:
                {
                    if(velocity.x > 200){
                        [UIView animateWithDuration:0.35f delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:6 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.contentView.transform = CGAffineTransformMakeTranslation(self.contentView.bounds.size.width, 0);
                        } completion:^(BOOL finished) {
                            [self dismissViewControllerAnimated:NO completion:nil];
                        }];
                    }
                    else if (translation.x > 0.4*self.contentView.bounds.size.width){
                        [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.contentView.transform = CGAffineTransformMakeTranslation(self.contentView.bounds.size.width, 0);
                        } completion:^(BOOL finished) {
                            [self dismissViewControllerAnimated:NO completion:nil];
                        }];
                    }else{
                        [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.contentView.transform = CGAffineTransformIdentity;
                        } completion:^(BOOL finished) {
                        }];
                    }

                }
                    break;
                case SWSlideViewControllerAnimationDirectionTop:
                {
                    if(velocity.y < -200){
                        [UIView animateWithDuration:0.35f delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:6 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentView.bounds.size.height);
                        } completion:^(BOOL finished) {
                            [self dismissViewControllerAnimated:NO completion:nil];
                        }];
                    }
                    else if (translation.y < -0.4*self.contentView.bounds.size.height){
                        [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentView.bounds.size.height);
                        } completion:^(BOOL finished) {
                            [self dismissViewControllerAnimated:NO completion:nil];
                        }];
                    }else{
                        [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.contentView.transform = CGAffineTransformIdentity;
                        } completion:^(BOOL finished) {
                        }];
                    }

                }
                    break;
                case SWSlideViewControllerAnimationDirectionBottom:
                {
                    if(velocity.y > 200){
                        [UIView animateWithDuration:0.35f delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:6 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.contentView.transform = CGAffineTransformMakeTranslation(0, self.contentView.bounds.size.height);
                        } completion:^(BOOL finished) {
                            [self dismissViewControllerAnimated:NO completion:nil];
                        }];
                    }
                    else if (translation.y > 0.4*self.contentView.bounds.size.height){
                        [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.contentView.transform = CGAffineTransformMakeTranslation(0, self.contentView.bounds.size.height);
                        } completion:^(BOOL finished) {
                            [self dismissViewControllerAnimated:NO completion:nil];
                        }];
                    }else{
                        [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.contentView.transform = CGAffineTransformIdentity;
                        } completion:^(BOOL finished) {
                        }];
                    }

                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
