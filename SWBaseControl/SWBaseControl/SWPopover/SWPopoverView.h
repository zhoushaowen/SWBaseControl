//
//  SWPopoverView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/26.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SWPopoverArrowDirection) {
    SWPopoverArrowDirectionTop,
    SWPopoverArrowDirectionLeft,
    SWPopoverArrowDirectionBottom,
    SWPopoverArrowDirectionRight,
};

@interface SWPopoverView : UIView<UIGestureRecognizerDelegate>

@property (nonatomic,readonly) SWPopoverArrowDirection arrowDirection;

/**
 the color of contentView include arrow,default is black
 */
@property (nonatomic,strong) UIColor *contentViewColor;

@property (nonatomic,strong) void(^popoverViewDidHidden)(void);

/**
 create a SWPopoverView

 @param contentView the view whant you want to see
 @param contentViewSize contentViewSize's width and height
 @param arrowPoint the arrow point in the screen
 @param arrowDirection arrow direction
 @param contentViewCenterOffset the contentView's center offset between arrowPoint
 @return SWPopoverView
 */
- (SWPopoverView *)initWithContentView:(UIView *)contentView contentViewSize:(CGSize)contentViewSize arrowPoint:(CGPoint)arrowPoint arrowDirection:(SWPopoverArrowDirection)arrowDirection contentViewCenterOffset:(CGFloat)contentViewCenterOffset;

- (void)showPopoverAnimated:(BOOL)isAnimated;
- (void)hidePopoverAnimated:(BOOL)isAnimated;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
