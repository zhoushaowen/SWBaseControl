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
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.x = 0;
    imageRect.origin.x = titleRect.size.width + self.horizontalSpaceBetweenTitleAndImage;
    self.imageView.frame = imageRect;
    self.titleLabel.frame = titleRect;
    CGRect btnFrame = self.frame;
    btnFrame.size.width = titleRect.size.width + imageRect.size.width + fabs(self.horizontalSpaceBetweenTitleAndImage);
    self.frame = btnFrame;
}

@end
