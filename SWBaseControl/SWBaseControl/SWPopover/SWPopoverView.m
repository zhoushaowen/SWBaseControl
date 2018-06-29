//
//  SWPopoverView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/26.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWPopoverView.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface SWPopoverViewTouchDownGesture : UIGestureRecognizer

@end

@implementation SWPopoverViewTouchDownGesture

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if(self.state == UIGestureRecognizerStatePossible){
        self.state = UIGestureRecognizerStateRecognized;
    }
}

@end

@interface SWPopoverView ()

@property (nonatomic) SWPopoverArrowDirection arrowDirection;

@end

@implementation SWPopoverView
{
    UIView *_contentView;
    CGSize _contentViewSize;
    CGPoint _arrowPoint;
    CGFloat _contentViewCenterOffset;
    BOOL _isShow;
    BOOL _isAnimating;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithContentView:[UIView new] contentViewSize:CGSizeMake(200, 200) arrowPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, 120) arrowDirection:SWPopoverArrowDirectionTop contentViewCenterOffset:0];
}

- (instancetype)initWithContentView:(UIView *)contentView contentViewSize:(CGSize)contentViewSize arrowPoint:(CGPoint)arrowPoint arrowDirection:(SWPopoverArrowDirection)arrowDirection contentViewCenterOffset:(CGFloat)contentViewCenterOffset {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self){
        self.contentViewColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
        self.backgroundColor = [UIColor clearColor];
        SWPopoverViewTouchDownGesture *tap = [[SWPopoverViewTouchDownGesture alloc] initWithTarget:self action:@selector(tapGesture:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        self.arrowDirection = arrowDirection;
        self->_contentView = contentView;
        if(CGSizeEqualToSize(CGSizeZero, contentViewSize)){
            contentViewSize = CGSizeMake(100, 100);
        }
        switch (self.arrowDirection) {
            case SWPopoverArrowDirectionTop:
            case SWPopoverArrowDirectionBottom:
            {
                if(contentViewCenterOffset >  contentViewSize.width/2.0f - 6){
                    contentViewCenterOffset = contentViewSize.width/2.0f - 6;
                }
                if(contentViewCenterOffset < -contentViewSize.width/2.0f + 6){
                    contentViewCenterOffset = -contentViewSize.width/2.0f + 6;
                }
            }
                break;
            case SWPopoverArrowDirectionLeft:
            case SWPopoverArrowDirectionRight:
            {
                if(contentViewCenterOffset >  contentViewSize.height/2.0f - 6){
                    contentViewCenterOffset = contentViewSize.height/2.0f - 6;
                }
                if(contentViewCenterOffset < -contentViewSize.height/2.0f + 6){
                    contentViewCenterOffset = -contentViewSize.height/2.0f + 6;
                }
            }
                break;
                
            default:
                break;
        }
        self->_contentViewCenterOffset = contentViewCenterOffset;
        self->_arrowPoint = arrowPoint;
        self->_contentViewSize = contentViewSize;
        contentView.backgroundColor = self.contentViewColor;
        [self addSubview:contentView];
        [self setContentViewFrame];
    }
    return self;
}

- (void)setContentViewFrame {
    switch (self.arrowDirection) {
        case SWPopoverArrowDirectionLeft:
        {
            _contentView.frame = CGRectMake(_arrowPoint.x + 9, _arrowPoint.y - _contentViewSize.height/2.0f + _contentViewCenterOffset, _contentViewSize.width, _contentViewSize.height);
        }
            break;
        case SWPopoverArrowDirectionRight:
        {
            _contentView.frame = CGRectMake(_arrowPoint.x - 9 - _contentViewSize.width, _arrowPoint.y - _contentViewSize.height/2.0f + _contentViewCenterOffset, _contentViewSize.width, _contentViewSize.height);
        }
            break;
        case SWPopoverArrowDirectionTop:
        {
            _contentView.frame = CGRectMake(_arrowPoint.x - _contentViewSize.width/2.0 + _contentViewCenterOffset, _arrowPoint.y + 9, _contentViewSize.width, _contentViewSize.height);
        }
            break;
        case SWPopoverArrowDirectionBottom:
        {
            _contentView.frame = CGRectMake(_arrowPoint.x - _contentViewSize.width/2.0 + _contentViewCenterOffset, _arrowPoint.y - 9 - _contentViewSize.height, _contentViewSize.width, _contentViewSize.height);
        }
            break;
            
        default:
            break;
    }
}

- (void)drawRect:(CGRect)rect {
    [self.contentViewColor set];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:_arrowPoint];
    switch (self.arrowDirection) {
        case SWPopoverArrowDirectionLeft:
        {
            [bezierPath addLineToPoint:CGPointMake(_arrowPoint.x + 9, _arrowPoint.y - 6)];
            [bezierPath addLineToPoint:CGPointMake(_arrowPoint.x + 9, _arrowPoint.y + 6)];
        }
            break;
        case SWPopoverArrowDirectionRight:
        {
            [bezierPath addLineToPoint:CGPointMake(_arrowPoint.x - 9, _arrowPoint.y - 6)];
            [bezierPath addLineToPoint:CGPointMake(_arrowPoint.x - 9, _arrowPoint.y + 6)];
        }
            break;
        case SWPopoverArrowDirectionTop:
        {
            [bezierPath addLineToPoint:CGPointMake(_arrowPoint.x - 6, _arrowPoint.y + 9)];
            [bezierPath addLineToPoint:CGPointMake(_arrowPoint.x + 6, _arrowPoint.y + 9)];
        }
            break;
        case SWPopoverArrowDirectionBottom:
        {
            [bezierPath addLineToPoint:CGPointMake(_arrowPoint.x - 6, _arrowPoint.y - 9)];
            [bezierPath addLineToPoint:CGPointMake(_arrowPoint.x + 6, _arrowPoint.y - 9)];
        }
            break;
            
        default:
            break;
    }
    [bezierPath closePath];
    [bezierPath fill];
}

- (void)setContentViewColor:(UIColor *)contentViewColor {
    _contentViewColor = contentViewColor;
    [self setNeedsDisplay];
}

- (void)showPopoverAnimated:(BOOL)isAnimated {
    if(_isShow) return;
    if(_isAnimating) return;
    _isShow = YES;
    _isAnimating = YES;
    if(self.superview == nil){
        [[[UIApplication sharedApplication].delegate window] addSubview:self];
    }
    switch (self.arrowDirection) {
        case SWPopoverArrowDirectionLeft:
        {
            CGFloat percent = 0;
            if(_arrowPoint.y >= CGRectGetMaxY(_contentView.frame) - 6){
                percent = ((_arrowPoint.y + 6) - _contentView.frame.origin.y)/_contentViewSize.height;
            }else if (_arrowPoint.x <= CGRectGetMinY(_contentView.frame) + 6){
                percent = ((_arrowPoint.y - 6) - _contentView.frame.origin.y)/_contentViewSize.height;
            }else{
                percent = (_arrowPoint.y - _contentView.frame.origin.y)/_contentViewSize.height;
            }
            _contentView.layer.anchorPoint = CGPointMake(0, percent);
            _contentView.layer.position = CGPointMake(_contentView.center.x - _contentViewSize.width/2.0f, _contentView.center.y + (percent - 0.5) * _contentViewSize.height);
        }
            break;
        case SWPopoverArrowDirectionRight:
        {
            CGFloat percent = 0;
            if(_arrowPoint.y >= CGRectGetMaxY(_contentView.frame) - 6){
                percent = ((_arrowPoint.y + 6) - _contentView.frame.origin.y)/_contentViewSize.height;
            }else if (_arrowPoint.x <= CGRectGetMinY(_contentView.frame) + 6){
                percent = ((_arrowPoint.y - 6) - _contentView.frame.origin.y)/_contentViewSize.height;
            }else{
                percent = (_arrowPoint.y - _contentView.frame.origin.y)/_contentViewSize.height;
            }
            _contentView.layer.anchorPoint = CGPointMake(1, percent);
            _contentView.layer.position = CGPointMake(_contentView.center.x + _contentViewSize.width/2.0f, _contentView.center.y + (percent - 0.5) * _contentViewSize.height);
        }
            break;
        case SWPopoverArrowDirectionTop:
        {
            CGFloat percent = 0;
            if(_arrowPoint.x >= CGRectGetMaxX(_contentView.frame) - 6){
                percent = ((_arrowPoint.x + 6) - _contentView.frame.origin.x)/_contentViewSize.width;
            }else if (_arrowPoint.x <= CGRectGetMinX(_contentView.frame) + 6){
                percent = ((_arrowPoint.x - 6) - _contentView.frame.origin.x)/_contentViewSize.width;
            }else{
                percent = (_arrowPoint.x - _contentView.frame.origin.x)/_contentViewSize.width;
            }
            _contentView.layer.anchorPoint = CGPointMake(percent, 0);
            _contentView.layer.position = CGPointMake(_contentView.center.x + (percent - 0.5)*_contentViewSize.width, _contentView.center.y - _contentViewSize.height/2.0f);
        }
            break;
        case SWPopoverArrowDirectionBottom:
        {
            CGFloat percent = 0;
            if(_arrowPoint.x >= CGRectGetMaxX(_contentView.frame) - 6){
                percent = ((_arrowPoint.x + 6) - _contentView.frame.origin.x)/_contentViewSize.width;
            }else if (_arrowPoint.x <= CGRectGetMinX(_contentView.frame) + 6){
                percent = ((_arrowPoint.x - 6) - _contentView.frame.origin.x)/_contentViewSize.width;
            }else{
                percent = (_arrowPoint.x - _contentView.frame.origin.x)/_contentViewSize.width;
            }
            _contentView.layer.anchorPoint = CGPointMake(percent, 1);
            _contentView.layer.position = CGPointMake(_contentView.center.x + (percent - 0.5)*_contentViewSize.width, _contentView.center.y + _contentViewSize.height/2.0f);
        }
            break;
            
        default:
            break;
    }
    _contentView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    self.alpha = 0.0;
    [UIView animateWithDuration:isAnimated ? 0.2f : 0.0 animations:^{
        self->_contentView.transform = CGAffineTransformIdentity;
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        self->_isAnimating = NO;
    }];
}

- (void)hidePopoverAnimated:(BOOL)isAnimated {
    if(_isAnimating) return;
    if(!_isShow) return;
    _isAnimating = YES;
    [UIView animateWithDuration:isAnimated ? 0.2f : 0.0 animations:^{
        self->_contentView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self->_isShow = NO;
        self->_isAnimating = NO;
        if(self.popoverViewDidHidden){
            self.popoverViewDidHidden();
        }
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(touch.view != self) return NO;
    return YES;
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture {
    [self hidePopoverAnimated:YES];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
