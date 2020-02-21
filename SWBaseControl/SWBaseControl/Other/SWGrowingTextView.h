//
//  SWGrowingTextView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/20.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWBaseTextView.h>

@class SWGrowingTextView;

@protocol SWGrowingTextViewDelegate <NSObject>

/**
 when click send button SWGrowingTextView will clear text
 */
- (void)growingTextView:(SWGrowingTextView *)growingTextView didClickSendButtonWithText:(NSString *)sendText;
/**
 if text change the SWGrowingTextView will change it's frame.
 do animations in this delegate callback.
 */
- (void)growingTextView:(SWGrowingTextView *)growingTextView textDidChangeGrowingAnimations:(CGRect)frame;
/**
 do animations in this delegate callback.
 */
- (void)growingTextViewKeyboardWillShowAnimations:(SWGrowingTextView *)growingTextView;
/**
 do animations in this delegate callback.
 */
- (void)growingTextViewKeyboardWillHideAnimations:(SWGrowingTextView *)growingTextView;


@end

@interface SWGrowingTextView : UIView

/**
 init subviews
 */
- (void)prepare NS_REQUIRES_SUPER;

@property (nonatomic,readonly,strong) SWBaseTextView *textView;

@property (nonatomic,weak) id<SWGrowingTextViewDelegate> delegate;

- (void)addKeyboardObserver;
- (void)removeKeyboardObserver;

/**
 don't change the textView's frame immediately,using this property.
 */
@property (nonatomic) UIEdgeInsets textViewInsets;
/**
 the SWGrowingTextView top and bottom border Color.
 */
@property (nonatomic) UIColor *topBottomBorderColor;
@property (nonatomic) UIColor *textViewBorderColor;
@property (nonatomic) CGFloat textViewCornerRadius;
@property (nonatomic) CGFloat textViewBorderWidth;

/**
 max number of text lines to display,default is 5,if 0 means no limit.
 */
@property (nonatomic) NSUInteger maxNumberOfLinesToDisplay;
- (void)setText:(NSString *)text;
- (void)clearText;

@end





