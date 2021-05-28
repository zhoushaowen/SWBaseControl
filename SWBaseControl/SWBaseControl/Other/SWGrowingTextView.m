//
//  SWGrowingTextView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/20.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWGrowingTextView.h"
#import <objc/runtime.h>

@interface SWGrowingTextView ()<UITextViewDelegate>

@property (nonatomic,strong) SWBaseTextView *textView;
@property (nonatomic,weak) id keyboardWillShowObserver,keyboardWillHideObserver;
@property (nonatomic) CGRect originalRect;
@property (nonatomic) BOOL isKeyboardShow;

//- (void)addKeyboardObserver;
//- (void)removeKeyboardObserver;

@end

//@interface UIViewController (UIViewControllerSWGrowingTextViewExtension)
//
//@end
//
//@implementation UIViewController (UIViewControllerSWGrowingTextViewExtension)
//
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method m1 = class_getInstanceMethod([self class], @selector(viewDidAppear:));
//        Method c1 = class_getInstanceMethod([self class], @selector(SWGrowingTextView_viewDidAppear:));
//        if(class_addMethod([self class], @selector(viewDidAppear:), method_getImplementation(c1), method_getTypeEncoding(c1))){
//            class_replaceMethod([self class], @selector(SWGrowingTextView_viewDidAppear:), method_getImplementation(m1), method_getTypeEncoding(m1));
//        }else{
//            method_exchangeImplementations(m1, c1);
//        }
//
//        Method m2 = class_getInstanceMethod([self class], @selector(viewWillDisappear:));
//        Method c2 = class_getInstanceMethod([self class], @selector(SWGrowingTextView_viewWillDisappear:));
//        if(class_addMethod([self class], @selector(viewWillDisappear:), method_getImplementation(c2), method_getTypeEncoding(c2))){
//            class_replaceMethod([self class], @selector(SWGrowingTextView_viewWillDisappear:), method_getImplementation(m2), method_getTypeEncoding(m2));
//        }else{
//            method_exchangeImplementations(m2, c2);
//        }
//    });
//}
//
//- (void)SWGrowingTextView_viewDidAppear:(BOOL)animated {
//    NSArray<SWGrowingTextView *> *growingTextViews = [self findSWGrowingTextViewsWithView:self.view];
//    [growingTextViews enumerateObjectsUsingBlock:^(SWGrowingTextView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [obj addKeyboardObserver];
//    }];
//    [self SWGrowingTextView_viewDidAppear:animated];
//}
//
//- (void)SWGrowingTextView_viewWillDisappear:(BOOL)animated {
//    NSArray<SWGrowingTextView *> *growingTextViews = [self findSWGrowingTextViewsWithView:self.view];
//    [growingTextViews enumerateObjectsUsingBlock:^(SWGrowingTextView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [obj removeKeyboardObserver];
//    }];
//    [self SWGrowingTextView_viewWillDisappear:animated];
//}
//
//- (NSArray<SWGrowingTextView *> *)findSWGrowingTextViewsWithView:(UIView *)view {
//    if([view isKindOfClass:[SWGrowingTextView class]]){
//        return @[(SWGrowingTextView *)view];
//    }
//    NSMutableArray *mutableArr = [NSMutableArray arrayWithCapacity:0];
//    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if([obj isKindOfClass:[SWGrowingTextView class]]){
//            [mutableArr addObject:obj];
//        }else{
//            [mutableArr addObjectsFromArray:[self findSWGrowingTextViewsWithView:obj]];
//        }
//    }];
//    return [mutableArr copy];
//}
//
//@end


@implementation SWGrowingTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self prepare];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        [self prepare];
    }
    return self;
}

- (void)prepare {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:244/255.0 alpha:1.0];
    _textView = [[SWBaseTextView alloc] init];
    [self reset];
    _textView.layer.borderWidth = _textViewBorderWidth;
    _textView.layer.borderColor = _textViewBorderColor.CGColor;
    _textView.layer.cornerRadius = _textViewCornerRadius;
    _textView.clipsToBounds = YES;
    _textView.font = [UIFont systemFontOfSize:17];
    _textView.returnKeyType = UIReturnKeySend;
    _textView.enablesReturnKeyAutomatically = YES;
    _textView.delegate = self;
    [self addSubview:_textView];
}

- (void)reset {
    _textViewInsets = UIEdgeInsetsMake(7, 10, 7, 10);
    _topBottomBorderColor = [UIColor grayColor];
    _textViewBorderColor = [UIColor lightGrayColor];
    _textViewCornerRadius = 5.0f;
    _textViewBorderWidth = 1/[UIScreen mainScreen].scale;
    _maxNumberOfLinesToDisplay = 5;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
}

- (void)drawRect:(CGRect)rect {
    [_topBottomBorderColor set];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 1/[UIScreen mainScreen].scale;
    [bezierPath moveToPoint:CGPointZero];
    [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    [bezierPath moveToPoint:CGPointMake(0, self.bounds.size.height)];
    [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [bezierPath stroke];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _textView.frame = CGRectMake(_textViewInsets.left, _textViewInsets.top, self.bounds.size.width - _textViewInsets.left - _textViewInsets.right, self.bounds.size.height - _textViewInsets.top - _textViewInsets.bottom);
    [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length - 1, 0)];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    CGRect rect = [textView.text boundingRectWithSize:CGSizeMake(_textView.bounds.size.width - _textView.textContainerInset.left - _textView.textContainerInset.right - _textView.textContainer.lineFragmentPadding * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_textView.font} context:nil];
//    if(rect.size.height > textView.font.lineHeight){
//        textView.textContainerInset = UIEdgeInsetsZero;
//    }else{
//        textView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
//    }
    if(_maxNumberOfLinesToDisplay > 0){
        if(rect.size.height > _maxNumberOfLinesToDisplay * textView.font.lineHeight) return;
    }
    CGFloat height = rect.size.height + _textView.textContainerInset.top + _textView.textContainerInset.bottom + _textViewInsets.top + _textViewInsets.bottom;
    CGRect frame = self.frame;
    frame.origin.y = CGRectGetMaxY(frame) - height;
    frame.size.height = height;
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = frame;
        [self setNeedsLayout];
        [self layoutIfNeeded];
        [self textDidChange];
    } completion:nil];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        if([textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0){
            [self sendText];
        }
        return NO;
    }
    return YES;
}

#pragma mark - Setter
- (void)setTopBottomBorderColor:(UIColor *)topBottomBorderColor {
    _topBottomBorderColor = topBottomBorderColor;
    [self setNeedsDisplay];
}
- (void)setTextViewInsets:(UIEdgeInsets)textViewInsets {
    if(!UIEdgeInsetsEqualToEdgeInsets(_textViewInsets, textViewInsets)){
        _textViewInsets = textViewInsets;
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

#pragma mark - Public
- (void)setText:(NSString *)text {
    _textView.text = text;
    [self textViewDidChange:_textView];
}

- (void)clearText {
    _textView.text = nil;
    [self textViewDidChange:_textView];
}

#pragma mark - Private
- (void)sendText {
    if(_delegate && [_delegate respondsToSelector:@selector(growingTextView:didClickSendButtonWithText:)]){
        [_delegate growingTextView:self didClickSendButtonWithText:_textView.text];
    }
    [self clearText];
}

- (void)textDidChange {
    if(self.delegate && [self.delegate respondsToSelector:@selector(growingTextView:textDidChangeGrowingAnimations:)]){
        [self.delegate growingTextView:self textDidChangeGrowingAnimations:self.frame];
    }
}

- (void)keyboardWillShow {
    if(_delegate && [_delegate respondsToSelector:@selector(growingTextViewKeyboardWillShowAnimations:)]){
        [_delegate growingTextViewKeyboardWillShowAnimations:self];
    }
}

- (void)keyboardWillHide {
    if(_delegate && [_delegate respondsToSelector:@selector(growingTextViewKeyboardWillHideAnimations:)]){
        [_delegate growingTextViewKeyboardWillHideAnimations:self];
    }
}

- (void)addKeyboardObserver {
    [self removeKeyboardObserver];
    __weak typeof(self) weakSelf = self;
    _keyboardWillShowObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        if(!weakSelf.textView.isFirstResponder) return;
        weakSelf.isKeyboardShow = YES;
        if(CGRectEqualToRect(weakSelf.originalRect, CGRectZero)){
            weakSelf.originalRect = weakSelf.frame;
        }
        NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        NSInteger curve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        CGRect convertRect = [weakSelf.superview convertRect:weakSelf.frame toCoordinateSpace:[UIScreen mainScreen].fixedCoordinateSpace];
        CGFloat offset = [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(convertRect) - rect.size.height;
        [UIView animateWithDuration:duration animations:^{
            [UIView setAnimationCurve:curve];
            CGRect frame = weakSelf.frame;
            frame.origin.y += offset;
            weakSelf.frame = frame;
            [weakSelf keyboardWillShow];
        } completion:nil];
    }];
    _keyboardWillHideObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        if(!weakSelf.isKeyboardShow) return;
        weakSelf.isKeyboardShow = NO;
        NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        NSInteger curve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        [UIView animateWithDuration:duration animations:^{
            [UIView setAnimationCurve:curve];
            CGRect frame = weakSelf.frame;
            if(weakSelf.originalRect.origin.y >= [UIScreen mainScreen].bounds.size.height){
                frame.origin = weakSelf.originalRect.origin;
                weakSelf.frame = frame;
            }else{
                frame.origin.y = weakSelf.superview.bounds.size.height - frame.size.height;
                weakSelf.frame = frame;
            }
            [weakSelf keyboardWillHide];
        } completion:nil];
    }];
}

- (void)removeKeyboardObserver {
    if(_keyboardWillShowObserver){
        [[NSNotificationCenter defaultCenter] removeObserver:_keyboardWillShowObserver];
        _keyboardWillShowObserver = nil;
    }
    if(_keyboardWillHideObserver){
        [[NSNotificationCenter defaultCenter] removeObserver:_keyboardWillHideObserver];
        _keyboardWillHideObserver = nil;
    }
}

//- (BOOL)canBecomeFirstResponder {
//    return YES;
//}

- (BOOL)becomeFirstResponder {
    return [_textView becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    return [_textView resignFirstResponder];
}

- (BOOL)isFirstResponder {
    return [_textView isFirstResponder];
}

- (void)dealloc {
    [self removeKeyboardObserver];
}

@end
