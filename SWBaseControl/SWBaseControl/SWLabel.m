//
//  SWLabel.m
//  BSHealthCloud
//
//  Created by zhoushaowen on 2019/1/17.
//  Copyright © 2019 B-Soft Limited. All rights reserved.
//

#import "SWLabel.h"

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
    CGSize size = [super intrinsicContentSize];
    size.width += (self.leftInset + self.rightInset);
    size.height += (self.topInset + self.bottomInset);
    return size;
}


@end