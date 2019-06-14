//
//  UIScrollView+SWHeadScaleableScrollView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/7/2.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "UIScrollView+SWHeadScaleableScrollView.h"
#import <objc/runtime.h>
#import <SWMultipleDelegateProxy.h>

@class SWHeadScaleableScrollViewInnerDelegate;

@interface UIScrollView ()

@property (nonatomic,strong) SWHeadScaleableScrollViewInnerDelegate *innerSWHeadScaleableScrollViewDelegate;
@property (nonatomic,strong) SWMultipleDelegateProxy *innerSWHeadScaleableScrollViewMultipleDelegateProxy;
@property (nonatomic) CGRect sw_scaleableHeadViewOriginalFrame;

@end

@interface SWHeadScaleableScrollViewInnerDelegate : NSObject<UIScrollViewDelegate>

@end

@implementation SWHeadScaleableScrollViewInnerDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.sw_scaleableHeadView == nil) return;
    if(scrollView.sw_scaleableHeadView == nil) return;
    CGFloat fixedOffsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    CGRect frame = scrollView.sw_scaleableHeadView.frame;
    if(fixedOffsetY >= 0){
        frame.origin.y = -scrollView.contentInset.top;
        frame.size.height = scrollView.sw_scaleableHeadViewOriginalFrame.size.height;
    }else{
        frame.origin.y = fixedOffsetY - scrollView.contentInset.top;
        CGFloat scale = scrollView.sw_scaleableHeadViewOriginalFrame.size.width/scrollView.sw_scaleableHeadViewOriginalFrame.size.height;
        frame.size.height = scrollView.sw_scaleableHeadViewOriginalFrame.size.height - fixedOffsetY;
        frame.size.width = scale * frame.size.height;
        frame.origin.x = - (frame.size.width - scrollView.bounds.size.width)/2.0f;
    }
    scrollView.sw_scaleableHeadView.frame = frame;
}

@end

@implementation UIScrollView (SWHeadScaleableScrollView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sysSel = @selector(setDelegate:);
        SEL mySel = @selector(sw_setDelegate:);
        Method sysMethod = class_getInstanceMethod([self class], sysSel);
        Method myMethod = class_getInstanceMethod([self class], mySel);
        if(class_addMethod([self class], sysSel, method_getImplementation(myMethod), method_getTypeEncoding(myMethod))){
            class_replaceMethod([self class], mySel, method_getImplementation(sysMethod), method_getTypeEncoding(sysMethod));
        }else{
            method_exchangeImplementations(sysMethod, myMethod);
        }
    });
}

- (void)sw_setDelegate:(id<UIScrollViewDelegate>)delegate {
    if(delegate != nil && self.sw_scaleableHeadView != nil && delegate != self.innerSWHeadScaleableScrollViewMultipleDelegateProxy && ![self.innerSWHeadScaleableScrollViewMultipleDelegateProxy.allDelegate containsObject:delegate]){
        [self.innerSWHeadScaleableScrollViewMultipleDelegateProxy setAllDelegate:@[self.innerSWHeadScaleableScrollViewDelegate,delegate]];
        [self sw_setDelegate:self.innerSWHeadScaleableScrollViewMultipleDelegateProxy];
    }else{
        [self sw_setDelegate:delegate];
    }
}

- (void)setInnerSWHeadScaleableScrollViewDelegate:(SWHeadScaleableScrollViewInnerDelegate *)innerSWHeadScaleableScrollViewDelegate {
    objc_setAssociatedObject(self, @selector(innerSWHeadScaleableScrollViewDelegate), innerSWHeadScaleableScrollViewDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SWHeadScaleableScrollViewInnerDelegate *)innerSWHeadScaleableScrollViewDelegate {
    SWHeadScaleableScrollViewInnerDelegate *delegate = objc_getAssociatedObject(self, @selector(innerSWHeadScaleableScrollViewDelegate));
    if(delegate == nil){
        delegate = [[SWHeadScaleableScrollViewInnerDelegate alloc] init];
        self.innerSWHeadScaleableScrollViewDelegate = delegate;
    }
    return delegate;
}

- (void)setSw_scaleableHeadViewOriginalFrame:(CGRect)sw_scaleableHeadViewOriginalFrame {
    objc_setAssociatedObject(self, @selector(sw_scaleableHeadViewOriginalFrame), [NSValue valueWithCGRect:sw_scaleableHeadViewOriginalFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)sw_scaleableHeadViewOriginalFrame {
    return [objc_getAssociatedObject(self, @selector(sw_scaleableHeadViewOriginalFrame)) CGRectValue];
}

- (void)setInnerSWHeadScaleableScrollViewMultipleDelegateProxy:(SWMultipleDelegateProxy *)innerSWHeadScaleableScrollViewMultipleDelegateProxy {
    objc_setAssociatedObject(self, @selector(innerSWHeadScaleableScrollViewMultipleDelegateProxy), innerSWHeadScaleableScrollViewMultipleDelegateProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SWMultipleDelegateProxy *)innerSWHeadScaleableScrollViewMultipleDelegateProxy {
    SWMultipleDelegateProxy *proxy = objc_getAssociatedObject(self, @selector(innerSWHeadScaleableScrollViewMultipleDelegateProxy));
    if(proxy == nil){
        proxy = [SWMultipleDelegateProxy new];
        self.innerSWHeadScaleableScrollViewMultipleDelegateProxy = proxy;
    }
    return proxy;
}

- (void)setSw_scaleableHeadView:(UIView *)sw_scaleableHeadView {
    if(self.sw_scaleableHeadView == sw_scaleableHeadView) return;
    if(sw_scaleableHeadView == nil) return;
    if(sw_scaleableHeadView.bounds.size.height <= 0){
        sw_scaleableHeadView.frame = CGRectMake(0, 0, self.bounds.size.width, 200);
    }
    UIEdgeInsets insets = self.contentInset;
    insets.top -= self.sw_scaleableHeadView.bounds.size.height;
    self.contentInset = insets;
    [self.sw_scaleableHeadView removeFromSuperview];
    if(sw_scaleableHeadView.superview != self){
        UIEdgeInsets insets = self.contentInset;
        insets.top += sw_scaleableHeadView.bounds.size.height;
        self.contentInset = insets;
        CGRect rect = sw_scaleableHeadView.frame;
        rect.origin = CGPointMake(0, -self.contentInset.top);
        rect.size.width = self.bounds.size.width;
        sw_scaleableHeadView.frame = rect;
        [self addSubview:sw_scaleableHeadView];
        self.sw_scaleableHeadViewOriginalFrame = sw_scaleableHeadView.frame;
    }
    objc_setAssociatedObject(self, @selector(sw_scaleableHeadView), sw_scaleableHeadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.delegate != nil && sw_scaleableHeadView != nil){
        NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:0];
        if(![self.innerSWHeadScaleableScrollViewMultipleDelegateProxy.allDelegate containsObject:self.innerSWHeadScaleableScrollViewDelegate]){
            [mutableArr addObject:self.innerSWHeadScaleableScrollViewDelegate];
        }
        [mutableArr addObjectsFromArray:self.innerSWHeadScaleableScrollViewMultipleDelegateProxy.allDelegate?:@[]];
        if(![self.innerSWHeadScaleableScrollViewMultipleDelegateProxy.allDelegate containsObject:self.delegate] && self.delegate != self.innerSWHeadScaleableScrollViewMultipleDelegateProxy){
            [mutableArr addObject:self.delegate];
        }
        [self.innerSWHeadScaleableScrollViewMultipleDelegateProxy setAllDelegate:mutableArr];
        [self sw_setDelegate:self.innerSWHeadScaleableScrollViewMultipleDelegateProxy];
    }
}

- (UIView *)sw_scaleableHeadView {
    return objc_getAssociatedObject(self, @selector(sw_scaleableHeadView));
}

@end
