//
//  SWBaseTextField.m
//  ZhuHaiSocialAPP
//
//  Created by zhoushaowen on 2019/7/18.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import "SWBaseTextField.h"
#import <ReactiveObjC.h>

@implementation SWBaseTextField

- (CGRect)borderRectForBounds:(CGRect)bounds {
    if(self.borderRectForBounds){
        return self.borderRectForBounds([super borderRectForBounds:bounds],bounds);
    }
    return [super borderRectForBounds:bounds];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    if(self.textRectForBounds){
        return self.textRectForBounds([super textRectForBounds:bounds],bounds);
    }
    return [super textRectForBounds:bounds];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    if(self.placeholderRectForBounds){
        return self.placeholderRectForBounds([super placeholderRectForBounds:bounds],bounds);
    }
    return [super placeholderRectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    if(self.editingRectForBounds){
        return self.editingRectForBounds([super editingRectForBounds:bounds],bounds);
    }
    return [super editingRectForBounds:bounds];
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    if(self.clearButtonRectForBounds){
        return self.clearButtonRectForBounds([super clearButtonRectForBounds:bounds],bounds);
    }
    return [super clearButtonRectForBounds:bounds];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    if(self.leftViewRectForBounds){
        return self.leftViewRectForBounds([super leftViewRectForBounds:bounds],bounds);
    }
    return [super leftViewRectForBounds:bounds];
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    if(self.rightViewRectForBounds){
        return self.rightViewRectForBounds([super rightViewRectForBounds:bounds],bounds);
    }
    return [super rightViewRectForBounds:bounds];
}

- (void)drawTextInRect:(CGRect)rect {
    if(self.drawTextInRect){
        self.drawTextInRect(rect);
        return;
    }
    [super drawTextInRect:rect];
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    if(self.drawPlaceholderInRect){
        self.drawPlaceholderInRect(rect);
        return;
    }
    [super drawPlaceholderInRect:rect];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self addObserver];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
        [self addObserver];
    }
    return self;
}

- (void)commonInit {
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)addObserver {
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextFieldTextDidEndEditingNotification object:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        if(self.textDidEndEditing) self.textDidEndEditing(self.text,x);
    }];
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextFieldTextDidChangeNotification object:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        if(self.textDidChange) self.textDidChange(self.text,x);
    }];
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextFieldTextDidBeginEditingNotification object:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        if(self.textDidBeginEditing) self.textDidBeginEditing(x);
    }];
}

//- (void)dealloc
//{
//    NSLog(@"%s",__func__);
//}

@end
