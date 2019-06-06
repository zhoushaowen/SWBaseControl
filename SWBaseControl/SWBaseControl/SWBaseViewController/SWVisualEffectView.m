//
//  SWVisualEffectView.m
//  SWBaseViewController
//
//  Created by zhoushaowen on 2017/4/30.
//  Copyright © 2017年 Yidu. All rights reserved.
//

#import "SWVisualEffectView.h"
#import <RACEXTScope.h>

@implementation SWVisualEffectView
{
    UIVisualEffectView *_visualView;
    UIView *_backgroundView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _visualView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _visualView.frame = self.bounds;
        [self addSubview:_visualView];
        _backgroundView = [[UIView alloc] initWithFrame:_visualView.contentView.bounds];
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_visualView.contentView addSubview:_backgroundView];
        if (@available(iOS 13.0, *)) {//兼容低版本iOS
#ifdef __IPHONE_13_0 //兼容低版本XCode
            @weakify(self)
            _backgroundView.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                @strongify(self)
                if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
                    self->_visualView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
                    return [[UIColor blackColor] colorWithAlphaComponent:0.1];
                }else{
                    self->_visualView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//                    return [UIColor colorWithWhite:0.97 alpha:0.8];
                    return [[UIColor whiteColor] colorWithAlphaComponent:0.9];
                }
            }];
#endif
        } else {
            // Fallback on earlier versions
//            _backgroundView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:0.8];
            _backgroundView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        }
    }
    return self;
}

- (void)setSw_tintColor:(UIColor *)sw_tintColor {
    _sw_tintColor = sw_tintColor;
    if(_sw_tintColor == nil){
        if (@available(iOS 13.0, *)) {
#ifdef __IPHONE_13_0
            _backgroundView.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
                    return [[UIColor blackColor] colorWithAlphaComponent:0.1];
                }else{
//                    return [UIColor colorWithWhite:0.97 alpha:0.8];
                    return [[UIColor whiteColor] colorWithAlphaComponent:0.9];
                }
            }];
#endif
        } else {
            // Fallback on earlier versions
//            _backgroundView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:0.8];
            _backgroundView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        }
    }else{
        _backgroundView.backgroundColor = _sw_tintColor;
    }
}



@end
