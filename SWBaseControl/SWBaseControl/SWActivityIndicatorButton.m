//
//  SWActivityIndicatorButton.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/20.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWActivityIndicatorButton.h"

@interface SWActivityIndicatorButton ()

@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation SWActivityIndicatorButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        if(!_activityIndicatorView){
            _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [self addSubview:_activityIndicatorView];
        }
    }
    return self;
}

- (instancetype)initWithType:(UIButtonType)buttonType style:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    self = [SWActivityIndicatorButton buttonWithType:buttonType];
    if(self){
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:activityIndicatorViewStyle];
        [self addSubview:_activityIndicatorView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _activityIndicatorView.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
}

- (void)startAnimating {
    [_activityIndicatorView startAnimating];
    self.enabled = NO;
}

- (void)stopAnimating {
    [_activityIndicatorView stopAnimating];
    self.enabled = YES;
}




@end
