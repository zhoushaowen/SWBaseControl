//
//  SWLabel.m
//  BSHealthCloud
//
//  Created by zhoushaowen on 2019/1/17.
//  Copyright © 2019 B-Soft Limited. All rights reserved.
//

#import "SWLabel.h"
#import "SWBaseControl.h"

@implementation SWLabel

- (void)drawTextInRect:(CGRect)rect {
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(self.topInset, self.leftInset, self.bottomInset, self.rightInset))];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (CGSize)intrinsicContentSize {
    if(self.isHidden && !self.enableContentSizeWhenHidden) return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
    if(self.text.length < 1){
        return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
    }
    CGSize size = [super intrinsicContentSize];
    
    size.width += (self.leftInset + self.rightInset);
    size.height += (self.topInset + self.bottomInset);

    return size;
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    [self invalidateIntrinsicContentSize];
}

- (void)setEnableContentSizeWhenHidden:(BOOL)enableContentSizeWhenHidden {
    _enableContentSizeWhenHidden = enableContentSizeWhenHidden;
    [self invalidateIntrinsicContentSize];
}

- (void)setTopInset:(CGFloat)topInset {
    _topInset = topInset;
    [self invalidateIntrinsicContentSize];
}

- (void)setLeftInset:(CGFloat)leftInset {
    _leftInset = leftInset;
    [self invalidateIntrinsicContentSize];
}

- (void)setBottomInset:(CGFloat)bottomInset {
    _bottomInset = bottomInset;
    [self invalidateIntrinsicContentSize];
}

- (void)setRightInset:(CGFloat)rightInset {
    _rightInset = rightInset;
    [self invalidateIntrinsicContentSize];
}


//- (void)sizeToFit {
//    [super sizeToFit];
//    CGRect rect = self.bounds;
//    rect.size.width += (self.leftInset + self.rightInset);
//    rect.size.height += (self.topInset + self.bottomInset);
//    self.bounds = rect;
//}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize bestSize = [super sizeThatFits:size];
    if(self.text.length < 1) return bestSize;
    bestSize.width += (self.leftInset + self.rightInset);
    bestSize.height += (self.topInset + self.bottomInset);
    
    return bestSize;
}


@end
