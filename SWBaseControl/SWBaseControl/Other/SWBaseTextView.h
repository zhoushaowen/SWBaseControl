//
//  SWBaseTextView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/25.
//

#import <UIKit/UIKit.h>

@interface SWBaseTextView : UITextView

@property (nonatomic,copy) IBInspectable NSString *placeholder;
/**
 the color of placeholder text
 */
@property (nonatomic,strong)IBInspectable UIColor *placeholderColor;
@property (nonatomic,copy) NSAttributedString *attributedPlaceholder;

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


@end
