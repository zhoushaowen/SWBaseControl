//
//  SWCornerShadowView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2020/4/8.
//  Copyright © 2020 zhoushaowen. All rights reserved.
//

#import "SWCornerShadowView.h"

@interface SWCornerShadowView ()

@property (nonatomic,strong) UIView *shadowView;
@property (nonatomic,strong) UIView *contentView;

@end

@implementation SWCornerShadowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    self.shadowView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.shadowView];
//    self.shadowView.translatesAutoresizingMaskIntoConstraints = NO;
//    if (@available(iOS 9.0, *)) {
//        [[self.shadowView.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
//        [[self.shadowView.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
//        [[self.shadowView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
//        [[self.shadowView.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
//    } else {
//        // Fallback on earlier versions
//    }
    
    self.contentView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.contentView];
//    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
//    if (@available(iOS 9.0, *)) {
//        [[self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
//        [[self.contentView.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
//        [[self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
//        [[self.contentView.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
//    } else {
//        // Fallback on earlier versions
//    }
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.shadowColor = [UIColor blackColor];
    self.shadowOpacity = 0.5;
    self.shadowOffset = CGSizeMake(0.0, -3.0);
    self.shadowRadius = 3.0;
    self.shadowBackgroundColor = [UIColor whiteColor];
    self.shadowCornerRadius = 10.0;
    
    self.contentView.clipsToBounds = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.shadowView.frame = self.bounds;
    self.contentView.frame = self.bounds;
}

#pragma mark - Setter
- (void)setShadowCornerRadius:(CGFloat)shadowCornerRadius {
    _shadowCornerRadius = shadowCornerRadius;
    self.shadowView.layer.cornerRadius = shadowCornerRadius;
    self.contentView.layer.cornerRadius = shadowCornerRadius;
}

- (void)setShadowBackgroundColor:(UIColor *)shadowBackgroundColor {
    _shadowBackgroundColor = shadowBackgroundColor;
    self.shadowView.backgroundColor = shadowBackgroundColor;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    _shadowColor = shadowColor;
    self.shadowView.layer.shadowColor = shadowColor.CGColor;
}

- (void)setShadowOpacity:(float)shadowOpacity {
    _shadowOpacity = shadowOpacity;
    self.shadowView.layer.shadowOpacity = shadowOpacity;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    _shadowOffset = shadowOffset;
    self.shadowView.layer.shadowOffset = shadowOffset;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    _shadowRadius = shadowRadius;
    self.shadowView.layer.shadowRadius = shadowRadius;
}



@end
