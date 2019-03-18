//
//  SWLeftTitleRightImageButton.m
//  Pods-SWBaseControl
//
//  Created by zhoushaowen on 2018/12/21.
//

#import "SWLeftTitleRightImageButton.h"

@implementation SWLeftTitleRightImageButton

- (void)setHorizontalSpaceBetweenTitleAndImage:(CGFloat)horizontalSpaceBetweenTitleAndImage {
    _horizontalSpaceBetweenTitleAndImage = horizontalSpaceBetweenTitleAndImage;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setLeftInset:(CGFloat)leftInset {
    _leftInset = leftInset;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setRightInset:(CGFloat)rightInset {
    _rightInset = rightInset;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += fabs(self.horizontalSpaceBetweenTitleAndImage) + fabs(self.leftInset) + fabs(self.rightInset);
    return size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.x = self.leftInset;
    imageRect.origin.x = self.leftInset + titleRect.size.width + self.horizontalSpaceBetweenTitleAndImage;
    self.imageView.frame = imageRect;
    self.titleLabel.frame = titleRect;
}

@end
