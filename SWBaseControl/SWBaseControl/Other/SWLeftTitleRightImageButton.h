//
//  SWLeftTitleRightImageButton.h
//  Pods-SWBaseControl
//
//  Created by zhoushaowen on 2018/12/21.
//

#import "SWBaseButton.h"

typedef NS_ENUM(NSUInteger, SWLeftTitleRightImageButtonDirectionType) {
    SWLeftTitleRightImageButtonDirection,//左边是标题右边是图片
    SWLeftImageRightTitleButtonDirection,//左边是图片右边是文字
};

//IB_DESIGNABLE
@interface SWLeftTitleRightImageButton : SWBaseButton

@property (nonatomic) IBInspectable CGFloat horizontalSpaceBetweenTitleAndImage;
@property (nonatomic) IBInspectable CGFloat leftInset;
@property (nonatomic) IBInspectable CGFloat rightInset;

/// 默认左边是标题右边是图片
#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable NSInteger direction;
#else
@property (nonatomic) SWLeftTitleRightImageButtonDirectionType direction;
#endif

@end

