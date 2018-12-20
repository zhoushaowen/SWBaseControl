//
//  SWBaseTextView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/25.
//

#import "SWBaseTextView.h"

@interface SWBaseTextView ()

@property (nonatomic,strong) UILabel *label;

@end

@implementation SWBaseTextView
{
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
    [self addSubview:self.label];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self addObserver];
}

- (UILabel *)label {
    if(!_label){
        _label = [[UILabel alloc] init];
        _label.font = self.font;
        _label.numberOfLines = 0;
        _label.textColor = [UIColor colorWithWhite:0.82 alpha:1.0];
        _label.hidden = self.text.length > 0;
    }
    return _label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize bestSize = [self.label sizeThatFits:CGSizeMake(self.bounds.size.width - self.textContainerInset.left - self.textContainerInset.right - 2 * self.textContainer.lineFragmentPadding, MAXFLOAT)];
    CGFloat maxLineHeight = self.bounds.size.height - self.textContainerInset.top - self.textContainerInset.bottom;
    if(bestSize.height > maxLineHeight){
        bestSize.height = maxLineHeight;
    }
    self.label.numberOfLines = bestSize.height/self.label.font.lineHeight;
    self.label.frame = CGRectMake(0, 0, bestSize.width, bestSize.height);
    CGRect rect = self.label.frame;
    rect.origin = CGPointMake(self.textContainerInset.left + self.textContainer.lineFragmentPadding, self.textContainerInset.top);
    self.label.frame = rect;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.label.font = font;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    self.label.text = _placeholder;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    _attributedPlaceholder = [attributedPlaceholder copy];
    self.label.attributedText = _attributedPlaceholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.label.textColor = _placeholderColor;
}

- (void)addObserver {
    __weak typeof(self) weakSelf = self;
    _textDidChangeObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UITextViewTextDidChangeNotification object:self queue:nil usingBlock:^(NSNotification * _Nonnull note) {
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
    self.label.hidden = self.text.length > 0;
}

//When any text changes on textField, the delegate getter is called. At this time we refresh the textView's placeholder
- (id<UITextViewDelegate>)delegate {
    [self changeLabelStatus];
    return [super delegate];
}

- (void)dealloc {
    [self removeObserver];
}



@end
