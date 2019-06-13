//
//  SWBaseTextView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/25.
//

#import "SWBaseTextView.h"
#import <SWMultipleDelegateProxy.h>
#import <RACDelegateProxy.h>
#import <RACEXTScope.h>

@class SWBaseTextViewDelegateObserver;

@interface SWBaseTextView ()

@property (nonatomic,strong) UILabel *placeholderLabel;
@property (nonatomic,strong) UILabel *limitLabel;
@property (nonatomic,strong) SWMultipleDelegateProxy *multipleDelegateProxy;
@property (nonatomic,strong) SWBaseTextViewDelegateObserver *delegateObserver;

- (void)updateLimitLabelStatus:(BOOL)isEditing;

@end

@interface SWBaseTextViewDelegateObserver : NSObject<UITextViewDelegate>

@property (nonatomic) IBInspectable NSInteger limitCount;
@property (nonatomic,weak) UILabel *limitLabel;
@property (nonatomic) SWBaseTextViewLimitLabelViewMode limitLabelViewMode;
@property (nonatomic,weak) SWBaseTextView *textView;

@end

@implementation SWBaseTextViewDelegateObserver

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        if(self.textView.didClickReturnKeyBlock){
            self.textView.didClickReturnKeyBlock();
        }
        return NO;
    }
    if(self.limitCount < 0) return YES;
    NSString *replacedText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if(replacedText.length > self.limitCount) return NO;
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.textView updateLimitLabelStatus:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self.textView updateLimitLabelStatus:NO];
}

- (void)dealloc {
}

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
    if(self.delegate == nil){
        self.delegate = self.multipleDelegateProxy;
    }
    self.limitCount = -1;
    self.limitLabelRightInset = 8;
    self.limitLabelBottomInset = 8;
    self.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.placeholderLabel];
    [self addSubview:self.limitLabel];
    [self updateLimitLabelStatus:self.isFirstResponder];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self addObserver];
}

- (SWMultipleDelegateProxy *)multipleDelegateProxy {
    if(!_multipleDelegateProxy){
        _multipleDelegateProxy = [[SWMultipleDelegateProxy alloc] init];
        [_multipleDelegateProxy setAllDelegate:@[self.delegateObserver]];
    }
    return _multipleDelegateProxy;
}

- (SWBaseTextViewDelegateObserver *)delegateObserver {
    if(!_delegateObserver){
        _delegateObserver = [[SWBaseTextViewDelegateObserver alloc] init];
        _delegateObserver.limitLabel = self.limitLabel;
        _delegateObserver.limitLabelViewMode = self.limitLabelViewMode;
        _delegateObserver.textView = self;
    }
    return _delegateObserver;
}

- (UILabel *)placeholderLabel {
    if(!_placeholderLabel){
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.font = self.font;
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.textColor = [UIColor colorWithWhite:0.82 alpha:1.0];
        _placeholderLabel.hidden = self.text.length > 0;
    }
    return _placeholderLabel;
}

- (UILabel *)limitLabel {
    if(!_limitLabel){
        _limitLabel = [[UILabel alloc] init];
        _limitLabel.font = self.font;
        _limitLabel.textColor = [UIColor colorWithWhite:0.82 alpha:1.0];
        _limitLabel.text = [NSString stringWithFormat:@"%@/%@",@(self.text.length),@(self.limitCount)];
        _limitLabel.hidden = YES;
    }
    return _limitLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize bestSize = [self.placeholderLabel sizeThatFits:CGSizeMake(self.bounds.size.width - self.textContainerInset.left - self.textContainerInset.right - 2 * self.textContainer.lineFragmentPadding, MAXFLOAT)];
    CGFloat maxLineHeight = self.bounds.size.height - self.textContainerInset.top - self.textContainerInset.bottom;
    if(bestSize.height > maxLineHeight){
        bestSize.height = maxLineHeight;
    }
    self.placeholderLabel.numberOfLines = bestSize.height/self.placeholderLabel.font.lineHeight;
    self.placeholderLabel.frame = CGRectMake(0, 0, bestSize.width, bestSize.height);
    CGRect rect = self.placeholderLabel.frame;
    rect.origin = CGPointMake(self.textContainerInset.left + self.textContainer.lineFragmentPadding, self.textContainerInset.top);
    self.placeholderLabel.frame = rect;
    [self.limitLabel sizeToFit];
    [self updateLimitLabelFrame];
}

- (void)updateLimitLabelFrame {
    CGRect limitLabelFrame = self.limitLabel.frame;
    limitLabelFrame.origin.x = self.bounds.size.width - limitLabelFrame.size.width - self.limitLabelRightInset;
    limitLabelFrame.origin.y = self.bounds.size.height - limitLabelFrame.size.height - self.limitLabelBottomInset;
    self.limitLabel.frame = limitLabelFrame;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderLabel.font = font;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = _placeholder;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    _attributedPlaceholder = [attributedPlaceholder copy];
    self.placeholderLabel.attributedText = _attributedPlaceholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = _placeholderColor;
}

- (void)setLimitCount:(NSInteger)limitCount {
    _limitCount = limitCount;
    self.delegateObserver.limitCount = limitCount;
    self.limitLabel.text = [NSString stringWithFormat:@"%@/%@",@(self.text.length),@(self.limitCount)];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setLimitLabelRightInset:(CGFloat)limitLabelRightInset {
    _limitLabelRightInset = limitLabelRightInset;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setLimitLabelBottomInset:(CGFloat)limitLabelBottomInset {
    _limitLabelBottomInset = limitLabelBottomInset;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setLimitLabelFont:(UIFont *)limitLabelFont {
    _limitLabelFont = limitLabelFont;
    self.limitLabel.font = limitLabelFont;
}

- (void)setLimitLabelTextColor:(UIColor *)limitLabelTextColor {
    _limitLabelTextColor = limitLabelTextColor;
    self.limitLabel.textColor = limitLabelTextColor;
}

- (void)setLimitLabelViewMode:(SWBaseTextViewLimitLabelViewMode)limitLabelViewMode {
    _limitLabelViewMode = limitLabelViewMode;
    [self updateLimitLabelStatus:self.isFirstResponder];
}

- (void)updateLimitLabelStatus:(BOOL)isEditing {
    if(self.limitCount < 0) {
        self.limitLabel.hidden = YES;
        return;
    }
    switch (self.limitLabelViewMode) {
        case SWBaseTextViewLimitLabelViewModeWhileEditing:
        {
            self.limitLabel.hidden = !isEditing;
        }
            break;
        case SWBaseTextViewLimitLabelViewModeAlways:
        {
            self.limitLabel.hidden = NO;
        }
            break;
        case SWBaseTextViewLimitLabelViewModeNever:
        {
            self.limitLabel.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

- (void)addObserver {
    @weakify(self)
    _textDidChangeObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UITextViewTextDidChangeNotification object:self queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        @strongify(self)
        if(note.object != self) return;
        [self changeLabelStatus];
    }];
}

- (void)removeObserver {
    if(_textDidChangeObserver){
        [[NSNotificationCenter defaultCenter] removeObserver:_textDidChangeObserver];
        _textDidChangeObserver = nil;
    }
}

- (void)changeLabelStatus {
    self.placeholderLabel.hidden = self.text.length > 0;
    self.limitLabel.text = [NSString stringWithFormat:@"%@/%@",@(self.text.length),@(self.limitCount)];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

//When any text changes on textField, the delegate getter is called. At this time we refresh the textView's placeholder
- (id<UITextViewDelegate>)delegate {
    [self changeLabelStatus];
    return [super delegate];
}

- (void)setDelegate:(id<UITextViewDelegate>)delegate {
    if(delegate != self.multipleDelegateProxy && delegate != nil && delegate != self){
        [self.multipleDelegateProxy setAllDelegate:@[self.delegateObserver,delegate]];
    }
    if(delegate == nil){
        [super setDelegate:nil];
        return;
    }
    [super setDelegate:self.multipleDelegateProxy];
}


- (void)dealloc {
    [self removeObserver];
}



@end
