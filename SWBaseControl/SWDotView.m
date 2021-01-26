//
//  SWDotView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/26.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import "SWDotView.h"

@interface SWDotView ()

@end

@implementation SWDotView

- (instancetype)initWithTargetView:(UIView *)targetView {
    self = [super initWithFrame:CGRectZero];
    if(self){
        self.width = 5;
        self.position = SWDotViewPositionTopRight;
        self.color = [UIColor redColor];
        [targetView addSubview:self];
        [self setNeedsLayout];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect superViewBounds = self.superview.bounds;
    CGRect frame = self.frame;
    CGSize size = CGSizeMake(self.width, self.width);
    switch (self.position) {
        case SWDotViewPositionTopRight:
        {
            //当superview的layout改变的时候不会触发SWDotView的layoutSubviews 通过设置autoresizingMask保持边距跟着改变
            self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
            frame.origin.x = superViewBounds.size.width - size.width - self.offset.x;
            frame.origin.y = self.offset.y;
            frame.size = size;
        }
            break;
        case SWDotViewPositionTopLeft:
        {
            self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
            frame.origin.x = self.offset.x;
            frame.origin.y = self.offset.y;
            frame.size = size;
        }
            break;
        case SWDotViewPositionBottomRight:
        {
            self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
            frame.origin.x = superViewBounds.size.width - size.width - self.offset.x;
            frame.origin.y = superViewBounds.size.height - size.height - self.offset.y;
            frame.size = size;
        }
            break;
        case SWDotViewPositionBottomLeft:
        {
            self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
            frame.origin.x = self.offset.x;
            frame.origin.y = superViewBounds.size.height - size.height - self.offset.y;
            frame.size = size;
        }
            break;
            
        default:
            break;
    }
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    _width = width;
    self.layer.cornerRadius = width/2.0f;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.backgroundColor = color;
}

- (void)setPosition:(SWDotViewPosition)position {
    _position = position;
    [self setNeedsLayout];
}

- (void)setOffset:(CGPoint)offset {
    _offset = offset;
    [self setNeedsLayout];
}


@end
