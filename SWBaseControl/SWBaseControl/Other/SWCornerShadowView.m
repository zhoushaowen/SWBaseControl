//
//  SWCornerShadowView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2020/4/8.
//  Copyright © 2020 zhoushaowen. All rights reserved.
//

#import "SWCornerShadowView.h"
#import <Masonry/Masonry.h>

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
        //支持直接在xib上操作
        //在xib上添加的view移动到contentView上
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj != self.contentView && obj != self.shadowView){
                [self.contentView addSubview:obj];
            }
        }];
    }
    return self;
}

- (void)config {
    self.shadowView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.shadowView];
    self.contentView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.contentView];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    self.shadowOpacity = 1.0;
    self.shadowOffset = CGSizeZero;
    self.shadowRadius = 3.0;
    self.shadowBackgroundColor = [UIColor whiteColor];
    self.shadowCornerRadius = 10.0;
    
    self.contentView.clipsToBounds = YES;
    
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    self.shadowView.frame = self.bounds;
//    self.contentView.frame = self.bounds;
//}

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

