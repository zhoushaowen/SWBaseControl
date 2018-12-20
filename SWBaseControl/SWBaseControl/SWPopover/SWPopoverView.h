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

@property (nonatomic,readonly) CGSize contentViewSize;

/**
 designated initializer

 @param contentView the view whant you want to see
 @param contentViewSize contentViewSize's width and height
 @param arrowPoint the arrow point in the screen
 @param arrowDirection arrow direction
 @param contentViewCenterOffset the contentView's center offset between arrowPoint
 @return SWPopoverView
 */
- (instancetype)initWithContentView:(UIView *)contentView contentViewSize:(CGSize)contentViewSize arrowPoint:(CGPoint)arrowPoint arrowDirection:(SWPopoverArrowDirection)arrowDirection contentViewCenterOffset:(CGFloat)contentViewCenterOffset NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)showAnimated:(BOOL)isAnimated;
- (void)hideAnimated:(BOOL)isAnimated;


@end
