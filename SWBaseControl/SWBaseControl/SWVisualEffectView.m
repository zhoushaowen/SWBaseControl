//
//  SWVisualEffectView.m
//  SWBaseViewController
//
//  Created by zhoushaowen on 2017/4/30.
//  Copyright © 2017年 Yidu. All rights reserved.
//

#import "SWVisualEffectView.h"

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
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:0.8];
        [_visualView.contentView addSubview:_backgroundView];
    }
    return self;
}

- (void)setSw_tintColor:(UIColor *)sw_tintColor {
    _sw_tintColor = sw_tintColor;
    if(_sw_tintColor == nil){
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:0.8];
    }else{
        _backgroundView.backgroundColor = [_sw_tintColor colorWithAlphaComponent:0.8f];
    }
}



@end
