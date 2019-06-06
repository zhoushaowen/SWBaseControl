//
//  SWBaseTextView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/25.
//

#import <UIKit/UIKit.h>

@interface SWBaseTextView : UITextView

@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,copy) NSAttributedString *attributedPlaceholder;
/**
 the color of placeholder text
 */
@property (nonatomic,strong) UIColor *placeholderColor;

@end
