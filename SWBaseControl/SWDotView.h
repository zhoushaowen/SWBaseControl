//
//  SWDotView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/26.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SWDotViewPosition) {
    SWDotViewPositionTopRight,
    SWDotViewPositionTopLeft,
    SWDotViewPositionBottomRight,
    SWDotViewPositionBottomLeft,
};

@interface SWDotView : UIView

@property (nonatomic) SWDotViewPosition position;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGPoint offset;

- (instancetype)initWithTargetView:(UIView *)targetView;

@end

NS_ASSUME_NONNULL_END
