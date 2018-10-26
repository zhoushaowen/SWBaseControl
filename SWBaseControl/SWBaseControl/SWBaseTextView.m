//
//  SWBaseTextView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/25.
//

#import "SWBaseTextView.h"

@implementation SWBaseTextView
{
    UILabel *_label;
    __weak id _textDidChangeObserver;
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if(self){
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}

- (void)setup {
    self.font = [UIFont systemFontOfSize:15];
    _label = [UILabel new];
    _label.font = self.font;
    _label.numberOfLines = 0;
    _label.textColor = [UIColor colorWithWhite:0.82 alpha:1.0];
    [self addSubview:_label];
    [self addObserver];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize bestSize = [_label sizeThatFits:CGSizeMake(self.bounds.size.width - self.textContainerInset.left - self.textContainerInset.right - 2 * self.textContainer.lineFragmentPadding, MAXFLOAT)];
    CGFloat maxLineHeight = self.bounds.size.height - self.textContainerInset.top - self.textContainerInset.bottom;
    if(bestSize.height > maxLineHeight){
        bestSize.height = maxLineHeight;
    }
    _label.numberOfLines = bestSize.height/_label.font.lineHeight;
    _label.frame = CGRectMake(0, 0, bestSize.width, bestSize.height);
    CGRect rect = _label.frame;
    rect.origin = CGPointMake(self.textContainerInset.left + self.textContainer.lineFragmentPadding, self.textContainerInset.top);
    _label.frame = rect;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _label.font = font;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    _label.text = _placeholder;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    _attributedPlaceholder = [attributedPlaceholder copy];
    _label.attributedText = _attributedPlaceholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    _label.textColor = _placeholderColor;
}

- (void)addObserver {
    __weak typeof(self) weakSelf = self;
    _textDidChangeObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UITextViewTextDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf changeLabelStatus];
    }];
}

- (void)removeObserver {
    if(_textDidChangeObserver){
        [[NSNotificationCenter defaultCenter] removeObserver:_textDidChangeObserver];
        _textDidChangeObserver = nil;
    }
}

- (void)changeLabelStatus {
    _label.hidden = self.text.length > 0;
}

- (void)dealloc {
    [self removeObserver];
}



@end
