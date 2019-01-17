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

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += fabs(self.horizontalSpaceBetweenTitleAndImage);
    return size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.x = 0;
    imageRect.origin.x = titleRect.size.width + self.horizontalSpaceBetweenTitleAndImage;
    self.imageView.frame = imageRect;
    self.titleLabel.frame = titleRect;
}

@end
