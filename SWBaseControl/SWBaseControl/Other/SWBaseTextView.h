//
//  SWBaseTextView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/25.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SWBaseTextViewLimitLabelViewMode) {
    SWBaseTextViewLimitLabelViewModeWhileEditing,
    SWBaseTextViewLimitLabelViewModeAlways,
    SWBaseTextViewLimitLabelViewModeNever,
};

@interface SWBaseTextViewDelegateObserver : NSObject<UITextViewDelegate>

@end

@interface SWBaseTextView : UITextView

@property (nonatomic,readonly,strong) SWBaseTextViewDelegateObserver *delegateObserver;

@property (nonatomic,copy) IBInspectable NSString *placeholder;
/**
 the color of placeholder text
 */
@property (nonatomic,strong)IBInspectable UIColor *placeholderColor;
@property (nonatomic,copy) NSAttributedString *attributedPlaceholder;
@property (nonatomic,strong) void(^didClickReturnKeyBlock)(void);

#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable NSInteger limitLabelViewMode;
#else
@property (nonatomic) SWBaseTextViewLimitLabelViewMode limitLabelViewMode;
#endif
/**
 default is -1,means no limit
 */
@property (nonatomic) IBInspectable NSInteger limitCount;
/**
 default is nil
 */
@property (nonatomic,strong) UIFont *limitLabelFont;
/**
 default is nil
 */
@property (nonatomic,strong) IBInspectable UIColor *limitLabelTextColor;
/**
 the space between right,default is 8
 */
@property (nonatomic) IBInspectable CGFloat limitLabelRightInset;
/**
 the space between bottom,default is 8
 */
@property (nonatomic) IBInspectable CGFloat limitLabelBottomInset;

@property (nonatomic,strong) void(^textDidEndEditing)(NSString *text,NSNotification *noti);
@property (nonatomic,strong) void(^textDidChange)(NSString *text,NSNotification *noti);
@property (nonatomic,strong) void(^textDidBeginEditing)(NSNotification *noti);


@end
