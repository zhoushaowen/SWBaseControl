//
//  SWVerticalCenterTextView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2019/5/15.
//  Copyright © 2019 zhoushaowen. All rights reserved.
// 内容垂直居中的textView

#import "SWVerticalCenterTextView.h"
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>
#import <ReactiveObjC/RACEXTScope.h>

@implementation SWVerticalCenterTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(nullable NSTextContainer *)textContainer{
    self = [super initWithFrame:frame textContainer:textContainer];
    if(self){
        [self addObserver];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        [self addObserver];
    }
    return self;
}

- (void)addObserver {
    self.textAlignment = NSTextAlignmentCenter;
    @weakify(self)
    [self rac_observeKeyPath:@"contentSize" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        @strongify(self)
        if(self.contentSize.height >= self.bounds.size.height) return;
        CGFloat inset = (self.bounds.size.height - self.contentSize.height)/2.0;
        UIEdgeInsets insets = self.contentInset;
        insets.top = inset;
        insets.bottom = inset;
        self.contentInset = insets;
    }];
}

@end
